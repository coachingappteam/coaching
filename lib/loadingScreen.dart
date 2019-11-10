import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'auth/auth_screen.dart';
import 'tab_navigation.dart';
import 'main_color.dart';

class LoadingScreen extends StatefulWidget {
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState(){
    super.initState();
    getToken();
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
    } else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TabNavigation()),
      );
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
