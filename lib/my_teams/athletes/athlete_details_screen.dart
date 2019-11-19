import 'package:flutter/material.dart';

import 'package:coaching/my_teams/athletes/athlete_results.dart';
import '../../models/athlete.dart';
import '../../main_color.dart';

class AthleteDetailsScreen extends StatefulWidget {
  final Athlete athlete;

  AthleteDetailsScreen({@required this.athlete});

  _AthleteDetailsSate createState() =>
      _AthleteDetailsSate(athlete: this.athlete);
}

class _AthleteDetailsSate extends State<AthleteDetailsScreen> {
  final Athlete athlete;

  _AthleteDetailsSate({@required this.athlete});

//  goToInfo() {
//    Navigator.push(
//      context,
//      MaterialPageRoute(
//        builder: (context) => TeamInformationScreen(
//          team: team,
//        ),
//      ),
//    );
//  }

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
          title: Text(this.athlete.firstName + ' ' + this.athlete.lastName),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
            )
          ],
          bottom: TabBar(
            labelColor: MainColor().mainColor(),
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.list,
                  color: MainColor().mainColor(),
                ),
                text: 'Results',
              ),
              Tab(
                icon: Icon(
                  Icons.check,
                  color: MainColor().mainColor(),
                ),
                text: 'Attendance',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AthleteResults(),
            AthleteResults(),
          ],
        ),
      ),
    );
  }
}
