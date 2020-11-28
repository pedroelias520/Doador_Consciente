import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doador_consciente/common/common_drawer/Drawer.dart';
import 'package:doador_consciente/helpers/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'campanha_page.dart';
import 'campanha_page_list.dart';
import 'home_page.dart';
import 'home_page_receptor.dart';
import 'login_screen.dart';
import 'matches_page.dart';

class ChooseScreen extends StatefulWidget {
  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, builder, model) {
        String url_image="https://media2.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.gif";
        PageController pageController = PageController();
        if (model.isLodding)
          return Center(
            child: CircularProgressIndicator(),
          );
        return PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home'),
                ),
              ),
              HomePage(),
              CampanhaPage(),
              CampanhaPageList(),
              MatchesPage(),
          ],
        );
      },
    );
  }
}
