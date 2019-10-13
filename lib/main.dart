import 'package:flutter/material.dart';

import './tab_navigation.dart';
import './feed/feed_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coaching',
      theme: new ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Color.fromRGBO(0, 50, 73, 1),
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Color.fromRGBO(0, 125, 167, 1),
          ),
        ),
      ),
      home: TabNavigation(),
    );
  }
}
