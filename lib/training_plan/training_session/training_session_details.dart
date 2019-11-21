import 'package:flutter/material.dart';
import '../../models/session.dart';
import '../../main_color.dart';
import 'exercises_screen.dart';

class TrainingSessionDetails extends StatefulWidget {
  final Session session;
  final bool isLast;

  TrainingSessionDetails({@required this.session, this.isLast});

  _TrainingSessionState createState() =>
      _TrainingSessionState(session: session, isLast: isLast);
}

class _TrainingSessionState extends State<TrainingSessionDetails> {
  final Session session;
  final bool isLast;

  _TrainingSessionState({@required this.session, this.isLast});

  List<Widget> getWidgets() {
    if (isLast) {
      return [
        ExercisesScreen(
          session: this.session,
        ),
      ];
    } else {
      return [
        TrainingSessionDetails(
          session: session,
          isLast: true,
        ),
        TrainingSessionDetails(
          session: session,
          isLast: true,
        ),
        TrainingSessionDetails(
          session: session,
          isLast: true,
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
          text: 'Exercises',
        ),
      ];
    } else {
      return [
        Tab(
          icon: Icon(
            Icons.description,
            color: MainColor().mainColor(),
          ),
          text: 'Exercises',
        ),
        Tab(
          icon: Icon(
            Icons.description,
            color: MainColor().mainColor(),
          ),
          text: 'Exercises',
        ),
        Tab(
          icon: Icon(
            Icons.description,
            color: MainColor().mainColor(),
          ),
          text: 'Exercises',
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
          title: Text(this.session.sessionTitle),
          actions: <Widget>[],
          bottom: TabBar(
            labelColor: MainColor().mainColor(),
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.description,
                  color: MainColor().mainColor(),
                ),
                text: 'Exercises',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ExercisesScreen(
              session: this.session,
            ),
          ],
        ),
      ),
    );
  }
}
