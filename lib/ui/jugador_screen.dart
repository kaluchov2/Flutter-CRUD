import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:web_bd_app/model/jugador.dart';

class JugadorScreen extends StatefulWidget {
  final Jugador jugador;
  JugadorScreen(this.jugador);
  @override
  _JugadorScreenState createState() => _JugadorScreenState();
}

final jugadorReference = FirebaseDatabase.instance.reference().child('jugador');

class _JugadorScreenState extends State<JugadorScreen> {
  List<Jugador> items;

  TextEditingController _nombrecontroller;
  TextEditingController _posicioncontroller;
  TextEditingController _equipocontroller;
  TextEditingController _emailcontroller;
  TextEditingController _phonecontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombrecontroller = new TextEditingController(text: widget.jugador.nombre);
    _posicioncontroller =
        new TextEditingController(text: widget.jugador.posicion);
    _equipocontroller = new TextEditingController(text: widget.jugador.equipo);
    _emailcontroller = new TextEditingController(text: widget.jugador.email);
    _phonecontroller = new TextEditingController(text: widget.jugador.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Jugadores Base de Datos'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        height: 570,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nombrecontroller,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Nombre'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _posicioncontroller,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                  decoration: InputDecoration(
                      icon: Icon(Icons.pan_tool), labelText: 'Posicion'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _equipocontroller,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                  decoration: InputDecoration(
                      icon: Icon(Icons.people), labelText: 'Equipo'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _emailcontroller,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                  decoration: InputDecoration(
                      icon: Icon(Icons.email), labelText: 'Email'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _phonecontroller,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone), labelText: 'Telefono'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                FlatButton(
                    onPressed: () {
                      if (widget.jugador.id != null) {
                        jugadorReference.child(widget.jugador.id).set({
                          'nombre': _nombrecontroller.text,
                          'posicion': _posicioncontroller.text,
                          'equipo': _equipocontroller.text,
                          'email': _emailcontroller.text,
                          'phone': _phonecontroller.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      } else {
                        jugadorReference.push().set({
                          'nombre': _nombrecontroller.text,
                          'posicion': _posicioncontroller.text,
                          'equipo': _equipocontroller.text,
                          'email': _emailcontroller.text,
                          'phone': _phonecontroller.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: (widget.jugador.id != null)
                        ? Text('Update')
                        : Text('Agregar')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
