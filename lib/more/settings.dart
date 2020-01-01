import 'package:flutter/material.dart';
import '../main_color.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/auth_screen.dart';

class Settings extends StatefulWidget {
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.get('token');
    var request = await http.delete(
      'https://coachingpr.herokuapp.com/coach/signout',
      headers: {
        "Content-Type": "application/json",
        "token": token,
      },
    );

    print(request.body);
    var data = json.decode(request.body);
    if (data['Success'] != null) {
      pref.setString('token', null);
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ),
      );
    } else {
      print('hey');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        actionsIconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        title: Text('Settings'),
      ),
      body: ListTile(
        leading: Icon(
          Icons.close,
        ),
        title: Text(
          'Logout',
        ),
        onTap: logout,
      ),
    );
  }
}
