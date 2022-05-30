// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:midentistaapp/models/dentista.dart';
import 'package:midentistaapp/src/pages/agenda.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../network/api.dart';

class RegisterClientePage extends StatefulWidget {
  static String id = 'register_cliente_page';

  @override
  _RegisterClientePageState createState() => _RegisterClientePageState();
}

List<Dentista> dent = [];

Future<List<Dentista>> fetchDentistas() async {
  var res = await Network().getData('/dentistas');

  if (res.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    List<Dentista> dentistas = (json.decode(res.body) as List)
        .map((data) => Dentista.fromJson(data))
        .toList();

    return dentistas;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load dentistas');
  }
}

class _RegisterClientePageState extends State<RegisterClientePage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var edad;
  var domicilio;
  var telefono;
  String dropdownValue = '1';

  String _message = '';

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    llenarDentistas();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset(
                  'images/logodentista.png',
                  height: 200.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              _edadTextField(),
              SizedBox(
                height: 15.0,
              ),
              _telefonoTextField(),
              SizedBox(
                height: 15.0,
              ),
              __domicilioTextField(),
              SizedBox(
                height: 20.0,
              ),
              _dropdownDentista(),
              SizedBox(
                height: 20.0,
              ),
              _buttonRegister(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _edadTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          maxLength: 3,
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              icon: Icon(Icons.add_circle_sharp),
              hintText: 'Inserta tu edad',
              //hintStyle: TextStyle(color: Colors.black),
              labelText: 'Edad',
              labelStyle: TextStyle(color: Colors.black)),
          onChanged: (value) {
            edad = value;
          },
        ),
      );
    });
  }

  Widget _telefonoTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          maxLength: 10,
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              icon: Icon(Icons.add_ic_call_rounded),
              hintText: 'Inserta tu telefono',
              //hintStyle: TextStyle(color: Colors.black),
              labelText: 'Telefono',
              labelStyle: TextStyle(color: Colors.black)),
          onChanged: (value) {
            telefono = value;
          },
        ),
      );
    });
  }

  Widget __domicilioTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: Icon(Icons.add_home_work),
            hintText: 'Ingresa tu Domicilio',
            //hintStyle: TextStyle(color: Colors.black),
            labelText: 'Domicilio',
            labelStyle: TextStyle(color: Colors.black),
          ),
          onChanged: (value) {
            domicilio = value;
          },
        ),
      );
    });
  }

  Widget _buttonRegister() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text(
            'Registrar Datos',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10.0,
        color: Colors.white,
        onPressed: () {
          _register();
        },
      );
    });
  }

  Widget _dropdownDentista() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        hint: Text('Dentista Asignado'),
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
        items: dent.map((item) {
          return DropdownMenuItem(
              child: Text(item.nombre), value: item.id.toString());
        }).toList(),
      );
    });
  }

  void llenarDentistas() async {
    List<Dentista> nlist = await fetchDentistas();
    setState(() {
      dent = nlist;
    });
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'edad': edad,
      'telefono': telefono.toString(),
      'domicilio': domicilio,
      'dentista_id': dropdownValue
    };

    var res = await Network().setDataParam(data, '/clientes');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => AgendaPage()),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
