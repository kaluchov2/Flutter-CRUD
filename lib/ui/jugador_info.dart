import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:web_bd_app/model/jugador.dart';

class JugadorInfo extends StatefulWidget {
  final Jugador jugador;
  JugadorInfo(this.jugador);
  @override
  _JugadorInfoState createState() => _JugadorInfoState();
}

final jugadorReference = FirebaseDatabase.instance.reference().child('jugador');

class _JugadorInfoState extends State<JugadorInfo> {
  List<Jugador> items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info Jugador'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: 400,
        padding: const EdgeInsets.all(15),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                new Text(
                  "Nombre: ${widget.jugador.nombre}",
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                new Text(
                  "Posicion: ${widget.jugador.posicion}",
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                new Text(
                  "Equipo: ${widget.jugador.equipo}",
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                new Text(
                  "Email: ${widget.jugador.email}",
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                new Text(
                  "Phone: ${widget.jugador.phone}",
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
