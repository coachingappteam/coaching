import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../tab_navigation.dart';
import '../main_color.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  var _firstIndex = 0;
  var _textValidations = [
    [
      true,
      true,
      true,
    ],
    [
      true,
      true,
      true,
    ],
  ];
  var controllers = [
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
  ];
  var answers = [
    [
      '',
      '',
      '',
    ],
    [
      '',
      '',
      '',
    ]
  ];

  showErrorDialog(String title, String body) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(title),
            content: new Text(body),
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
        });
  }

  Future<bool> createAccountDB() async {
    var responseBody = {
      "firstName": controllers[1][0].text,
      "lastName": controllers[1][1].text,
      "phone": controllers[1][2].text,
      "password": controllers[0][1].text,
      "email": controllers[0][0].text,
    };
    var response = await http.post(
      "https://coachingpr.herokuapp.com/coach/signup",
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(responseBody),
    );

    var data = json.decode(response.body);
    print(data['Error']);
    if(data['Error'] != null){
      showErrorDialog('Error', data['Error']);
    } else{
      tryLogin(controllers[0][0].text, controllers[0][1].text);
    }
    print(response.body);
  }

  tryLogin(String email, String password) async {
    var responseBody = {
      "email": email,
      "password": password,
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

  void nextForm() {
    var copyV = _textValidations;
    var isTextEmpty = false;
    for (int i = 0; i < controllers[_firstIndex].length; i++) {
      var str = controllers[_firstIndex][i].text;
      if (identical(str, '')) {
        copyV[_firstIndex][i] = false;
        isTextEmpty = true;
      }
    }
    if (!isTextEmpty) {
      if (_firstIndex == 1) {
//        Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(builder: (context) => TabNavigation()),
//        );
        createAccountDB();
      } else {
        //Verify if confirm password and password are equals
        String password = controllers[0][1].text;
        String confirm = controllers[0][2].text;
        if (password == confirm) {
          if (controllers[0][0].text.contains('@')) {
            setState(() {
              print(_firstIndex);
              _firstIndex++;
            });
          } else {
            showErrorDialog(
              "This is not an email.",
              "please provide a real email.",
            );
          }
        } else {
          showErrorDialog(
            "Password doesn't match",
            "Please confirm that your password is the same with the confirm password",
          );
        }
      }
    } else {
      setState(() {
        _textValidations = copyV;
      });
    }
  }

  goBack() {
    if (_firstIndex == 1) {
      setState(() {
        _firstIndex--;
      });
    }
  }

  bool obscureText() {
    return _firstIndex == 0;
  }

  @override
  Widget build(BuildContext context) {
    final buttonText = [
      Text(
        'Next',
        style: TextStyle(color: Colors.white),
      ),
      Text(
        'Create Account',
        style: TextStyle(color: Colors.white),
      ),
    ];
    final createQuestions = [
      ['Email', 'Password', 'Confirm Password'],
      ['First Name', 'Last Name', 'Phone'],
    ];
    final createIcons = [
      [
        Icon(
          Icons.alternate_email,
          color: Colors.white,
        ),
        Icon(
          Icons.lock_open,
          color: Colors.white,
        ),
        Icon(
          Icons.lock_outline,
          color: Colors.white,
        )
      ],
      [
        Icon(
          Icons.assignment_ind,
          color: Colors.white,
        ),
        Icon(
          Icons.assignment_ind,
          color: Colors.white,
        ),
        Icon(
          Icons.phone,
          color: Colors.white,
        )
      ],
    ];

    Widget backButton() {
      if (_firstIndex == 1) {
        return FlatButton(
          splashColor: MainColor().lightMainColor(),
          onPressed: goBack,
          child: Text(
            'Go Back',
            style: TextStyle(color: Colors.white),
          ),
        );
      } else
        return ListTile();
    }

    Column createColumn() {
      return Column(
        children: <Widget>[
          ListTile(
            leading: createIcons[_firstIndex][0],
            title: TextField(
              style: TextStyle(color: Colors.white),
              controller: controllers[_firstIndex][0],
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                hintText: createQuestions[_firstIndex][0],
                hintStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: MainColor().darkMainColor()),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: MainColor().darkMainColor(),
                  ),
                ),
                errorText: !_textValidations[_firstIndex][0]
                    ? 'Value Can\'t Be Empty'
                    : null,
              ),
            ),
          ),
          ListTile(
            leading: createIcons[_firstIndex][1],
            title: TextField(
              style: TextStyle(color: Colors.white),
              controller: controllers[_firstIndex][1],
              obscureText: obscureText(),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                hintText: createQuestions[_firstIndex][1],
                hintStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: MainColor().darkMainColor()),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: MainColor().darkMainColor(),
                  ),
                ),
                errorText: !_textValidations[_firstIndex][1]
                    ? 'Value Can\'t Be Empty'
                    : null,
              ),
            ),
          ),
          ListTile(
            leading: createIcons[_firstIndex][2],
            title: TextField(
              style: TextStyle(color: Colors.white),
              obscureText: obscureText(),
              controller: controllers[_firstIndex][2],
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                hintText: createQuestions[_firstIndex][2],
                hintStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: MainColor().darkMainColor()),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: MainColor().darkMainColor(),
                  ),
                ),
                errorText: !_textValidations[_firstIndex][2]
                    ? 'Value Can\'t Be Empty'
                    : null,
              ),
            ),
          ),
          ListTile(),
          FlatButton(
            splashColor: MainColor().lightMainColor(),
            onPressed: nextForm,
            child: buttonText[_firstIndex],
          ),
          backButton(),
        ],
      );
    }

    // TODO: implement build
    return Scaffold(
      body: createColumn(),
      backgroundColor: MainColor().mainColor(),
    );
  }
}
