import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main_color.dart';
import '../training_plan/training_session/add_training_session.dart';
import '../training_plan/training_session/training_session_details.dart';
import '../http_requests/training_sessions_http_requests.dart';
import '../models/feed_session.dart';
import '../manager/date_convertert.dart';

class FeedScreen extends StatefulWidget {
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  initState() {
    super.initState();
    getSessions();
  }

  List<FeedSession> list = [];

  Future<FeedSession> getSessions() async {
    var request = await TrainingSessionsHttpRequests().getAll();
    List<FeedSession> sess = [];
    for (int i = 0; i < request.length; i++) {
      var rSession = request[i];
      var tmpSess = FeedSession(
        title: rSession['title'],
        teamName: rSession['teamName'],
        coachID: rSession['coachID'],
        isCompetition: rSession['isCompetition'],
        location: rSession['location'],
        planDescription: rSession['planDescription'],
        planID: rSession['planID'],
        sessionDate: DateFormat("yyyy/MM/dd", "en_US")
            .parse(DateConverter().convertDate(rSession['sessionDate'])),
        sessionDescription: rSession['sessionDescription'],
        sessionID: rSession['sessionID'],
        sessionTitle: rSession['sessionTitle'],
        teamID: rSession['teamID'],
      );
      sess.add(tmpSess);
    }
    setState(() {
      list = sess;
    });
  }

  Widget trailing(FeedSession session) {
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
    ListTile makeListTile(FeedSession session) => ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrainingSessionDetails(
                  sessionID: session.sessionID,
                  isLast: session.isCompetition,
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

    Card makeCard(FeedSession session) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: makeListTile(session),
          ),
        );

    Widget makeBody() {
      if (list.length == 0) {
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
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(list[index]);
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text('Feed'),
        iconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
      ),
      body: makeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: showAlert,
        backgroundColor: MainColor().darkMainColor(),
        child: Icon(Icons.add),
      ),
    );
  }
}
