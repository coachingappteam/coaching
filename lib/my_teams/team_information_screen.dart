import 'package:flutter/material.dart';

import '../models/team.dart';

class TeamInformationScreen extends StatefulWidget {
  final Team team;

  TeamInformationScreen({@required this.team});

  @override
  _TeamInformationState createState() => _TeamInformationState(team: team);
}

class _TeamInformationState extends State<TeamInformationScreen> {
  final Team team;

  _TeamInformationState({@required this.team});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(0, 125, 167, 1),
        ),
        title: Text('General Information'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.description),
              ),
              Text('General Information'),
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.settings_applications),
              ),
              Text('Settings'),
            ],
          ),
        ],
      ),
    );
  }
}
