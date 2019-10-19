import 'package:flutter/material.dart';

import 'athlete_results.dart';
import '../../models/athlete.dart';

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
            color: Color.fromRGBO(0, 125, 167, 1),
          ),
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(
            color: Color.fromRGBO(0, 125, 167, 1),
          ),
          title: Text(this.athlete.firstName + ' ' + this.athlete.lastName),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
            )
          ],
          bottom: TabBar(
            labelColor: Color.fromRGBO(0, 125, 167, 1),
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.list,
                  color: Color.fromRGBO(0, 125, 167, 1),
                ),
                text: 'Results',
              ),
              Tab(
                icon: Icon(
                  Icons.check,
                  color: Color.fromRGBO(0, 125, 167, 1),
                ),
                text: 'Attendance',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[AthleteResults(), AthleteResults()],
        ),
      ),
    );
  }
}
