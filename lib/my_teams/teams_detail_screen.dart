import 'package:flutter/material.dart';

import '../models/team.dart';
import 'teams_more_options_screen.dart';
import './athletes/athletes_screen.dart';
import './coaches/coaches_screen.dart';
import '../main_color.dart';

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
        builder: (context) => TeamsMoreOptionsScreen(
          team: team,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          iconTheme: IconThemeData(
            color: MainColor().mainColor(),
          ),
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(
            color: MainColor().mainColor(),
          ),
          title: Text(this.team.teamName),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: goToInfo,
            )
          ],
          bottom: TabBar(
            labelColor: MainColor().mainColor(),
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.description,
                  color: MainColor().mainColor(),
                ),
                text: 'Workouts',
              ),
              Tab(
                icon: Icon(
                  Icons.pool,
                  color: MainColor().mainColor(),
                ),
                text: 'Athletes',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AthletesScreen(),
            AthletesScreen(),
          ],
        ),
      ),
    );
  }
}
