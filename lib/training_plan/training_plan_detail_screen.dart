import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import '../main_color.dart';
import 'training_session/training_sessions_screen.dart';
import '../models/training_plan.dart';
import '../models/team.dart';

class TrainingPlanDetailScreen extends StatefulWidget {
  final Team team;
  final TrainingPlan plan;

  TrainingPlanDetailScreen({
    @required this.team,
    @required this.plan,
  });

  _TrainingPlanDetailState createState() =>
      _TrainingPlanDetailState(team: this.team, plan: this.plan);
}

class _TrainingPlanDetailState extends State<TrainingPlanDetailScreen> {
  final Team team;
  final TrainingPlan plan;

  _TrainingPlanDetailState({
    @required this.team,
    @required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 1,
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
          title: Text(this.plan.title),
          actions: <Widget>[
          ],
          bottom: TabBar(
            labelColor: MainColor().mainColor(),
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.description,
                  color: MainColor().mainColor(),
                ),
                text: 'Sessions',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TrainingSessionsScreen(plan: this.plan,),
          ],
        ),
      ),
    );
  }
}
