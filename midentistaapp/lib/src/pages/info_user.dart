// ignore_for_file:r_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:midentistaapp/src/pages/agenda.dart';
import 'package:midentistaapp/NavDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/usuario.dart';
import '../../network/api.dart';

class InfoUserPage extends StatefulWidget {
  static String id = 'info_user_page';

  @override
  _InfoUserState createState() => _InfoUserState();
}

late Usuario usr;

Future<Usuario> fetchUsuario() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var user = jsonDecode(localStorage.getString('user')!);

  var usrId = user['id'];

  var res = await Network().getData('/clientes/' + usrId.toString());

  if (res.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return Usuario.fromJson(jsonDecode(res.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load dentistas');
  }
}

class _InfoUserState extends State<InfoUserPage> {
  String dropdownValue = 'One';
  late Future<Usuario> futureUsuario;
  late Usuario infoUsr;

  int idUsuario = 1;
  int edad = 20;
  int telefono = 8442066257;
  String domicilio = 'calle 1 col zaragoza';
  String dentista = 'dr jose';
  String nombre = 'josesito';

  @override
  void initState() {
    super.initState();
    futureUsuario = fetchUsuario();
    asignarUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logodentista.png',
                fit: BoxFit.scaleDown,
                height: 50,
              ),
              Container(padding: const EdgeInsets.all(8.0), child: Text(''))
            ],
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.0,
              ),
              _userIdTextField(),
              SizedBox(
                height: 15.0,
              ),
              __pnombreTextField(),
              SizedBox(
                height: 20.0,
              ),
              __pedadTextField(),
              SizedBox(
                height: 20.0,
              ),
              __telefonoTextField(),
              SizedBox(
                height: 20.0,
              ),
              __dentistaTextField(),
              SizedBox(
                height: 20.0,
              ),
              _buttonRegresar(),
              SizedBox(
                height: 20.0,
              ),
              _buttonEditar(),
            ],
          ),
        ),
      ),
    );
  }

  void asignarUsuario() async {
    infoUsr = await futureUsuario;
    idUsuario = infoUsr.id;
    edad = infoUsr.edad;
    telefono = infoUsr.telefono;
    domicilio = infoUsr.domicilio;
    nombre = infoUsr.name;
    setState(() {
      infoUsr;
    });
  }

  Widget _userIdTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Cliente Id: " + idUsuario.toString(),
            style: TextStyle(color: Colors.black),
          ));
    });
  }

  Widget __pnombreTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Nombre: " + nombre,
            style: TextStyle(color: Colors.black),
          ));
    });
  }

  Widget __pedadTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Edad: " + edad.toString(),
            style: TextStyle(color: Colors.black),
          ));
    });
  }

  Widget _buttonRegresar() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text(
            'Volver a tu agenda',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10.0,
        color: Colors.redAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgendaPage()),
          );
        },
      );
    });
  }

  Widget _buttonEditar() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text(
            'Editar Cita',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10.0,
        color: Colors.greenAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgendaPage()),
          );
        },
      );
    });
  }

  Widget __telefonoTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Telefono: " + telefono.toString(),
            style: TextStyle(color: Colors.black),
          ));
    });
  }

  Widget __dentistaTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Dentista: " + telefono.toString(),
            style: TextStyle(color: Colors.black),
          ));
    });
  }

  Widget _dropdownTipoCita() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        hint: Text('Elige el tipo de cita'),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }
}
