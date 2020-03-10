import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:qud/database.dart';
import 'package:qud/notifiche_route.dart';
import 'package:qud/reg_dettaglio.dart';
import 'package:qud/registrazione.dart';

class RegistrazioneRoute extends StatefulWidget {
  static var routeName = '/';

  RegistrazioneRoute({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _RegistrazioneRouteState createState() => _RegistrazioneRouteState();
}

class _RegistrazioneRouteState extends State<RegistrazioneRoute> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  List<Registrazione> registrazioni = [];
  var listaNotifiche = [];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          leading: Image(image: AssetImage('assets/icon/icon.png')),
          centerTitle: true,
          actions: <Widget>[
            // action button
            Badge(
              badgeContent: Text(listaNotifiche.length.toString(), style: TextStyle(color: Colors.white),),
              child: IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.yellow,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(NotificheRoute.routeName);
                },
              ),
            ),
            IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh',
                onPressed: () {
                  _refreshIndicatorKey.currentState.show();
                }),
          ]),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: getRegistrazioni,
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Theme.of(context).primaryColor,
            ),
            padding: EdgeInsets.all(8.0),
            itemCount: registrazioni.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(5.0),
                title: Text(registrazioni[index].titolo),
                subtitle: Text(registrazioni[index].occasione),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/${registrazioni[index].momento}.png'),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(RegistrazioneDettaglioRoute.routeName, arguments: registrazioni[index]);
                },
              );
            },
          )),
    );
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    caricaNotifiche();
  }

  Future<List<Registrazione>> getRegistrazioni() async {
    final response = await http.get(
        'http://dariocast.altervista.org/quisutdeus/lista_json.php');
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      var list = result as List;
      List<Registrazione> regList =
          list.map((i) => Registrazione.fromJson(i)).toList();
      setState(() {
        registrazioni = regList;
      });
    } else
      throw Exception('Failed to load confraternite');
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
}
