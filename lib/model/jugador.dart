import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Jugador {
  String _id;
  String _nombre;
  String _posicion;
  String _equipo;
  String _email;
  String _phone;

  Jugador(this._id, this._nombre, this._posicion, this._equipo, this._email,
      this._phone);
  Jugador.map(dynamic obj) {
    this._nombre = obj['nombre'];
    this._posicion = obj['posicion'];
    this._equipo = obj['equipo'];
    this._email = obj['email'];
    this._phone = obj['phone'];
  }
  String get id => _id;
  String get nombre => _nombre;
  String get posicion => _posicion;
  String get equipo => _equipo;
  String get email => _email;
  String get phone => _phone;

  Jugador.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _posicion = snapshot.value['posicion'];
    _equipo = snapshot.value['equipo'];
    _email = snapshot.value['email'];
    _phone = snapshot.value['phone'];
  }
}
