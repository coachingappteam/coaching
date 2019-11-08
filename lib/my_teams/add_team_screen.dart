import 'package:flutter/material.dart';

import '../main_color.dart';

class AddTeamScreen extends StatefulWidget {
  _AddTeamScreenState createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends State<StatefulWidget> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Add new team'),
          iconTheme: IconThemeData(
            color: MainColor().mainColor(),
          ),
          actionsIconTheme: IconThemeData(
            color: MainColor().mainColor(),
          ),
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
              leading: Icon(Icons.assignment),
              title: TextField(
                decoration: InputDecoration(hintText: 'Team name'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.accessibility_new),
              title: DropdownButtonOptions(),
            ),
            ListTile(
              leading: Icon(Icons.drag_handle),
              title: TextField(
                decoration: InputDecoration(hintText: 'Team description'),
              ),
            ),
          ],
        ));
  }
}

class DropdownButtonOptions extends StatefulWidget {
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownButtonOptions> {
  String _value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        isExpanded: true,
        items: [
          DropdownMenuItem<String>(
            child: Text('Swimming'),
            value: 'Swimming',
          ),
        ],
        onChanged: (String value) {
          setState(() {
            _value = value;
          });
        },
        hint: Text('Select sport'),
        value: _value,
      ),
    );
  }
}
