import 'package:flutter/material.dart';

import '../../main_color.dart';

class AddCoachScreen extends StatefulWidget {
  _AddCoachScreenState createState() => _AddCoachScreenState();
}

class _AddCoachScreenState extends State<AddCoachScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        iconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        backgroundColor: Colors.white,
        title: Text('Add new coach'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.person,
              color: MainColor().mainColor(),
            ),
            title: TextField(

              decoration: InputDecoration(
                hintText: 'Coach name or email',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
