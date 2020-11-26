import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doador_consciente/helpers/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'campanha_page.dart';
import 'campanha_page_list.dart';
import 'home_page.dart';
import 'home_page_receptor.dart';
import 'login_screen.dart';
import 'matches_page.dart';

class ChooseScreen extends StatefulWidget {
  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, builder, model) {
        String url_image="https://media2.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.gif";
        if (model.isLodding)
          return Center(
            child: CircularProgressIndicator(),
          );
        return PageView(
          children: <Widget>[
            Scaffold(
                backgroundColor: Colors.red,
                body: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    Center(
                      heightFactor: 1.0,
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(model.userData['img'].toString()) == null ? Icon(Icons.person) : NetworkImage("https://www.google.com/url?sa=i&url=http%3A%2F%2Fvisitebalneariocamboriu.com.br%2Fperson-icon%2F&psig=AOvVaw0VLzN3gyNq0uR6bjZVvF-b&ust=1606395691582000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCPCBkLbgne0CFQAAAAAdAAAAABAN"),
                            radius: 90,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(width: 15,height: 3.5,decoration: BoxDecoration(color: Colors.white),),
                          ),
                          Text(
                            "Bem-Vindo!",
                            style: TextStyle(
                                fontFamily: "Delighter",
                                fontSize: 50,
                                color: Colors.white),
                          ),
                          Text(model.userData['name'],
                              style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'UbuntuB')),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Oque deseja fazer hoje?",
                              style: TextStyle(
                                  fontFamily: "UbuntuB",
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CampanhaPage()));
                            },
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Cadastrar Campanha",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "UbuntuB"),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CampanhaPageList()));
                            },
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Participar de um campanha",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "UbuntuB"),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePageReceptor()));
                            },
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Quero doar",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "UbuntuB"),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Quero receber",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "UbuntuB"),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MatchesPage()));
                            },
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Matches!",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "UbuntuB"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Notificações",style: TextStyle(color: Colors.white,fontFamily: 'UbuntuB'),),
                          ),
                          StreamBuilder(
                              stream: Firestore.instance
                                  .collection("Users")
                                  .document(model.userData['id'])
                                  .collection("Noficações")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError)
                                  return new Text("Error:${snapshot.error}");
                                if (snapshot.data.documents.isEmpty)
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Sem noticações disponíveis...",style: TextStyle(color: Colors.white,fontFamily: 'UbuntuB'),),
                                    ),
                                  );
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return new Row(
                                      children: <Widget>[
                                        Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      ],
                                    );
                                  default:
                                    return SizedBox(
                                        child: ListView(
                                            children: snapshot.data.documents
                                                .map((document) {
                                      return GestureDetector(
                                        child: Card(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                document['name'],
                                                style:
                                                    TextStyle(color: Colors.white),
                                              ),
                                              Text(
                                                document['email'],
                                                style:
                                                    TextStyle(color: Colors.white),
                                              ),
                                              Text(
                                                document['msg'],
                                                style:
                                                    TextStyle(color: Colors.white),
                                              ),
                                              Text(
                                                document['data_envio'],
                                                style:
                                                    TextStyle(color: Colors.white),
                                              ),
                                              RaisedButton(
                                                onPressed: () {},
                                                color: Colors.lightGreen,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                child: document['aceito'] ==
                                                            false &&
                                                        document['id_remente'] !=
                                                            model.firebaseUser.uid
                                                    ? Text("Aceitar")
                                                    : Text("Pedente..."),
                                              ),
                                              FlatButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Cancelar",
                                                    style: TextStyle(
                                                        fontFamily: 'UbuntuB',
                                                        fontStyle: FontStyle.normal,
                                                        fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList()));
                                }
                              })
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
