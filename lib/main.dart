import 'package:flutter/material.dart';

import './tab_navigation.dart';
import 'loadingScreen.dart';
import 'auth/auth_screen.dart';
import 'main_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(0, 125, 167, .1),
      100: Color.fromRGBO(0, 125, 167, .2),
      200: Color.fromRGBO(0, 125, 167, .3),
      300: Color.fromRGBO(0, 125, 167, .4),
      400: Color.fromRGBO(0, 125, 167, .5),
      500: Color.fromRGBO(0, 125, 167, .6),
      600: Color.fromRGBO(0, 125, 167, .7),
      700: Color.fromRGBO(0, 125, 167, .8),
      800: Color.fromRGBO(0, 125, 167, .9),
      900: Color.fromRGBO(0, 125, 167, 1),
    };
    MaterialColor customColor = MaterialColor(0xFF007ea7, color);
    return MaterialApp(
      title: 'Coaching',
      theme: new ThemeData(
        appBarTheme: AppBarTheme(brightness: Brightness.light),
        primarySwatch: customColor,
        accentColor: MainColor().darkMainColor(),
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: MainColor().mainColor(),
          ),
        ),
      ),
      home: AuthScreen(),
    );
  }
}
