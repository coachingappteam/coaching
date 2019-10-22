import 'package:flutter/material.dart';

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TabNavigation()),
        );
      } else {
        setState(() {
          print(_firstIndex);
          _firstIndex++;
        });
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

  bool obscureText(){
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
