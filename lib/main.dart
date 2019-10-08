import 'package:flutter/material.dart';

import './feed/feed_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coaching',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Color.fromRGBO(0, 125, 167, 1),
          ),
        ),
      ),
      home: FeedScreen(),
    );
  }
}

