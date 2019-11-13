import 'package:flutter/material.dart';
import 'dart:convert';

import '../http_requests/my_teams_http_requests.dart';
import '../main_color.dart';

class AddTeamScreen extends StatefulWidget {
  _AddTeamScreenState createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends State<StatefulWidget> {
  var _controllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  var _textValidations = [true, true];

  showErrorDialog(String title, String description){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(description),
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

  addNewTeam() async {
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
      if(_DropdownExampleState().value == null){
        showErrorDialog('No sport selected', 'Sport field can\'t be empty');
      } else{
        var request = await MyTeamsHttpRequests().createTeam(_controllers[0].text, _controllers[1].text);
        var data = json.decode(request);
        if(data['Success'] != null){
          Navigator.pop(context);
        } else{
          showErrorDialog('Unexpected error', 'Please try again');
        }
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
                addNewTeam();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.assignment),
              title: TextField(
                controller: _controllers[0],
                decoration: InputDecoration(
                  hintText: 'Team name',
                  errorText:
                      !_textValidations[0] ? 'Value Can\'t Be Empty' : null,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.accessibility_new),
              title: DropdownButtonOptions(),
            ),
            ListTile(
              leading: Icon(Icons.drag_handle),
              title: TextField(
                controller: _controllers[1],
                decoration: InputDecoration(
                  hintText: 'Team description',
                  errorText:
                      !_textValidations[1] ? 'Value Can\'t Be Empty' : null,
                ),
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
  String value = 'Swimming';

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
            value = value;
          });
        },
        hint: Text('Select sport'),
        value: value,
      ),
    );
  }
}
