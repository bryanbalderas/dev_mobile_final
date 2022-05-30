// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:midentistaapp/src/pages/agenda.dart';
import 'package:midentistaapp/NavDrawer.dart';

class InfoCitaPage extends StatefulWidget {
  static String id = 'info_page';

  @override
  _InfoCitaState createState() => _InfoCitaState();
}

class _InfoCitaState extends State<InfoCitaPage> {
  String dropdownValue = 'One';

  String nombreUsuario = 'pedrito';
  int idUsuario = 1;
  String fechaCita = '12/12/2022';
  String tipoCita = 'control mensual';

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
              __ptipoCitTextField(),
              SizedBox(
                height: 20.0,
              ),
              __pFechaTextField(),
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
            "Nombre: " + nombreUsuario,
            style: TextStyle(color: Colors.black),
          ));
    });
  }

  Widget __pFechaTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Fecha: " + fechaCita,
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

  Widget __ptipoCitTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Tipo de cita: " + tipoCita,
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
