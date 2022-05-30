// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:midentistaapp/NavDrawer.dart';
import 'package:midentistaapp/src/pages/agenda.dart';
import 'package:midentistaapp/src/pages/register_cliente.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/api.dart';

class DentistaAddPage extends StatefulWidget {
  static String id = 'dentista_add_page';

  @override
  _DentistaAddPageState createState() => _DentistaAddPageState();
}

class _DentistaAddPageState extends State<DentistaAddPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  String nombre = '';
  String telefono = '';

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
              _nombreTextField(),
              SizedBox(
                height: 15.0,
              ),
              _telefonoTextField(),
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

  Widget _nombreTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              hintText: 'Nombre completo',
              //hintStyle: TextStyle(color: Colors.black),
              labelText: 'Nombre del dentista:',
              labelStyle: TextStyle(color: Colors.black)),
          onChanged: (value) {
            nombre = value;
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
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: '84412233440',
              //hintStyle: TextStyle(color: Colors.black),
              labelText: 'Telefono:',
              labelStyle: TextStyle(color: Colors.black)),
          onChanged: (value) {
            telefono = value;
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
            'Registrar Dentista',
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

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'nombre': nombre,
      'telefono': telefono,
    };

    var res = await Network().setDataParam(data, '/dentistas');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => AgendaPage()),
      );
    }else{
      _showMsg(body['message']);

    }

    setState(() {
      _isLoading = false;
    });
  }
}
