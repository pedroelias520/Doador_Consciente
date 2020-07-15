import 'package:flutter/material.dart';

class MatchesPage extends StatefulWidget {
  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  @override
  double fontsz = 14.0;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(158, 0, 0, 1),
        body: PageView(
          children: <Widget>[
            ListView.builder(
              itemBuilder: _PacientCard,
              itemCount: 2,
            )
          ],
        ));
  }

  Widget _PacientCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Color.fromRGBO(255, 58, 58, 80),
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
                      image: AssetImage("images/person.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Wrap(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Doador 1",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Tipo Sanguíneo : ",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "UbuntuB"),
                          ),
                          Text(
                            "A+",
                            style: TextStyle(
                                fontFamily: 'UbuntuB',
                                fontSize: fontsz,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Estou Precisando de ",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "UbuntuB"),
                          ),
                          Text(
                            "Numero X Bolsas",
                            style: TextStyle(
                                fontFamily: 'UbuntuB',
                                fontSize: fontsz,
                                color: Colors.white),
                          ),
                          Text(
                            " bolsas",
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'UbuntuB'),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Unidade Hospitalar : ",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "UbuntuB"),
                          ),
                          Text(
                            "Hospital 1",
                            style: TextStyle(
                                fontFamily: 'UbuntuB',
                                fontSize: fontsz,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: RaisedButton(
                              onPressed: () {},
                              color: Colors.green,
                              child: Text(
                                "Eu já doei",
                                style: TextStyle(
                                    fontFamily: 'UbuntuB', color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: RaisedButton(
                              onPressed: () {},
                              color: Colors.red,
                              child: Text(
                                "Não vou doar",
                                style: TextStyle(
                                    fontFamily: 'UbuntuB', color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
