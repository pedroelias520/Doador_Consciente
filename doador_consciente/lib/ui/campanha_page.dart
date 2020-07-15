import 'package:doador_consciente/helpers/user_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:scoped_model/scoped_model.dart';

class CampanhaPage extends StatefulWidget {
  @override
  _CampanhaPageState createState() => _CampanhaPageState();
}

class _CampanhaPageState extends State<CampanhaPage> {
  final nameController = TextEditingController();
  final receptorController = TextEditingController();
  final bolsasController = TextEditingController();
  final descricaoController = TextEditingController();
  final bolsas_minimasController = TextEditingController();
  final _nameFocus = FocusNode();
  File _image;
  File _banner;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: ScopedModelDescendant<UserModel>(
        builder: (context, builder, model) {
          if (model.isLodding)
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            );
          return PageView(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    margin: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("images/person.png"),
                                    fit: BoxFit.cover,
                                    repeat: ImageRepeat.noRepeat)),
                          ),
                          onTap: (){},
                        ),
                        Text(
                          "Nome do receptor",
                          style: TextStyle(fontFamily: 'UbuntuB', fontSize: 20),
                          textAlign: TextAlign.center,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 5,top: 10),
                          child: Container(
                            width: 350,
                            child: TextField(
                              focusNode: _nameFocus,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  labelText: "Nome da campanha",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0))),
                              controller: nameController,
                              style: TextStyle(fontFamily: 'UbuntuB'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            width: 350,
                            child: TextField(
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  labelText: "Nome do receptor",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0))),
                              controller: receptorController,
                              style: TextStyle(fontFamily: 'UbuntuB'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            width: 350,
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  labelText: "Quantidade de bolsas necessárias",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0))),
                              controller: bolsasController,
                              style: TextStyle(fontFamily: 'UbuntuB'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            width: 350,
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  labelText: "Quantidade mínima de bolsas",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0))),
                              controller: bolsas_minimasController,
                              style: TextStyle(fontFamily: 'UbuntuB'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            width: 350,
                            child: TextField(
                              maxLines: 15,
                              controller: descricaoController,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  labelText: 'Descrição de campanha',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0))),
                              style: TextStyle(fontFamily: 'UbuntuB'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Colors.red,
                              onPressed: () async {
                              String ImageURL = await model.saveImage(_image);
                              String BannerURL = await model.saveImage(_banner);
                              String nome_criador = await model.userData['name'];
                              String data_criacao = DateTime.now().toString();
                              Map<String,dynamic> campanha = {
                                "nome_campanha" : nameController.text,
                                "receptor_campanha" : receptorController.text,
                                "bolsas_campanha" : bolsasController.text,
                                "descricao" : descricaoController.text,
                                "bolsas_minimas" : bolsas_minimasController.text,
                                "img": ImageURL,
                                "banner" :BannerURL,
                                "nome_criador": nome_criador,
                                "data_criacao": data_criacao,
                                "aberta": true
                              };
                              model.saveCampanha(campanha, model.firebaseUser);
                              },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            child: Text("Submeter",style: TextStyle(color: Colors.white,fontFamily: 'UbuntuB'),),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
