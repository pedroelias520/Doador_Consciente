import 'package:doador_consciente/common/common_drawer/drawer_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerTile(Icons.add,'Campanhas',0),
          DrawerTile(Icons.favorite,'Participar de Campanha',1),
          DrawerTile(Icons.file_download,'Receber',2),
          DrawerTile(Icons.home,'Home',3),
          DrawerTile(Icons.person_add,'Matches',4),
        ],
      ),
    );
  }
}
