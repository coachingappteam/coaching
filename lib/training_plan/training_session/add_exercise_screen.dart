import 'package:flutter/material.dart';

import '../../main_color.dart';

class AddExerciseScreen extends StatefulWidget {
  _AddExerciseScreenState createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        actionsIconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        title: Text('Add exercise'),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
