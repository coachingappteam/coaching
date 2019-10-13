import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        brightness: Brightness.light,
        title: Text('Feed'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text('Welcome to the feed'),
          )
        ],
      ),
    );
  }
}
