import 'package:flutter/material.dart';
import 'package:qud/player_widget.dart';
import 'package:qud/registrazione.dart';

class RegistrazioneDettaglioRoute extends StatefulWidget {
  static var routeName = 'reg_dettaglio';

  @override
  State<StatefulWidget> createState() {
    return _RegistrazioneDettaglioRouteState();
  }
}

class _RegistrazioneDettaglioRouteState
    extends State<RegistrazioneDettaglioRoute> {
  @override
  Widget build(BuildContext context) {
    final Registrazione registrazione =
        ModalRoute.of(context).settings.arguments;

    final player = PlayerWidget(url: registrazione.url);

//    return Scaffold(
//        appBar: AppBar(
//          title: Text(registrazione.titolo),
//        ),
//        body: Padding(
//            padding: const EdgeInsets.only(bottom: 48.0),
//            child: Column(
//              mainAxisSize: MainAxisSize.max,
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//                Expanded(
//                  child: Center(
//                    child: Text(registrazione.occasione),
//                  ),
//                ),
//                PlayerWidget(url: registrazione.url)
//              ],
//            )
//        )
//    );

    ///detail of book image and it's pages
    final topLeft = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: registrazione.titolo,
            child: Material(
              elevation: 15.0,
              shadowColor: Colors.yellow,
              child: Image(
                image: AssetImage('assets/images/${registrazione.momento}.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );

    ///detail top right
    final topRight = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(registrazione.titolo,
            size: 25, isBold: true, padding: EdgeInsets.only(top: 16.0)),
        text(
          '${registrazione.occasione}',
          size: 20,
          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
        ),
        text('${registrazione.luogo}', size: 15),
        text('${registrazione.data}', size: 15)
      ],
    );

    final topContent = Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 2, child: topLeft),
          Flexible(flex: 3, child: topRight),
        ],
      ),
    );

    ///scrolling text description
    final bottomContent = Container(
      height: 220.0,
      child: player,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Dettaglio'),
      ),
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  ///create text widget
  text(String data,
          {Color color = Colors.white,
          num size = 14,
          EdgeInsetsGeometry padding = EdgeInsets.zero,
          bool isBold = false}) =>
      Padding(
        padding: padding,
        child: Text(
          data,
          style: TextStyle(
              color: color,
              fontSize: size.toDouble(),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      );
}
