import 'package:flutter/material.dart';
 class AboutPage extends StatefulWidget {
   @override
   _AboutPageState createState() => _AboutPageState();
 }

 class _AboutPageState extends State<AboutPage> {
   @override
   Widget build(BuildContext context) {
     return GestureDetector(
           child: Scaffold(
             backgroundColor: Colors.red,
             body: Stack(
               children: <Widget>[
                 SingleChildScrollView(
                   child: Padding(
                     padding: EdgeInsets.all(20.0),
                     child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Olá,Bem_Vindo ao Doador Consciente",style: TextStyle(fontSize: 30.0,color: Colors.white,height: 1.0,fontFamily: "UbuntuB"),textAlign: TextAlign.center,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Este protótipos foram desenvolvido para um evento do curso de Análise e Desenvolvimento de Sistemas,quaisquer dúvidas entre em contato com os desenvolvedores",textAlign: TextAlign.justify,style: TextStyle(color: Colors.white,fontFamily: "UbuntuB"),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Porque o sangue é importante?",style: TextStyle(fontSize: 30.0,color: Colors.white,fontFamily: "UbuntuB"),textAlign: TextAlign.center,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("O sangue é um tecido conjuntivo líquido que circula pelo sistema vascular em animais vertebrados; formado por uma porção celular de natureza diversificada - pelos elementos figurados do sangue - que circula em suspensão em meio fluido, o plasma. Em animais vertebrados o sangue, tipicamente vermelho, é geralmente produzido na medula óssea. Em animais invertebrados a coloração pode variar, mostrando-se em várias espécies, dada a presença de cobre e não ferro na estrutura das células responsáveis pelo transporte de oxigênio, azulado.[1] O sangue tem como função a manutenção da vida do organismo no que tange ao transporte de nutrientes, excretas (metabólitos), oxigênio e gás carbônico, hormônios, anticorpos, e demais substâncias ou corpúsculos cujos transportes se façam essenciais entre os mais diversos e mesmo remotos tecidos e órgãos do organismo.",style: TextStyle(color: Colors.white,fontFamily: "UbuntuB"),textAlign: TextAlign.justify,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Desenvolvedores",style: TextStyle(fontSize: 30.0,color: Colors.white,height: 1.0,fontFamily: "UbuntuB"),textAlign: TextAlign.center,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Quero Agendar uma consulta",style: TextStyle(color: Colors.white,fontFamily: "UbuntuB"),textAlign: TextAlign.center,),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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
                                        image: AssetImage("images/Pedro.jpg"),
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
                                          Text(
                                            "Pedro Elias Figueredo de Sousa",
                                            style: TextStyle(
                                                fontSize: 15.0, fontWeight: FontWeight.bold,color: Colors.red,fontFamily: "UbuntuB"),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "Desenvolvedor Chefe",
                                          style: TextStyle(
                                              fontSize: 12.0, fontWeight: FontWeight.bold,color: Colors.blue,fontFamily: "UbuntuB"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "epedro520@gmail.com",
                                          style: TextStyle(
                                              fontSize: 12.0, fontWeight: FontWeight.bold,color: Colors.blue,fontFamily: "UbuntuB"),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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
                                        image: AssetImage("images/Weryck.jpg"),
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
                                          Text(
                                            "Weryck Oka Lôbo de Almeida",
                                            style: TextStyle(
                                                fontSize: 15.0, fontWeight: FontWeight.bold,color: Colors.red,fontFamily: "UbuntuB"),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "Escritor e Analista",
                                          style: TextStyle(
                                              fontSize: 12.0, fontWeight: FontWeight.bold,color: Colors.blue,fontFamily: "UbuntuB"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "werycklobo@gmail.com",
                                          style: TextStyle(
                                              fontSize: 12.0, fontWeight: FontWeight.bold,color: Colors.blue,fontFamily: "UbuntuB"),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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
                                        image: AssetImage("images/Jayder.jpg"),
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
                                          Text(
                                            "Jayder Nunes Martins de Oliveira",
                                            style: TextStyle(
                                                fontSize: 15.0, fontWeight: FontWeight.bold,color: Colors.red,fontFamily: "UbuntuB"),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "Modelador de Casos de Uso",
                                          style: TextStyle(
                                              fontSize: 12.0, fontWeight: FontWeight.bold,color: Colors.blue,fontFamily: "UbuntuB"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "nunesjayder@gmail.com",
                                          style: TextStyle(
                                              fontSize: 12.0, fontWeight: FontWeight.bold,color: Colors.blue,fontFamily: "UbuntuB"),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],

                     ),
                   ),
                 ),
               ],
             ),
           ),
     );
   }
 }

