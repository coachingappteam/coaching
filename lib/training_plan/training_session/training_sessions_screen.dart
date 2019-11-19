import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'add_training_session.dart';

class TrainingSessionsScreen extends StatefulWidget {
  _TrainingSessionsState createState() => _TrainingSessionsState();
}

class _TrainingSessionsState extends State<TrainingSessionsScreen> {
  Widget makeBody() {
    return new Container(
      child: new Center(
        child: Text('Hi'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: makeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTrainingSession(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
