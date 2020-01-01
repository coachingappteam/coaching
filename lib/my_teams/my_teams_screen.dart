import 'package:flutter/material.dart';
import 'dart:async';

import '../http_requests/my_teams_http_requests.dart';
import 'teams_detail_screen.dart';
import '../models/team.dart';
import 'add_team_screen.dart';
import '../main_color.dart';

class MyTeamsScreen extends StatefulWidget {
  _MyTeamsScreenState createState() => _MyTeamsScreenState();
}

class _MyTeamsScreenState extends State<MyTeamsScreen> {
  static var teamList = [];

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    getTeams();
  }

  verifyListLength() {
    if (teamList.length == 0) {
      setState(() {
        teamList.length = 0;
      });
    }
  }

  Future<List> getTeams() async {
    var request = await MyTeamsHttpRequests().getTeams();
    List<Team> teams = [];
    for (int i = 0; i < request.length; i++) {
      var tmpRequestTeam = request[i];
      var tmpTeam = Team(
        teamId: tmpRequestTeam['teamID'],
        teamName: tmpRequestTeam['teamName'],
        sport: 'Swimming',
        description: tmpRequestTeam['teamDescription'],
      );
      teams.add(tmpTeam);
    }
    setState(() {
      teamList = teams;
    });
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Team team) => ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeamsDetail(
                  team: team,
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
              Icon(Icons.linear_scale, color: MainColor().mainColor()),
              Text(
                team.description,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
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
    Widget makeBody() {
      if (teamList != null) {
        if (teamList.length == 0) {
          return new Container(
            child: Center(
              child: Text('No teams'),
            ),
          );
        } else {
          return new Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: teamList.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(teamList[index]);
              },
            ),
          );
        }
      } else {
        return new Container(
          child: Center(
            child: Text('No teams'),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text('My Teams'),
        iconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
      ),
      body: makeBody(),
      floatingActionButton: FloatingActionButton(
        splashColor: MainColor().lightMainColor(),
        onPressed: () {
          getTeams();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTeamScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
