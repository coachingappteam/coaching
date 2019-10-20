import 'package:flutter/material.dart';

import '../my_teams/teams_detail_screen.dart';
import '../models/team.dart';
import '../main_color.dart';

class FeedScreen extends StatelessWidget {
  static final list = [
    Team(
        teamId: 1,
        teamName: "Swimming Team 1",
        sport: "Swimming",
        description: "Normal Description"),
    Team(
        teamId: 2,
        teamName: "Swimming Team 2",
        sport: "Swimming",
        description: "Normal Description"),
    Team(
        teamId: 3,
        teamName: "Swimming Team 3",
        sport: "Swimming",
        description: "Normal Description"),
    Team(
        teamId: 4,
        teamName: "Swimming Team 4",
        sport: "Swimming",
        description: "Normal Description"),
    Team(
        teamId: 5,
        teamName: "Swimming Team 5",
        sport: "Swimming",
        description: "Normal Description"),
  ];

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Team team) => ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeamsDetail(
                    //team: team,
                    ),
              ),
            );
          },
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(
              Icons.pool,
              color: MainColor().mainColor(),
            ),
          ),
          title: Text(
            team.teamName,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Icon(
                Icons.linear_scale,
                color: MainColor().mainColor(),
              ),
              Text(" Description ", style: TextStyle(color: Colors.black))
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        );

    Card makeCard(Team team) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: makeListTile(team),
          ),
        );
    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(list[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text('Feed'),
        iconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: makeBody,
      floatingActionButton: FloatingActionButton(
        splashColor: MainColor().lightMainColor(),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
