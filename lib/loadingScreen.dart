import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'auth/auth_screen.dart';
import 'tab_navigation.dart';
import 'main_color.dart';

class LoadingScreen extends StatefulWidget {
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getToken();
  }

  showLogoutDialog(logoutString) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error."),
          content: new Text(logoutString),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    print(token);
    if (token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    } else {
      print(token);
      var response = await http.get(
        "https://coachingpr.herokuapp.com/coach",
        headers: {
          "Content-Type": "application/json",
          "token": token,
        },
      );
      print(response.body);
      var data = json.decode(response.body);
      if (data['Error'] != null) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        final token = pref.setString(
          'token',
          null,
        );
        showLogoutDialog('Login session expired');
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TabNavigation()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColor().mainColor(),
        elevation: 0.0,
      ),
      backgroundColor: MainColor().mainColor(),
    );
  }
}
