import 'package:flutter/material.dart';

import '../../models/athlete.dart';
import '../../feed/feed_screen.dart';

class TeamsDetail extends StatefulWidget {
  final Athlete athlete;
  TeamsDetail({@required this.athlete});
  @override
  _TabsScreenState createState() => _TabsScreenState(athlete: athlete);
}

class _TabsScreenState extends State<TeamsDetail> {
  final Athlete athlete;
  _TabsScreenState({this.athlete});

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
          title: Text(this.athlete.name),
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
