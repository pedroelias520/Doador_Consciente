import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:random_string/random_string.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

final CollectionReference myCollection = Firestore.instance.collection('Users');

class UserModel extends Model {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance; //sigleton pra não precisa instancia toda vez
  FirebaseUser firebaseUser; //definicao de usuario
  AuthResult firebase_user;
  Firestore database;
  String name_user;
  String email_user;
  String PhotoUrl_user;
  Map<String, dynamic> userData = Map();
  bool isLodding = false;
  BuildContext get context => null;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
  }

  void SignUp({
    @required Map<String, dynamic> userData,
    @required String pass,
    @required VoidCallback onsucess,
    @required VoidCallback onFail,
  }) {
    isLodding = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(email: userData["email"], password: pass).then((user) async {
      await _saveUserData(userData, user);
      onsucess();
      isLodding = false;
      notifyListeners();
    }).catchError((e) {
      print("-" * 150);
      print("Erro de chamada : " + e.toString());
      print("-" * 150);
      onFail();

      isLodding = false;
      notifyListeners();
    });
  }

  void SignIn(@required String email, @required String pass,
      VoidCallback onSucess, VoidCallback onFail) async {
    isLodding = true;
    notifyListeners(); //atualiza a pagina
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: email, password: pass)).user;
      print(user);
      DocumentSnapshot docUser = await Firestore.instance.collection("Users").document(user.uid).get();
      firebaseUser = user;
      userData = docUser.data;
      debugPrint(userData.toString());
      //await _loadCurrentUser();
      onSucess();
      isLodding = false;
      notifyListeners();
    } catch (e) {
      onFail();
      print("-" * 150);
      print("Error : ${e.toString()}");
      print("Error Number: ${e.hashCode}");
      print("Error Type: ${e.runtimeType}");
      print("-" * 150);
      isLodding = false;
      notifyListeners();
    }
  }
  Future<String> GenerateId() async {
    String id_number = "";
    Random gerador = new Random();
    for (int i=0;i<4;i++){
      for (int x=0;x<4;x++){
        var number = gerador.nextInt(9);
        id_number = id_number.toString() + number.toString();
      }
      if(i<3){
        id_number = id_number + " ";
      }
    }
    List list_of_ids = (await Firestore.instance.collection("Users").where("id", arrayContains: id_number).getDocuments()).documents;
    if(list_of_ids.isEmpty){
      return id_number;
    }
    else{
      GenerateId();
    }
  }

  Future<String> GenerateCampanhaId() async {
    String id_number = "";
    Random gerador = new Random();
    for (int i=0;i<5;i++){
      for (int x=0;x<5;x++){
        var number = gerador.nextInt(9);
        id_number = id_number.toString() + number.toString();
      }
      if(i<4){
        id_number = id_number + " ";
      }
    }
    List list_of_ids = (await Firestore.instance.collection("Campanhas").where("id", arrayContains: id_number).getDocuments()).documents;
    if(list_of_ids.isEmpty){
    return id_number;
    }
    else{
    GenerateId();
    }
  }

  List<UserModel> getUserList() {
    List items;
    Firestore.instance
        .collection("Users")
        .document(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot ds) {
      print(ds);
    });
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }


  Future<Null> _loadCurrentUser() async {
    try {
      if (firebaseUser == null) {
        firebaseUser = await _auth.currentUser();
        print(
            "Usuário Autenticado: ${firebaseUser.email} | ${firebaseUser.displayName} | ${firebaseUser.uid} | ${firebaseUser.photoUrl}");
      }
      if (firebaseUser != null) {
        if (userData["name"] == null) {
          DocumentSnapshot docUser = await Firestore.instance
              .collection("Users")
              .document("admin")
              .get();
          userData = docUser.data;
          print("-" * 150);
          print("Usuário: ${docUser.data}");
          print("-" * 150);
        }
      }
      notifyListeners();
    } catch (e) {
      print("=" * 150);
      print("Erro ao carregar o usuário atual: ${e.toString()}");
      print("=" * 150);
    }
  }

  Future<Null> _saveUserData(@required Map<String, dynamic> userData, @required AuthResult user) async {
    this.userData = userData;
    Firestore.instance.collection("Users").document(user.user.uid).setData(userData);
  }
  Future<Null> saveCampanha(@required Map<String, dynamic> userData, @required FirebaseUser user) async {
    this.userData = userData;
    Firestore.instance.collection("Campanhas").document(userData['id']).setData(userData);
  }

  Future<dynamic> saveImage(@required dynamic image) async {
    try {
      String fileName = 'images/${DateTime.now()}.png';
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print("-" * 150);
      print("Erro na mandagem de imagem : " + e.toString());
      print("-" * 150);
    }
  }
  void SendNotification(@required String sender,@required String reciver,@required Map<String,dynamic> notification){
    //Enviar notificação para remetente
    Firestore.instance.collection('Users').document(sender).collection("Notificações").document().setData(notification);
    //Enviar notificação pra recepetor
    Firestore.instance.collection('Users').document(reciver).collection("Notificações").document(reciver).setData(notification);
  }
  void EnterCampanha(@required id){
    Map<String,dynamic> map = {
    "name" : userData['name'],
    "tipo_sangue": userData['tipo_sangue'],
    "localizacao": userData['localizacao'],
    "email": userData['email']
    };
    Firestore.instance.collection('Campanhas').document(id).collection("Persons").document().setData(map);
  }
}
