import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:qud/reg_route.dart';
import 'package:qud/notifiche_route.dart';
import 'package:qud/reg_dettaglio.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  FirebaseAnalytics analytics = FirebaseAnalytics();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      //routing info
      initialRoute: RegistrazioneRoute.routeName,
      routes: {
        NotificheRoute.routeName: (context) => NotificheRoute(),
        RegistrazioneDettaglioRoute.routeName: (context) => RegistrazioneDettaglioRoute(),
      },
      title: 'Quis ut Deus',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.blue,
        fontFamily: 'Viaoda',
//        canvasColor: Colors.amber[50],
        textTheme: TextTheme(
          subhead: TextStyle(
            fontFamily: 'Viaoda',
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
          body1: TextStyle(
            color: Colors.blue,
            fontFamily: 'Viaoda',
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          title: TextStyle(
            color: Colors.blue,
            fontFamily: 'Viaoda',
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
          subtitle: TextStyle(
            color: Colors.blue,
            fontFamily: 'Viaoda',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
          button
              : TextStyle(
            color: Colors.blue,
            fontFamily: 'Viaoda',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
          caption
              :TextStyle(
            color: Colors.blue,
            fontFamily: 'Viaoda',
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      home: RegistrazioneRoute(title: 'Quis ut Deus'),
    );
  }
}
