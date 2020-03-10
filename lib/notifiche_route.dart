import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qud/database.dart';

class NotificheRoute extends StatefulWidget {
  static var routeName = 'notifiche';

  @override
  State<StatefulWidget> createState() {
    return _NotificheRouteState();
  }
}

class _NotificheRouteState extends State<NotificheRoute> {
  var listaNotifiche = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifiche'),
        ),
        body: listaNotifiche.isEmpty
            ? Center(child: Text('Non ci sono nuove notifiche'),)
            : ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Theme.of(context).primaryColor,
          ),
          padding: EdgeInsets.all(8.0),
          itemCount: listaNotifiche.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: EdgeInsets.all(5.0),
              title: Text(json.decode(listaNotifiche[index])['notification']['title']),
              trailing: Icon(Icons.delete, color: Colors.red,),
              onTap: () {
                _rimuovi(index);
              },
            );
          },
        )
    );
  }

  @override
  void initState() {
    super.initState();
    caricaNotifiche();
  }

  void caricaNotifiche() async {
    var notifiche = await Database.get('notifiche');
    if (notifiche == null) {
      notifiche = [];
    }
    setState(() {
      listaNotifiche = notifiche;
    });

  }

  void _rimuovi(int index) async {
    listaNotifiche.removeAt(index);
    await Database.put('notifiche', listaNotifiche);
    setState(() {});
  }

}