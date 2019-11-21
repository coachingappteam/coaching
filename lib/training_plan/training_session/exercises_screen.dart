import 'package:flutter/material.dart';

import '../../models/session.dart';

class ExercisesScreen extends StatefulWidget {
  final Session session;

  ExercisesScreen({@required this.session});

  _ExercisesState createState() => _ExercisesState(session: this.session);
}

class _ExercisesState extends State<ExercisesScreen> {
  final Session session;

  _ExercisesState({@required this.session});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Text('hi'),
    );
  }
}
