import 'dart:async';
import 'dart:io';

import 'package:doador_consciente/helpers/contact_helper.dart';
import 'package:doador_consciente/helpers/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Choose_screen.dart';
import 'home_page.dart';
import 'login_screen.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts = List();
  List<Contact> contacts2 = List();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _localizacaoController = TextEditingController();
  final _necessidadeController = TextEditingController();
  final _passController = TextEditingController();
  final dataController = TextEditingController();
  final _nameFocus = FocusNode();
  final _unidadeController = TextEditingController();
  int _groupValue = 0, _groupValue2 = 0;
  bool _userEdited = false, doador = null, habilitacao = false;
  Contact _editedContact;
  String tipo_sangue, tipo_pessoa;
  final Color activecolor = Colors.red;
  File _image;

  Future getImage(verification) async {
    try {
      if (verification) {
        var img = await ImagePicker.pickImage(source: ImageSource.gallery);
        await setState(() {
          _image = img;
        });
        return _image;
      } else {
        var img = await ImagePicker.pickImage(source: ImageSource.camera);
        await setState(() {
          _image = img;
        });
        return _image;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.red)),
          backgroundColor: Colors.red,
          title: Text(
            "Novo Doador ou Paciente",
            style: TextStyle(color: Colors.red, fontFamily: "UbuntuB"),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.white, Colors.white70],
              ),
            ),
          ),
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, builder, model) {
            if (model.isLodding)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              );
            return SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: _image != null
                                ? FileImage(_image)
                                : AssetImage("images/person.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    onTap: () {
                      getImage(true);
                    },
                  ),
                  Container(
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: _nameController,
                      focusNode: _nameFocus,
                      decoration: InputDecoration(
                          labelText: "Nome",
                          icon: Icon(
                            Icons.person,
                            color: Colors.red,
                          )),
                      onChanged: (text) {
                        _userEdited = true;
                        setState(() {
                          _editedContact.name = text;
                        });
                      },
                    ),
                  ),
                  Container(
                    child: TextField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      cursorColor: Colors.white,
                      controller: _passController,
                      decoration: InputDecoration(
                          labelText: "Senha",
                          icon: Icon(
                            Icons.confirmation_number,
                            color: Colors.red,
                          )),
                      onChanged: (text) {
                        _userEdited = true;
                        setState(() {
                          _editedContact.name = text;
                        });
                      },
                    ),
                  ),
                  Container(
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: "Email",
                          icon: Icon(
                            Icons.email,
                            color: Colors.red,
                          )),
                      onChanged: (text) {
                        _userEdited = true;
                        _editedContact.email = text;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: _phoneController,
                      decoration: InputDecoration(
                          labelText: "Phone",
                          icon: Icon(
                            Icons.phone,
                            color: Colors.red,
                          )),
                      onChanged: (text) {
                        _userEdited = true;
                        _editedContact.phone = text;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Tipo de Sangue:",
                        textAlign: TextAlign.left,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "A+",
                          style: TextStyle(fontFamily: "UbuntuB"),
                        ),
                        Radio(
                          activeColor: activecolor,
                          value: 1,
                          groupValue: _groupValue2,
                          onChanged: (int e) => tipoSangue(e),
                        ),
                        Text(
                          "A-",
                          style: TextStyle(fontFamily: "UbuntuB"),
                        ),
                        Radio(
                          activeColor: activecolor,
                          value: 2,
                          groupValue: _groupValue2,
                          onChanged: (int e) => tipoSangue(e),
                        ),
                        Text(
                          "B+",
                          style: TextStyle(fontFamily: "UbuntuB"),
                        ),
                        Radio(
                          activeColor: activecolor,
                          value: 3,
                          groupValue: _groupValue2,
                          onChanged: (int e) => tipoSangue(e),
                        ),
                        Text(
                          "B-",
                          style: TextStyle(fontFamily: "UbuntuB"),
                        ),
                        Radio(
                          activeColor: activecolor,
                          value: 4,
                          groupValue: _groupValue2,
                          onChanged: (int e) => tipoSangue(e),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "AB+",
                          style: TextStyle(fontFamily: "UbuntuB"),
                        ),
                        Radio(
                          activeColor: activecolor,
                          value: 5,
                          groupValue: _groupValue2,
                          onChanged: (int e) => tipoSangue(e),
                        ),
                        Text(
                          "AB-",
                          style: TextStyle(fontFamily: "UbuntuB"),
                        ),
                        Radio(
                          activeColor: activecolor,
                          value: 6,
                          groupValue: _groupValue2,
                          onChanged: (int e) => tipoSangue(e),
                        ),
                        Text(
                          "O+",
                          style: TextStyle(fontFamily: "UbuntuB"),
                        ),
                        Radio(
                          activeColor: activecolor,
                          value: 7,
                          groupValue: _groupValue2,
                          onChanged: (int e) => tipoSangue(e),
                        ),
                        Text(
                          "O-",
                          style: TextStyle(fontFamily: "UbuntuB"),
                        ),
                        Radio(
                          activeColor: activecolor,
                          value: 8,
                          groupValue: _groupValue2,
                          onChanged: (int e) => tipoSangue(e),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: _localizacaoController,
                      decoration: InputDecoration(
                          labelText: "Região",
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.red,
                          )),
                      onChanged: (text) {
                        _userEdited = true;
                        _editedContact.localizacao = text;
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.datetime,
                      controller: dataController,
                      decoration: InputDecoration(
                          labelText: "Ultima doação realizada",
                          icon: Icon(
                            Icons.date_range,
                            color: Colors.red,
                          )),
                    ),
                  ),
                  Container(
                    child: TextField(
                      cursorColor: Colors.white,
                      enabled: habilitacao,
                      controller: _necessidadeController,
                      decoration: InputDecoration(
                          labelText: "Quantidade de Bolsas",
                          icon: Icon(
                            Icons.storage,
                            color: Colors.red,
                          )),
                      onChanged: (text) {
                        _userEdited = true;
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    child: TextField(
                      cursorColor: Colors.white,
                      enabled: habilitacao,
                      controller: _unidadeController,
                      decoration: InputDecoration(
                          labelText: "Unidade Hospitalar",
                          icon: Icon(
                            Icons.local_hospital,
                            color: Colors.red,
                          )),
                      onChanged: (text) {
                        _userEdited = true;
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Doador",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17.0,
                            fontFamily: "UbuntuB"),
                      ),
                      Radio(
                        activeColor: activecolor,
                        value: 1,
                        groupValue: _groupValue,
                        onChanged: (int e) => tipoDoador(e),
                      ),
                      Text("Paciente",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17.0,
                              fontFamily: "UbuntuB")),
                      Radio(
                        activeColor: activecolor,
                        value: 2,
                        groupValue: _groupValue,
                        onChanged: (int e) => tipoDoador(e),
                      ),
                    ],
                  ),
                  RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        "Submeter",
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'UbuntuB'),
                      ),
                      onPressed: () async {

                        String id_generated = await model.GenerateId();
                        String FileURL = await model.saveImage(_image);
                        DateTime now = DateTime.now();
                        String formattedDate = DateFormat('dd-MM-yyyy').format(now);

                        Map<String, dynamic> userData = {
                          "id": id_generated,
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "phone": _phoneController.text,
                          "tipo_sangue": tipo_sangue,
                          "localizacao": _localizacaoController.text,
                          "qtd_bolsas": _necessidadeController.text,
                          "tipo": tipo_pessoa,
                          "unidade_hospital": _unidadeController.text,
                          "img": FileURL.toString(),
                          "data_doacao": dataController.text,
                          "data_criacao": formattedDate.toString(),
                        };
                        model.SignUp(
                            userData: userData,
                            pass: _passController.text,
                            onsucess: _onSucess,
                            onFail: _onFail);
                      })
                ],
              ),
            );
          },
        ));
  }

  void showLoginPage({Contact contact, BuildContext context}) async {
    final recContact = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void tipoDoador(int e) {
    setState(() {
      if (e == 1) {
        tipo_pessoa = 'Doador';
        _groupValue = e;
        habilitacao = false;
      } else if (e == 2) {
        tipo_pessoa = 'Paciente';
        _groupValue = e;
        habilitacao = true;
      }
    });
  }

  void tipoSangue(int e) {
    setState(() {
      if (e == 1) {
        String a_posi = "A+";
        tipo_sangue = a_posi;
        _groupValue2 = e;
      }
      if (e == 2) {
        String a_neg = "A-";
        tipo_sangue = a_neg;
        _groupValue2 = e;
      }
      if (e == 3) {
        String b_posi = "B+";
        tipo_sangue = b_posi;
        _groupValue2 = e;
      }
      if (e == 4) {
        String b_neg = "B-";
        tipo_sangue = b_neg;
        _groupValue2 = e;
      }
      if (e == 5) {
        String ab_posi = "AB+";
        tipo_sangue = ab_posi;
        _groupValue2 = e;
      }
      if (e == 6) {
        String ab_neg = "AB-";
        tipo_sangue = ab_neg;
        _groupValue2 = e;
      }
      if (e == 7) {
        String o_posi = "O+";
        tipo_sangue = o_posi;
        _groupValue2 = e;
      }
      if (e == 8) {
        String o_neg = "O-";
        tipo_sangue = o_neg;
        _groupValue2 = e;
      }
    });
  }

  void _onSucess() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _onFail() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Erro de Cadastro"),
            content: new Text("Alguns campos podem estar errados"),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text("Ok!"))
            ],
          );
        });
  }
}
