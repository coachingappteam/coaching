import 'package:flutter/material.dart';

import '../tab_navigation.dart';
import '../main_color.dart';

class SignIn extends StatefulWidget {
  _SigInState createState() => _SigInState();
}

class _SigInState extends State<SignIn> {
  var _controllers = [TextEditingController(),TextEditingController(),];
  var _textValidations = [true,true];

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TabNavigation()),
      );
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
                errorText: !_textValidations[0]
                    ? 'Value Can\'t Be Empty'
                    : null,
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
                errorText: !_textValidations[1]
                    ? 'Value Can\'t Be Empty'
                    : null,
              ),
            ),
          ),
          ListTile(),
          ListTile(
            title: Center(
              child: Text(
                ' Sign In ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MainColor().mainColor(),
                    fontSize: 20.0,
                    backgroundColor: Colors.white),
              ),
            ),
            onTap: signIn,
          ),
        ],
      ),
    );
  }
}
