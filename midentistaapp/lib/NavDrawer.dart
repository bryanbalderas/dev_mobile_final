import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:midentistaapp/network/api.dart';
import 'package:midentistaapp/src/pages/agenda.dart';
import 'package:midentistaapp/src/pages/dentista_add.dart';
import 'package:midentistaapp/src/pages/login_page.dart';
import 'package:midentistaapp/src/pages/info_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              image: new DecorationImage(
                image: AssetImage("images/logodentista.png"),
                fit: BoxFit.scaleDown,
              ),
            ),
            child: Center(),
          ),
          ListTile(
            title: Text("Agenda"),
            leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AgendaPage()));
              },
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AgendaPage()));
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Mis Datos"),
            leading: IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => InfoUserPage()));
              },
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => InfoUserPage()));
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Configuracion"),
            leading: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
            onTap: () {},
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Agregar Dentista"),
            leading: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => DentistaAddPage()));
              },
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DentistaAddPage()));
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Cerrar Sesion"),
            tileColor: Colors.redAccent,
            leading: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                logout();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
            ),
            onTap: () {
              logout();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }

  void logout() async {
    var res = await Network().setData('/logout');
    var body = res.body.toString();
    if (body == 'Ha cerrado sesión') {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
    }
  }
}
