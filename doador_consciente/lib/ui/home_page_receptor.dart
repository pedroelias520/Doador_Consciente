import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doador_consciente/helpers/user_model.dart';
import 'package:doador_consciente/ui/select_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';
import 'Choose_screen.dart';
import 'AboutPage.dart';
import 'login_screen.dart';
class HomePageReceptor extends StatefulWidget {
  @override
  _HomePageReceptorState createState() => _HomePageReceptorState();
}

class _HomePageReceptorState extends State<HomePageReceptor> {
  PageController _pageController;
  int _page = 0;
  double lenght;
  int lenght_int;
  double fontsz = 16.0;



  @override
  void initState() {
    super.initState();
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
                  MaterialPageRoute(builder: (context) => LoginPage()));
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
        actions: <Widget>[],
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
                  itemBuilder: (context, index) {return _CardUsers(context);},
                itemCount: 1,
              ),
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
                    Icons.airline_seat_flat,
                    color: Colors.red,
                  ),
                  title: Text(
                    "Pacientes",
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
        stream: Firestore.instance.collection("Users").where("tipo",isEqualTo: 'Paciente').snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
            lenght_int = snapshot.data.documents.length;
            lenght = snapshot.data.documents.length.truncateToDouble() * 200;
            try{
              if (snapshot.hasError) return new Text('Error ');
              if(snapshot.data == null) return new Text('Error ');
            }catch(e){
              print(e.toString());
            }
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
                height: lenght,
                child: ListView(
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return GestureDetector(
                        child: Card(
                          margin: EdgeInsets.all(5),
                          color: Colors.white,
                          child: Container(
                            height: 200,
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
                                              fontFamily: 'UbuntuB',
                                              color: Colors.grey),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                        Text(
                                          document['email'],
                                          style: TextStyle(
                                              fontFamily: 'UbuntuB',
                                              color:
                                              Colors.redAccent),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          document['tipo_sangue'],
                                          style: TextStyle(
                                              fontFamily: 'UbuntuB',
                                              color:
                                              Colors.redAccent),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          document['localizacao'],
                                          style: TextStyle(
                                            fontFamily: 'UbuntuB',
                                            color: Colors.redAccent,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          document['tipo'],
                                          style: TextStyle(
                                            fontFamily: 'UbuntuB',
                                            color: Colors.redAccent,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          document['data_doacao'],
                                          style: TextStyle(
                                            fontFamily: 'UbuntuB',
                                            color: Colors.redAccent,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          document['qtd_bolsas'],
                                          style: TextStyle(
                                            fontFamily: 'UbuntuB',
                                            color: Colors.redAccent,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          document['data_criacao'],
                                          style: TextStyle(
                                            fontFamily: 'UbuntuB',
                                            color: Colors.redAccent,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        Text(
                                          document['id'],
                                          style: TextStyle(
                                            fontFamily: 'UbuntuB',
                                            color: Colors.redAccent,
                                          ),
                                          textAlign: TextAlign.right,
                                        )

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
                          Navigator.push(context,MaterialPageRoute(builder: (context) => SelectPage(
                              document['name'] == null ? " " :document['name'],
                              document['email'] == null ? " " :document['email'],
                              document['phone'] == null ? " " :document['phone'],
                              document['tipo_sangue'] == null ? " " :document['tipo_sangue'],
                              document['localizacao'] == null ? " " :document['localizacao'],
                              document['qtd_bolsas'] == null ? " " :document['qtd_bolsas'],
                              document['tipo'] == null ? " " :document['tipo'],
                              document['unidade_hospitalar'] == null ? " " :document['unidade_hospitalar'],
                              document['img']== null ? " " :document['img'],
                              document['id'] == null ? " " : document['id']
                          )));
                        },
                      );
                    }).toList()),
              );
          }
        });
  }
}
