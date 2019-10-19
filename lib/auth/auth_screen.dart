import 'package:flutter/material.dart';

import 'create_account.dart';
import 'sign_in.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          textTheme: TextTheme(
            title: TextStyle(color: Colors.white, fontSize: 24.0),
            button: TextStyle(color: Colors.white, fontSize: 30.0)
          ),
          title: Text('Coaching App'),
          elevation: 0.0,
          brightness: Brightness.dark,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Color.fromRGBO(0, 125, 167, 1),
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          bottom: TabBar(
            indicatorColor: Color.fromRGBO(0, 125, 167, 1),
            labelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'Sign In',
              ),
              Tab(
                text: 'Create Account',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[SignIn(), CreateAccount()],
        ),
      ),
    );
  }
}
