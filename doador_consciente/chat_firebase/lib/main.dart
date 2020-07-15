import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  //Somente uma leitura (não em tempo real)
  //QuerySnapshot snapshot = await Firestore.instance.collection("usuarios").getDocuments();
//modificação em tempo real
  Firestore.instance.collection("Mensagens").snapshots().listen((snapshot) {
    for (DocumentSnapshot doc in snapshot.documents) {
      print("-----------------------------------------------------");
      print(doc.data);
      print(doc.documentID);
      print("-----------------------------------------------------");
    }
  });

  runApp(MyApp());
}

final ThemeData kIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light);
final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

final googleSignIn = GoogleSignIn();
final auth = FirebaseAuth.instance; //instância variável de login no aplicativo

Future<Null> _ensureLoggedIn() async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null) {
    //se o usuário não estiver logado
    user = await googleSignIn.signInSilently();
  }
  if (user == null) {
    //se o usuário continuar nulo
    user = await googleSignIn.signIn();
  }
  if (await auth.currentUser() == null) {
    //pega o usuário autenticado e autentica dentro do Firebase
    GoogleSignInAuthentication credentials =
        await googleSignIn.currentUser.authentication;
    await auth.signInWithCredential(GoogleAuthProvider.getCredential(
        //acesso de Firebase a banco de dados do Google
        idToken: credentials.idToken,
        accessToken: credentials.accessToken));
  }
}

_handleSubmited(String text) async {
  //pega o texto para envia-lo para o banco de dados
  await _ensureLoggedIn(); //função não instantânea
  _sendMessage(text: text);
}

void _sendMessage({String text, String imgUrl}) {
  //criação de campos baseados em mapas ,para enviar pro Firebase
  Firestore.instance
      .collection("messages")
      .add(//define as coleções e adiciona os campos
          {
    "text": text,
    "imgUrl": imgUrl,
    "senderName": googleSignIn.currentUser.displayName,
    "senderPhotoUrl": googleSignIn.currentUser.photoUrl
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).platform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat Bar"),
          centerTitle: true,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                  stream:
                      Firestore.instance.collection("messagens").snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        ); //Center
                      default:
                        ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              List r =
                                  snapshot.data.documents.reversed.toList();
                              return ChatMessage(r[index].data);
                            });
                    }
                  }), //refaz a árvore de widgets quando há uma atualização
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: TextComposer(),
            )
          ],
        ),
      ),
    );
  }
}

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final _textcontroller = TextEditingController();
  bool _isComposing = false;

  void _reset() {
    _textcontroller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200])))
            : null,
        child: Row(
          children: <Widget>[
            Container(
              child: IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () async {
                    await _ensureLoggedIn();
                    File imgFile =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                    if (imgFile == null) return;
                    StorageUploadTask task = FirebaseStorage.instance
                        .ref()
                        .child(googleSignIn.currentUser.id.toString() + DateTime.now().millisecondsSinceEpoch.toString()) //dá o nome ao arquivo de foto com o id do usuário +data e hora em milisegundos
                        .putFile(imgFile);//coloca no servidor
                    StorageTaskSnapshot taskSnapshot = await task.onComplete;
                    String url = await taskSnapshot.ref.getDownloadURL();
                    _sendMessage(imgUrl: url);
                  }),
            ),
            Expanded(
                child: TextField(
              controller: _textcontroller,
              decoration:
                  InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.length > 0;
                });
              },
              onSubmitted: (text) {
                _handleSubmited(text);
                _reset();
              },
            )),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? CupertinoButton(
                        child: Text("Enviar"),
                        onPressed: _isComposing
                            ? () {
                                _handleSubmited(_textcontroller.text);
                                _reset();
                              }
                            : null,
                      )
                    : IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _isComposing
                            ? () {
                                _handleSubmited(_textcontroller.text);
                                _reset();
                              }
                            : null))
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatefulWidget {
  ChatMessage(this.data);
  final Map<String, dynamic> data;
  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  String url =
      "https://www-cinemascomics-com.exactdn.com/wp-content/uploads/2018/06/capitan-america-look-vengadores-4-640x761.jpg?strip=all&lossy=1&ssl=1";
  get data => null;

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      //Define uma margem para o elemento de container(Siméttrico para todos os lados)
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, //deixa os itens alinhados a esquerda
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              //Avatar em circulo

              backgroundImage: NetworkImage(
                  data["senderPhotoUrl"]), //pega imagem da internet
            ),
          ),
          Expanded(
            //cria uma estrutura que pega toda a tela e se adapta ao tamanho
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data["senderName"],
                  style: Theme.of(context).textTheme.subhead,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: data["imgUrl"] != null
                      ? Image.network(
                          data["imgUrl"],
                          width: 250.0,
                        )
                      : Text(data["text"]), //6:03
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
