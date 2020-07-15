import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doador_consciente/helpers/user_model.dart';
import 'package:doador_consciente/ui/select_campanha_page.dart';
import 'package:doador_consciente/ui/select_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:scoped_model/scoped_model.dart';

class CampanhaPageList extends StatefulWidget {
  @override
  _CampanhaPageListState createState() => _CampanhaPageListState();
}

class _CampanhaPageListState extends State<CampanhaPageList> {
  String nome_user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(170, 48, 48, 1),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, builder, model) {
          nome_user = model.userData['name'];
          if (model.isLodding)
            return Center(
              child: CircularProgressIndicator(),
            );
          return PageView(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      ))
                ],
              ),
              ListView(
                children: <Widget>[
                  ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) {
                        return _CardUsers(context);
                      }),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _CardUsers(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          double lenght = snapshot.data.documents.length.truncateToDouble() * 200;
          if (!snapshot.hasData)
            return Center(
              child: Text(
                'Sem campanhas disponíveis',
                style: TextStyle(color: Colors.white),
              ),
            );
          if (snapshot.hasError) return new Text('Error :${snapshot.error}');
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
              return new SizedBox(
                height: lenght,
                child: ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                  return GestureDetector(
                    child: Card(
                      margin: EdgeInsets.all(5),
                      color: Color.fromRGBO(62, 57, 98, 1),
                      child: Container(
                        height: 120,
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: new NetworkImage(
                                        document['img'].toString()),
                                    repeat: ImageRepeat.noRepeat,
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.all(10.0),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    AutoSizeText(
                                      document['nome_campanha'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'UbuntuM',
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      document['receptor_campanha'],
                                      style: TextStyle(
                                          fontFamily: 'UbuntuM',
                                          color:
                                              Color.fromRGBO(124, 124, 188, 1)),
                                      textAlign: TextAlign.right,
                                    ),
                                    Text(
                                      document['bolsas_campanha'],
                                      style: TextStyle(
                                          fontFamily: 'UbuntuM',
                                          color:
                                              Color.fromRGBO(124, 124, 188, 1)),
                                      textAlign: TextAlign.right,
                                    ),
                                    Text(
                                      document['bolsas_minimas'],
                                      style: TextStyle(
                                        fontFamily: 'UbuntuM',
                                        color: Color.fromRGBO(124, 124, 188, 1),
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      print("=" * 150);
                      print("Você Clicou lá : ${document['nome_campanha']}");
                      print("=" * 150);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectCampanhaPage(
                                  document['nome_campanha'],
                                  document['receptor_campanha'],
                                  document['bolsas_campanha'],
                                  document['descricao'],
                                  document['bolsas_minimas'],
                                  document['img'],
                                  document['banner'],
                                  document['nome_criador'],
                                  document['data_criacao'],
                                  document['id']
                              )));
                    },
                  );
                }).toList()),
              );
          }
        });
  }
}
