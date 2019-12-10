import 'package:flutter/material.dart';
import '../../models/session.dart';
import '../../main_color.dart';
import 'exercises_screen.dart';
import 'package:intl/intl.dart';

import '../../http_requests/training_sessions_http_requests.dart';
import '../../manager/date_convertert.dart';

class TrainingSessionDetails extends StatefulWidget {
  final int sessionID;
  final bool isLast;

  TrainingSessionDetails({@required this.sessionID, this.isLast});

  _TrainingSessionState createState() =>
      _TrainingSessionState(sessionID: sessionID, isLast: isLast);
}

class _TrainingSessionState extends State<TrainingSessionDetails> {
  final int sessionID;
  final bool isLast;
  Session session;
  String sessionTitle = '';

  _TrainingSessionState({@required this.sessionID, @required this.isLast});

  @override
  initState() {
    super.initState();
    getSession();
  }

  getSession() async {
    var response = await TrainingSessionsHttpRequests().getSession(sessionID);
    Session tmp = Session(
      isCompetition: response['isCompetition'],
      sessionTitle: response['sessionTitle'],
      sessionID: response['sessionID'],
      sessionDescription: response['sessionDescription'],
      sessionDate: DateFormat("yyyy/MM/dd", "en_US")
          .parse(DateConverter().convertDate(response['sessionDate'])),
      location: response['location'],
      parentPlanID: response['parentPlanID'],
    );
    setState(() {
      this.session = tmp;
      this.sessionTitle = this.session.sessionTitle;
      print(this.session);
    });
  }

  List<Widget> getWidgets() {
    if (isLast) {
      return [
        ExercisesScreen(
          sessionID: this.sessionID,
          subSessionID: 0,
        ),
      ];
    } else {
      return [
        ExercisesScreen(
          sessionID: this.sessionID,
          subSessionID: 0,
        ),
        ExercisesScreen(
          sessionID: this.sessionID,
          subSessionID: 1,
        ),
        ExercisesScreen(
          sessionID: this.sessionID,
          subSessionID: 2,
        ),
      ];
    }
  }

  List<Tab> getTabs() {
    if (isLast) {
      return [
        Tab(
          icon: Icon(
            Icons.description,
            color: MainColor().mainColor(),
          ),
          text: 'Events',
        ),
      ];
    } else {
      return [
        Tab(
          icon: Icon(
            Icons.description,
            color: MainColor().mainColor(),
          ),
          text: 'Warm Up',
        ),
        Tab(
          icon: Icon(
            Icons.description,
            color: MainColor().mainColor(),
          ),
          text: 'Main Session',
        ),
        Tab(
          icon: Icon(
            Icons.description,
            color: MainColor().mainColor(),
          ),
          text: 'Cool Down',
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: getTabs().length,
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
          title: Text(this.sessionTitle),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            labelColor: MainColor().mainColor(),
            tabs: getTabs(),
          ),
        ),
        body: TabBarView(
          children: getWidgets(),
        ),
      ),
    );
  }
}
