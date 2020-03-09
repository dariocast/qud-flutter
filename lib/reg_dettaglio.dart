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

    return Scaffold(
        appBar: AppBar(
          title: Text(registrazione.titolo),
        ),
        body: Padding(
            padding: const EdgeInsets.only(bottom: 48.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(registrazione.occasione),
                  ),
                ),
                PlayerWidget(url: registrazione.url)
              ],
            )
        )
    );
  }
}
