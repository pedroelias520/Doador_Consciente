import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doador_consciente/helpers/contact_helper.dart';
import 'package:doador_consciente/ui/select_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AboutPage.dart';
import 'Choose_screen.dart';
import 'contact_page.dart';
import 'login_screen.dart';

enum OrderOptions { orderaz, orderza }

class HomePage extends StatefulWidget {
  final Contact contact;
  HomePage({this.contact});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  PageController _pageController;
  int _page = 0;
  double fontsz = 16.0;
  List<Contact> contacts = List();
  List<Contact> contacts2 = List();

  @override
  void initState() {
    super.initState();
    _getAllContacts();
    _getAllPacients();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChooseScreen()));
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.red,
            )),
        title: Text(
          "Bem-Vindo",
          style: TextStyle(fontFamily: "UbuntuB", color: Colors.red),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.red,
            ),
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text(
                  "Ordenar de A-Z",
                  style: TextStyle(fontFamily: "UbuntuB"),
                ),
                value: OrderOptions.orderaz,
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text(
                  "Ordenar de Z-A",
                  style: TextStyle(fontFamily: "UbuntuB"),
                ),
                value: OrderOptions.orderza,
              ),
            ],
            onSelected: _orderList,
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.white, Colors.white],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.red,
      body: PageView(
        onPageChanged: (p) {
          setState(() {
            _page = p;
          });
        },
        controller: _pageController,
        children: <Widget>[
          ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return _CardUsers(context);
              }),
          AboutPage(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
            primaryColor: Colors.white,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.white))),
        child: BottomNavigationBar(
            currentIndex: _page,
            onTap: (p) {
              _pageController.animateToPage(p,
                  duration: Duration(microseconds: 500), curve: Curves.ease);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                  title: Text(
                    "Doadores",
                    style: TextStyle(fontFamily: "UbuntuB", color: Colors.red),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.info,
                    color: Colors.red,
                  ),
                  title: Text(
                    "Informações",
                    style: TextStyle(fontFamily: "UbuntuB", color: Colors.red),
                  ))
            ]),
      ),
    );
  }

  Widget _CardUsers(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Users').where("tipo",isEqualTo: "Doador").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          double lenght = snapshot.data.documents.length.truncateToDouble() * 200;
          if(snapshot.data == null) new Text('Sem dados ...');
          if (snapshot.hasError) new Text('Error :${snapshot.error}');
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
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      if(snapshot.data.documents.isNotEmpty) return new Center(child: new Text('Sem dados...'));
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
                                          document['name'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'UbuntuM',
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                        Text(
                                          document['area_atuacao'],
                                          style: TextStyle(
                                              fontFamily: 'UbuntuM',
                                              color:
                                              Color.fromRGBO(124, 124, 188, 1)),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          document['area_experiencia'],
                                          style: TextStyle(
                                              fontFamily: 'UbuntuM',
                                              color:
                                              Color.fromRGBO(124, 124, 188, 1)),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          document['email'],
                                          style: TextStyle(
                                            fontFamily: 'UbuntuM',
                                            color: Color.fromRGBO(124, 124, 188, 1),
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          document['tipo'],
                                          style: TextStyle(
                                            fontFamily: 'UbuntuM',
                                            color: Color.fromRGBO(124, 124, 188, 1),
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          document['tipo'],
                                          style: TextStyle(
                                            fontFamily: 'UbuntuM',
                                            color: Color.fromRGBO(124, 124, 188, 1),
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          document['tipo'],
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
                          print("="*150);
                          print("Você Clicou lá : ${document['name']}");
                          print("="*150);
                          Navigator.push(context,MaterialPageRoute(builder: (context) => SelectPage(
                              document['name'],
                              document['email'],
                              document['phone'],
                              document['tipo_sangue'],
                              document['localizacao'],
                              document['qtd_bolsas'],
                              document['tipo'],
                              document['unidade_hospitalar'],
                              document['img'],
                              document['id']
                          )));
                        },
                      );
                    }).toList()),
              );
          }
        });
  }

  Widget _PacientCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: contacts2[index].img != null
                          ? FileImage(File(contacts2[index].img))
                          : AssetImage("images/person.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Nome:"),
                        Text(
                          contacts2[index].name ?? "",
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Email:"),
                        Text(
                          contacts2[index].email ?? "",
                          style: TextStyle(fontSize: fontsz, color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Telephone"),
                        Text(
                          contacts2[index].phone ?? "",
                          style: TextStyle(fontSize: fontsz, color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Tipo Sanguíneo:"),
                        Text(
                          contacts2[index].tipoSangue ?? "",
                          style: TextStyle(fontSize: fontsz, color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Região"),
                        Text(
                          contacts2[index].localizacao ?? "",
                          style: TextStyle(fontSize: fontsz, color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Estou Precisando de "),
                        Text(
                          contacts2[index].necessidade.toString(),
                          style: TextStyle(fontSize: fontsz, color: Colors.red),
                        ),
                        Text(" bolsas"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Unidade Hospitalar:"),
                        Text(
                          contacts2[index].unidade,
                          style: TextStyle(fontSize: fontsz, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions_Pacients(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                        child: Text(
                          "Match!",
                          style: TextStyle(
                              fontFamily: 'Delighter',
                              color: Colors.red,
                              fontSize: 40.0),
                        ),
                        onPressed: () {
                          String nome_user = contacts[index].name;
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: Text(
                                    "Match realizado com sucesso!",
                                    style: TextStyle(fontFamily: 'Ubuntu'),
                                  ),
                                  content: Text(
                                    "Seu Match será mandado para ${nome_user} onde ele irá avaliar seu pedido e aceita-lo se possível.",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Ligar",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          launch("tel:${contacts[index].phone}");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    /*
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Editar",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showContactPage(contact: contacts[index]);
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Excluir",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          helper.deleteContact(contacts[index].id);
                          setState(() {
                            contacts.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),*/
                  ],
                ),
              );
            },
          );
        });
  }

  void _showOptions_Pacients(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Ligar",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          launch("tel:${contacts2[index].phone}");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    /*
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Editar",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showContactPage(contact: contacts2[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Excluir",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          helper.deleteContact(contacts2[index].id);
                          setState(() {
                            contacts2.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),*/
                  ],
                ),
              );
            },
          );
        });
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contact: contact,
                )));
    if (recContact != null) {
      if (contact != null) {
        await helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  void showLoginPage({Contact contact, BuildContext context}) async {
    final recContact = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _getAllPacients() {
    helper.getAllPacients().then((list2) {
      setState(() {
        contacts2 = list2;
      });
    });
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderaz:
        contacts.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        contacts.sort((a, b) {
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
    }
    setState(() {});
  }
}
