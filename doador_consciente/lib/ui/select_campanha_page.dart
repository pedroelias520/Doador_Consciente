import 'package:doador_consciente/helpers/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:scoped_model/scoped_model.dart';

class SelectCampanhaPage extends StatefulWidget {
  String nome_campanha,
      receptor_campanha,
      bolsas_campanha,
      descricao,
      bolsas_minimas,
      img,
      banner,
      nome_criador,
      data_criacao,
      id;
  SelectCampanhaPage(nome_campanha, receptor_campanha, bolsas_campanha,
      descricao, bolsas_minimas, img, banner, nome_criador, data_criacao,id) {
    this.nome_campanha = nome_campanha;
    this.receptor_campanha = receptor_campanha;
    this.bolsas_campanha = bolsas_campanha;
    this.descricao = descricao;
    this.bolsas_minimas = bolsas_minimas;
    this.img = img;
    this.banner = banner;
    this.nome_criador = nome_criador;
    this.data_criacao = data_criacao;
    this.id = id;
  }
  @override
  _SelectCampanhaPageState createState() => _SelectCampanhaPageState(
      nome_campanha,
      receptor_campanha,
      bolsas_campanha,
      descricao,
      bolsas_minimas,
      img,
      banner,
      nome_criador,
      data_criacao,
      id);
}

class _SelectCampanhaPageState extends State<SelectCampanhaPage> {
  String nome_campanha,
      receptor_campanha,
      bolsas_campanha,
      descricao,
      bolsas_minimas,
      img,
      banner,
      nome_criador,
      data_criacao,
      id;
  _SelectCampanhaPageState(nome_campanha, receptor_campanha, bolsas_campanha, descricao, bolsas_minimas, img, banner, nome_criador, data_criacao,id) {
    this.nome_campanha = nome_campanha;
    this.receptor_campanha = receptor_campanha;
    this.bolsas_campanha = bolsas_campanha;
    this.descricao = descricao;
    this.bolsas_minimas = bolsas_minimas;
    this.img = img;
    this.banner = banner;
    this.nome_criador = nome_criador;
    this.data_criacao = data_criacao;
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<UserModel>(
        builder: (context, builder, model) {
          if (model.isLodding)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Container(
              child: PageView(
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
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  color: Colors.redAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          nome_campanha,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontFamily: 'UbuntuB'),
                                        ),
                                        Text(
                                          receptor_campanha,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'UbuntuB',
                                              fontSize: 20),
                                        ),
                                        Text(
                                          bolsas_campanha,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'UbuntuB',
                                              fontSize: 15),
                                        ),
                                        Text(
                                          bolsas_minimas,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'UbuntuB',
                                              fontSize: 15),
                                        ),
                                        Text(
                                          data_criacao,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'UbuntuB',
                                              fontSize: 15),
                                        ),
                                        Text(
                                          nome_criador,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'UbuntuB',
                                              fontSize: 15),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            if (model.userData['name'] == nome_criador)
                                              RaisedButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "Finalizar Campanha",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                              ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            RaisedButton(
                                onPressed: () {
                                    model.EnterCampanha(id);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                color: Colors.lightGreen,
                                child: Text("Quero participar"))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );
  }
}
