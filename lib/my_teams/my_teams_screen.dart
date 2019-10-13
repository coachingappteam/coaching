import 'package:flutter/material.dart';

class MyTeamsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text('My Teams'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
