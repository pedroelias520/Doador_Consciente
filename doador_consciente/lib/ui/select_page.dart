import 'package:auto_size_text/auto_size_text.dart';
import 'package:doador_consciente/helpers/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:scoped_model/scoped_model.dart';

class SelectPage extends StatefulWidget {
  String name,
      email,
      phone,
      tipo_sangue,
      localizacao,
      qtd_bolsas,
      tipo,
      unidade_hospitalar,
      img,
      id;
  SelectPage(name, email, phone, tipo_sangue, localizacao, qtd_bolsas, tipo,
      unidade_hospitalar, img,id) {
    this.name = name;
    this.email = email;
    this.phone = phone;
    this.tipo_sangue = tipo_sangue;
    this.localizacao = localizacao;
    this.qtd_bolsas = qtd_bolsas;
    this.tipo = tipo;
    this.unidade_hospitalar = unidade_hospitalar;
    this.img = img;
    this.id = id;
  }
  @override
  _SelectPageState createState() => _SelectPageState(name, email, phone,
      tipo_sangue, localizacao, qtd_bolsas, tipo, unidade_hospitalar, img, id);
}

class _SelectPageState extends State<SelectPage> {
  String name,
      email,
      phone,
      tipo_sangue,
      localizacao,
      qtd_bolsas,
      tipo,
      unidade_hospitalar,
      img,
      id;
  Map<String, dynamic> mensagem;
  _SelectPageState(name, email, phone, tipo_sangue, localizacao, qtd_bolsas,
      tipo, unidade_hospitalar, img, id) {
    this.name = name;
    this.email = email;
    this.phone = phone;
    this.tipo_sangue = tipo_sangue;
    this.localizacao = localizacao;
    this.qtd_bolsas = qtd_bolsas;
    this.tipo = tipo;
    this.unidade_hospitalar = unidade_hospitalar;
    this.img = img;
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, builder, model) {
        if (model.isLodding)
          return Center(
            child: CircularProgressIndicator(),
          );
        return PageView(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  height: 800,
                  color: Color.fromRGBO(170, 48, 48, 1),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 35,
                                ))
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(img),
                                  repeat: ImageRepeat.noRepeat,
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                    color: Colors.redAccent,
                                    style: BorderStyle.solid,
                                    width: 6.0)),
                          ),
                          Center(
                            heightFactor: 1.5,
                            child: Container(
                              width: 400,
                              child: Card(
                                margin: EdgeInsets.all(5.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                color: Colors.redAccent,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontFamily: 'UbuntuB'),
                                      ),
                                      Text(
                                        tipo,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'UbuntuB',
                                            fontSize: 20),
                                      ),
                                      Text(
                                        tipo_sangue,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'UbuntuB',
                                            fontSize: 15),
                                      ),
                                      Text(
                                        unidade_hospitalar,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'UbuntuB',
                                            fontSize: 15),
                                      ),
                                      Text(
                                        localizacao,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'UbuntuB',
                                            fontSize: 15),
                                      ),
                                      Text(
                                        email,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'UbuntuB',
                                            fontSize: 15),
                                      ),
                                      Text(
                                        id,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'UbuntuB',
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              switch (tipo) {
                                case "Paciente":
                                   //Deve pegar do mapa da função,é um token de quem vai receber
                                  var user =
                                      model.firebaseUser; //token de quem envia
                                  setState(() {
                                    mensagem = {
                                      "name": name,
                                      "tipo_sangue": tipo_sangue,
                                      "email": email,
                                      "msg": "Olá estou disposto a doar para você",
                                      "aceito": false,
                                      "data_envio": DateTime.now(),
                                      "id_rementente:" : id
                                    };
                                  });
                                  model.SendNotification(model.firebaseUser.uid,id, mensagem);
                                  break;
                                case "Doador":
                                  FirebaseUser reciver_Firebase; //Deve pegar do mapa da função,é um token de quem vai receber
                                  var user = model.firebaseUser; //token de quem envia
                                  setState(() {
                                    Map<String, dynamic> mensagem = {
                                      "name": name,
                                      "tipo_sangue": tipo_sangue,
                                      "email": email,
                                      "msg": "Olá eu queria te pedir ajuda,você pode doar pra mim?",
                                      "aceito": false,
                                      "data_envio": DateTime.now(),
                                      "id_remetente" : id
                                    };
                                  });
                                  model.SendNotification(model.firebaseUser.uid, id , mensagem);
                                  break;
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            color: Colors.white,
                            child: tipo == 'Paciente'
                                ? Text(
                                    "Doar",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20.0,
                                        fontFamily: 'UbuntuB'),
                                  )
                                : Text(
                                    "Pedir doação",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20.0,
                                        fontFamily: 'UbuntuB'),
                                  ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
