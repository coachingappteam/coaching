import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../http_requests/training_sessions_http_requests.dart';
import '../../http_requests/exercise_http_requests.dart';
import '../../models/session.dart';
import '../../manager/date_convertert.dart';
import '../../models/practice.dart';
import '../../main_color.dart';

class ExercisesScreen extends StatefulWidget {
  final int sessionID;
  final int subSessionID;

  ExercisesScreen({@required this.sessionID, @required this.subSessionID});

  _ExercisesState createState() => _ExercisesState(
      sessionID: this.sessionID, subSessionID: this.subSessionID);
}

class _ExercisesState extends State<ExercisesScreen> {
  final int sessionID;
  final int subSessionID;
  Session session;
  List<Practice> practiceList = [];

  _ExercisesState({@required this.sessionID, @required this.subSessionID});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionDetails();
  }

  getSessionDetails() async {
    var response =
        await TrainingSessionsHttpRequests().getSessionDetails(sessionID);
    var tmpR = response[sessionID];
    var tempSession = Session(
      isCompetition: tmpR['isCompetition'],
      sessionTitle: tmpR['sessionTitle'],
      sessionID: tmpR['sessionID'],
      sessionDescription: tmpR['sessionDescription'],
      sessionDate: DateFormat("yyyy/MM/dd", "en_US")
          .parse(DateConverter().convertDate(tmpR['sessionDate'])),
      location: tmpR['location'],
      parentPlanID: tmpR['parentPlanID'],
    );

    var response2 =
        await ExerciseHttpRequests().getExercises(tempSession.sessionID);
    List<Practice> tmpL = [];
    for (int i = 0; i < response2.length; i++) {
      var tmpR = response2[i];
      Practice tmpPractice = Practice(
        practiceID: tmpR['practiceID'],
        repetition: tmpR['repetitions'],
        measure: tmpR['measure'],
        exerciseID: tmpR['exerciseID'],
        unitID: tmpR['unitID'],
        exerciseDescription: tmpR['exerciseDescription'],
        exerciseName: tmpR['exerciseName'],
        unit: tmpR['unit'],
      );
      tmpL.add(tmpPractice);
    }

    setState(() {
      this.session = tempSession;
      this.practiceList = tmpL;
    });
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Practice practice) => ListTile(
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
        practice.repetition.toString() + " X " + (practice.measure.floor() * 10).toString() + " " + practice.exerciseName,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Icon(Icons.linear_scale, color: MainColor().mainColor()),
          Text(
            practice.exerciseDescription,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
    );

    Card makeCard(Practice practice) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: makeListTile(practice),
      ),
    );
    Widget makeBody() {
      if (practiceList != null) {
        if (practiceList.length == 0) {
          return new Container(
            child: Center(
              child: Text('No exercises'),
            ),
          );
        } else {
          return new Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: practiceList.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(practiceList[index]);
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
      body: makeBody(),
    );
  }

}
