import 'package:doador_consciente/helpers/contact_helper.dart';
import 'package:doador_consciente/helpers/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Choose_screen.dart';
import 'contact_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ContactHelper helper = ContactHelper();
  List<Contact> contacts = List();
  String login_user, senha_user;
  final loginController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _onSucess() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChooseScreen()));
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

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: FlatButton(
            color: Color.fromRGBO(255, 0, 0, 1),
            onPressed: () {
              showCadastroPage(context: context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Não tem uma conta ?",
                  style:
                      TextStyle(color: Colors.white70, fontFamily: 'UbuntuB'),
                ),
                Text(
                  "Cadastre-se",
                  style: TextStyle(
                      color: Colors.white, fontSize: 15, fontFamily: 'UbuntuB'),
                )
              ],
            )),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, builder, model) {
            if (model.isLodding)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              );
            return Stack(children: <Widget>[
              SingleChildScrollView(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Center(
                  heightFactor: 1.6,
                  child: Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(children: <Widget>[
                            Icon(
                              Icons.favorite,
                              size: 90.0,
                              color: Color.fromRGBO(255, 0, 0, 1),
                            ),
                            Icon(
                              Icons.favorite_border,
                              size: 35.0,
                              color: Color.fromRGBO(255, 0, 0, 1),
                            ),
                          ],)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Seja bem vindo,",
                          style: TextStyle(
                              fontFamily: "UbuntuB",
                              fontSize: 35,
                              color: Color.fromRGBO(0, 0, 0, 1)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Insira suas credenciais",
                          style: TextStyle(
                              fontFamily: "UbuntuB",
                              fontSize: 20,
                              color: Color.fromRGBO(148, 148, 148, 1)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 50, left: 8.0, right: 8.0),
                        child: TextFormField(
                          cursorColor: Colors.red,
                          controller: loginController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.red,
                            ),
                            labelText: "Login",
                            hintStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 60.0,
                                fontFamily: 'UbuntuB'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 8.0, right: 8.0),
                        child: TextFormField(
                          obscureText: true,
                          controller: senhaController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock_outline,
                              color: Colors.red,
                            ),
                            labelText: "Senha",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 60.0,
                                fontFamily: 'UbuntuB'),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, left: 20.0, right: 20.0),
                          child: RaisedButton(
                            splashColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            onPressed: () {
                              model.SignIn(loginController.text,
                                  senhaController.text, _onSucess, _onFail);
                            },
                            child: Text(
                              "Logar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: "UbuntuB"),
                            ),
                            color: Color.fromRGBO(255, 0, 0, 1),
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              )
            ]);
          },
        ));
  }

  void showCadastroPage({Contact contact, BuildContext context}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ContactPage(
                contact: contact,
              )),
    );
  }

  void showHomePage({Contact contact, BuildContext context}) async {
    if (loginController.text == "BalterCFH" && senhaController.text == "123") {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChooseScreen()),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Ops..Algo deu Errado"),
              content: Text("Senha ou Usuário Inválidos"),
            );
          });
    }
  }
}
