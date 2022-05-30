// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:midentistaapp/src/pages/agenda.dart';
import 'package:midentistaapp/src/pages/register_cliente.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/api.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var fname;

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
              _userTextField(),
              SizedBox(
                height: 15.0,
              ),
              _emailTextField(),
              SizedBox(
                height: 15.0,
              ),
              __passwordTextField(),
              SizedBox(
                height: 20.0,
              ),
              _buttonRegister(),
              SizedBox(
                height: 20.0,
              ),
              _buttonFacebook()
            ],
          ),
        ),
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              hintText: 'Inserta tu nombre',
              //hintStyle: TextStyle(color: Colors.black),
              labelText: 'Nombre de usuario',
              labelStyle: TextStyle(color: Colors.black)),
          onChanged: (value) {
            fname = value;
          },
        ),
      );
    });
  }

  Widget _emailTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'Inserta tu correo',
              //hintStyle: TextStyle(color: Colors.black),
              labelText: 'Correo Electronico',
              labelStyle: TextStyle(color: Colors.black)),
          onChanged: (value) {
            email = value;
          },
        ),
      );
    });
  }

  Widget __passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: 'Contrasena',
            //hintStyle: TextStyle(color: Colors.black),
            labelText: 'Contrasena',
            labelStyle: TextStyle(color: Colors.black),
          ),
          onChanged: (value) {
            password = value;
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
            'Registrarse',
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

  Widget _buttonFacebook() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text(
            'Registrarse con Facebook',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10.0,
        color: Color.fromARGB(255, 33, 44, 107),
        onPressed: () {},
      );
    });
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'name': fname,
      'email': email,
      'password': password,
      'password_confirmation': password,
      'is_admin': '0'
    };

    var res = await Network().authData(data, '/register');
    var body = json.decode(res.body);
    if (body['token'] != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token'].toString());
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => RegisterClientePage()),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
