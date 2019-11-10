import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../tab_navigation.dart';
import '../main_color.dart';

class SignIn extends StatefulWidget {
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var _controllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  var _textValidations = [true, true];

  Future<String> loginDB() async {
    var responseBody = {
      "email": _controllers[0].text,
      "password": _controllers[1].text,
    };
    var response = await http.post(
        "https://coachingpr.herokuapp.com/coach/login",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(responseBody));
    print(response.body);
    var data = json.decode(response.body);
    if (data['Error'] != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Error."),
            content: new Text(data['Error']),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      print(data['token']);
      SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.setString(
        'token',
        data['token'],
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TabNavigation()),
      );
    }
  }

  void signIn() {
    var copyV = _textValidations;
    var isTextEmpty = false;
    for (int i = 0; i < _controllers.length; i++) {
      var str = _controllers[i].text;
      if (identical(str, '')) {
        copyV[i] = false;
        isTextEmpty = true;
      }
    }
    if (!isTextEmpty) {
      if (_controllers[0].text.contains("@")) {
        loginDB();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("This is not an email."),
              content: new Text("please provide a real email."),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      setState(() {
        _textValidations = copyV;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: MainColor().mainColor(),
      body: Column(
        children: <Widget>[
          ListTile(),
          ListTile(
            leading: const Icon(
              Icons.alternate_email,
              color: Colors.white,
            ),
            title: new TextField(
              controller: _controllers[0],
              cursorColor: Colors.white,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: new InputDecoration(
                hoverColor: Colors.white,
                helperStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                hintText: "Email",
                errorStyle: TextStyle(color: MainColor().darkMainColor()),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: MainColor().darkMainColor(),
                  ),
                ),
                errorText:
                    !_textValidations[0] ? 'Value Can\'t Be Empty' : null,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.lock_outline,
              color: Colors.white,
            ),
            title: new TextField(
              controller: _controllers[1],
              cursorColor: Colors.white,
              obscureText: true,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: new InputDecoration(
                helperStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                hintText: "Password",
                errorStyle: TextStyle(color: MainColor().darkMainColor()),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: MainColor().darkMainColor(),
                  ),
                ),
                errorText:
                    !_textValidations[1] ? 'Value Can\'t Be Empty' : null,
              ),
            ),
          ),
          ListTile(),
          ListTile(
            title: Center(
              child: Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            onTap: signIn,
          ),
        ],
      ),
    );
  }
}
