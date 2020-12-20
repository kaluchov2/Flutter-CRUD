import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:web_bd_app/ui/jugador_screen.dart';
import 'package:web_bd_app/ui/jugador_info.dart';
import 'package:web_bd_app/model/jugador.dart';

class ListViewJugador extends StatefulWidget {
  @override
  _ListViewJugadorState createState() => _ListViewJugadorState();
}

final jugadorReference = FirebaseDatabase.instance.reference().child('jugador');

class _ListViewJugadorState extends State<ListViewJugador> {
  List<Jugador> items;
  StreamSubscription<Event> _onJugadorAdd;
  StreamSubscription<Event> _onJugadorEdit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = new List();
    _onJugadorAdd = jugadorReference.onChildAdded.listen(_onJugadorAdded);
    _onJugadorEdit = jugadorReference.onChildAdded.listen(_onJugadorUpdated);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onJugadorAdd.cancel();
    _onJugadorEdit.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jugadores',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Info Jugador'),
          centerTitle: true,
          backgroundColor: Colors.tealAccent,
        ),
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(
                    height: 7.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                            title: Text(
                              '${items[position].nombre}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21.0,
                              ),
                            ),
                            subtitle: Text(
                              '${items[position].equipo}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21.0,
                              ),
                            ),
                            leading: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.amberAccent,
                                  radius: 17.0,
                                  child: Text(
                                    '${items[position].equipo}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            onTap: () => _navigateToJugadorinfo(
                                context, items[position])),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => _deleteJugador(
                              context, items[position], position)),
                      IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                          onPressed: () =>
                              _NavigateToJugador(context, items[position]))
                    ],
                  )
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.blueAccent),
          backgroundColor: Colors.deepOrange,
          onPressed: () => _createNewJugador(context),
        ),
      ),
    );
  }

  void _onJugadorAdded(Event event) {
    setState(() {
      items.add(new Jugador.fromSnapShot(event.snapshot));
    });
  }

  void _onJugadorUpdated(Event event) {
    var oldJugador =
        items.singleWhere((jugador) => jugador.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldJugador)] =
          new Jugador.fromSnapShot(event.snapshot);
    });
  }

  void _deleteJugador(
      BuildContext context, Jugador jugador, int position) async {
    await jugadorReference.child(jugador.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
        Navigator.of(context).pop();
      });
    });
  }

  void _navigateToJugadorinfo(BuildContext context, Jugador jugador) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JugadorScreen(jugador)),
    );
  }

  void _NavigateToJugador(BuildContext context, Jugador jugador) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JugadorInfo(jugador)),
    );
  }

  void _createNewJugador(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              JugadorScreen(Jugador(null, '', '', '', '', ''))),
    );
  }
}
