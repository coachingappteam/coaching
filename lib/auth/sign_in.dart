import 'package:flutter/material.dart';

import '../tab_navigation.dart';

class SignIn extends StatefulWidget {
  _SigInState createState() => _SigInState();
}

class _SigInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 125, 167, 1),
      body: Column(
        children: <Widget>[
          ListTile(),
//          ListTile(
//            title: Text(
//              'Welcome Back!',
//              style: TextStyle(
//                  color: Colors.white,
//                  fontSize: 30.0,
//                  decorationStyle: TextDecorationStyle.solid),
//              textAlign: TextAlign.center,
//            ),
//          ),
          ListTile(
            leading: const Icon(
              Icons.alternate_email,
              color: Colors.white,
            ),
            title: new TextField(
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
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.lock_outline,
              color: Colors.white,
            ),
            title: new TextField(
              cursorColor: Colors.white,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: new InputDecoration(
                helperStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                hintText: "Password",
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
                    color: Color.fromRGBO(0, 125, 167, 1),
                    fontSize: 20.0,
                    backgroundColor: Colors.white),
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) =>
                    TabNavigation(),
              ),);
            },
          ),
        ],
      ),
    );
  }
}