import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../main_color.dart';
import 'add_training_session.dart';
import '../../models/training_plan.dart';
import '../../models/session.dart';
import '../../http_requests/training_sessions_http_requests.dart';
import '../../manager/date_convertert.dart';
import 'training_session_details.dart';

class TrainingSessionsScreen extends StatefulWidget {
  final TrainingPlan plan;

  TrainingSessionsScreen({@required this.plan});

  _TrainingSessionsState createState() =>
      _TrainingSessionsState(plan: this.plan);
}

class _TrainingSessionsState extends State<TrainingSessionsScreen> {
  final TrainingPlan plan;
  List<Session> sessionList = [];

  _TrainingSessionsState({@required this.plan});

  @override
  initState() {
    super.initState();
    getTrainingSessions();
  }

  Future<List> getTrainingSessions() async {
    var response =
        await TrainingSessionsHttpRequests().getTrainingSessions(plan);
    List<Session> tmpSess = [];
    for (int i = 0; i < response.length; i++) {
      var tmpR = response[i];
      Session tmp = Session(
        isCompetition: tmpR['isCompetition'],
        sessionTitle: tmpR['sessionTitle'],
        sessionID: tmpR['sessionID'],
        sessionDescription: tmpR['sessionDescription'],
        sessionDate: DateFormat("yyyy/MM/dd", "en_US").parse(
          DateConverter().convertDate(tmpR['sessionDate']),
        ),
        location: tmpR['location'],
      );
      tmpSess.add(tmp);
    }
    setState(() {
      sessionList = tmpSess;
    });
  }

  Widget trailing(Session session) {
    if (session.isCompetition) {
      return Icon(
        Icons.playlist_add_check,
        color: MainColor().lightMainColor(),
      );
    } else {
      return Icon(
        Icons.description,
        color: MainColor().lightMainColor(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Session session) => ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrainingSessionDetails(
                  session: session,
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
            session.sessionTitle,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Text('  '),
              Text(
                session.sessionDescription,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          trailing: trailing(session),
        );

    Card makeCard(Session session) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: makeListTile(session),
          ),
        );

    Widget makeBody() {
      if (sessionList.length == 0) {
        return new Container(
          child: Center(
            child: Text('No training sessions'),
          ),
        );
      }
      return Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: sessionList.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(sessionList[index]);
          },
        ),
      );
    }

    Future showAlert() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(8.0),
              title: Text('What do you want to add?'),
              elevation: 8.0,
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTrainingSession()),
                    );
                  },
                  child: Text('Training Session'),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('Meet'),
                ),
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: makeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: showAlert,
        backgroundColor: MainColor().darkMainColor(),
        child: Icon(Icons.add),
      ),
    );
  }
}
