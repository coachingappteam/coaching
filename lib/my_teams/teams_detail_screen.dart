import 'package:flutter/material.dart';

import '../feed/feed_screen.dart';
import '../models/team.dart';

class TeamsDetail extends StatefulWidget {
  final Team team;
  TeamsDetail({@required this.team});
  @override
  _TabsScreenState createState() => _TabsScreenState(team: team);
}

class _TabsScreenState extends State<TeamsDetail> {
  final Team team;
  _TabsScreenState({this.team});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
          bottom: TabBar(
            labelColor: Color.fromRGBO(0, 125, 167, 1),
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.pool,
                  color: Color.fromRGBO(0, 125, 167, 1),
                ),
                text: 'Athletes',
              ),
              Tab(
                icon: Icon(
                  Icons.star,
                  color: Color.fromRGBO(0, 125, 167, 1),
                ),
                text: 'Favorites',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FeedScreen(),
            FeedScreen(),
          ],
        ),
      ),
    );
  }
}
