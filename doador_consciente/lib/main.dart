import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doador_consciente/ui/AboutPage.dart';
import 'package:doador_consciente/ui/Choose_screen.dart';
import 'package:doador_consciente/ui/campanha_page.dart';
import 'package:doador_consciente/ui/campanha_page_list.dart';
import 'package:doador_consciente/ui/home_page.dart';
import 'package:doador_consciente/ui/login_screen.dart';
import 'package:doador_consciente/ui/select_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'helpers/user_model.dart';

void main() {
  Firestore.instance.collection("Test").document().setData({"name":"Pedro"});
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String url = "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQrNTowqMvp8qy_V4l59PIFaDtE5IZ5e2lfmnufEbgH5AHhDlFy";
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
/*
    this.name = name;
    this.email = email;
    this.phone = phone;
    this.tipo_sangue = tipo_sangue;
    this.localizacao = localizacao;
    this.qtd_bolsas = qtd_bolsas;
    this.tipo = tipo;
    this.unidade_hospitalar = unidade_hospitalar;
    this.img = img;

 */