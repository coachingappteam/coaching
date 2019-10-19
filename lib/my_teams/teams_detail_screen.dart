import 'package:flutter/material.dart';

import '../models/team.dart';
import 'team_information_screen.dart';
import './athletes/athletes_screen.dart';
import './coaches/coaches_screen.dart';

class TeamsDetail extends StatefulWidget {
  final Team team;

  TeamsDetail({@required this.team});

  @override
  _TabsScreenState createState() => _TabsScreenState(team: team);
}

class _TabsScreenState extends State<TeamsDetail> {
  final Team team;

  _TabsScreenState({this.team});

  goToInfo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamInformationScreen(
          team: team,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          iconTheme: IconThemeData(
            color: Color.fromRGBO(0, 125, 167, 1),
          ),
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(
            color: Color.fromRGBO(0, 125, 167, 1),
          ),
          title: Text(this.team.teamName),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: goToInfo,
            )
          ],
          bottom: TabBar(
            labelColor: Color.fromRGBO(0, 125, 167, 1),
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.description,
                  color: Color.fromRGBO(0, 125, 167, 1),
                ),
                text: 'Workouts',
              ),
              Tab(
                icon: Icon(
                  Icons.pool,
                  color: Color.fromRGBO(0, 125, 167, 1),
                ),
                text: 'Athletes',
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Color.fromRGBO(0, 125, 167, 1),
                ),
                text: 'Coaches',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AthletesScreen(),
            AthletesScreen(),
            CoachesScreen()
          ],
        ),
      ),
    );
  }
}
