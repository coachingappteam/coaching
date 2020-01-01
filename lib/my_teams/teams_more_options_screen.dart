import 'package:flutter/material.dart';

import '../models/team.dart';
import '../main_color.dart';
import 'coaches/coaches_screen.dart';
import '../training_plan/training_plan_screen.dart';

class TeamsMoreOptionsScreen extends StatefulWidget {
  final Team team;

  TeamsMoreOptionsScreen({@required this.team});

  @override
  _TeamsMoreOptionsScreenState createState() => _TeamsMoreOptionsScreenState(team: team);
}

class _TeamsMoreOptionsScreenState extends State<TeamsMoreOptionsScreen> {
  final Team team;

  _TeamsMoreOptionsScreenState({@required this.team});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        title: Text('More Options'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoachesScreen()),
              );
            },
            leading: Icon(
              Icons.person,
              color: MainColor().mainColor(),
            ),
            title: Text('Coaches'),
          ),
          ListTile(
            leading: Icon(
              Icons.description,
              color: MainColor().mainColor(),
            ),
            title: Text('Training Plan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrainingPlanScreen(team: this.team,)),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: MainColor().mainColor(),
            ),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
