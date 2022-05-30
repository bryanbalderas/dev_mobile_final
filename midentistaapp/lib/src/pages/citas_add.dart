// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:midentistaapp/src/pages/agenda.dart';
import 'package:midentistaapp/src/pages/register_cliente.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/api.dart';

class CitaAddPage extends StatefulWidget {
  static String id = 'cita_add_page';

  @override
  _CitaAddPageState createState() => _CitaAddPageState();
}

class _CitaAddPageState extends State<CitaAddPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var fecha;
  var hora;
  var uid;
  String dropdownValue = 'Control Mensual';

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
    obtenerIdUsuario();
    super.initState();
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
              SizedBox(
                height: 15.0,
              ),
              _fechaTextField(),
              SizedBox(
                height: 15.0,
              ),
              _horaTextField(),
              SizedBox(
                height: 20.0,
              ),
              _dropdownTipoCita(),
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
        items: <String>['Control Mensual', 'Limpieza', 'Cirujia', 'Especial']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }

  Widget _fechaTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              hintText: 'yyyy/mm/dd',
              //hintStyle: TextStyle(color: Colors.black),
              labelText: 'Fecha cita:',
              labelStyle: TextStyle(color: Colors.black)),
          onChanged: (value) {
            fecha = value;
          },
        ),
      );
    });
  }

  Widget _horaTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'ej. 13:45:00',
              //hintStyle: TextStyle(color: Colors.black),
              labelText: 'Hora de la cita:',
              labelStyle: TextStyle(color: Colors.black)),
          onChanged: (value) {
            hora = value;
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
            'Registrar Cita',
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

  void obtenerIdUsuario() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    uid = user['id'];
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'fecha': fecha,
      'hora': hora,
      'is_atendido': '0',
      'user_id': uid,
      'tipo_cita': dropdownValue,
    };

    var res = await Network().setDataParam(data, '/citas');
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
