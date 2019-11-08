import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../main_color.dart';
import 'add_exercise_screen.dart';

class AddTrainingSession extends StatefulWidget {
  _AddTrainingSessionState createState() => _AddTrainingSessionState();
}

class _AddTrainingSessionState extends State<AddTrainingSession> {
  DateTime _chosenDate = null;
  Widget _getDate(){
    if(_chosenDate == null){
      return Text('Choose Date');
    }
    return Text('$_chosenDate');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        iconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        title: Text('Add a training session'),
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
          Card(
            elevation: 10.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.description),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: 'Practice name',
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.assignment),
                  title: _DropdownButtonOptions(
                    dropType: 'teamNames',
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.linear_scale),
                  title: _DropdownButtonOptions(
                    dropType: 'teamPlans',
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.date_range),
                  title: FlatButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2000, 1, 1),
                          maxTime: DateTime(2022, 12, 31), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        setState(() {
                          _chosenDate = date;
                        });
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: _getDate(),
                  ),
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      'Exercises',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: MainColor().mainColor(),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddExerciseScreen(),
                        ),
                      );
                    },
                  ),
                ),
//          ListView.builder(itemBuilder: null),
              ],
            ),
          ),
          ListTile(
            title: Text('hi'),
          ),
        ],
      ),
    );
  }
}

class _DropdownButtonOptions extends StatefulWidget {
  final String dropType;

  _DropdownButtonOptions({this.dropType});

  _DropdownExampleState createState() =>
      _DropdownExampleState(dropType: this.dropType);
}

class _DropdownExampleState extends State<_DropdownButtonOptions> {
  String _value;
  final String dropType;

  _DropdownExampleState({this.dropType});

  teamNames() {
    return [
      DropdownMenuItem<String>(
        child: Text('Team1'),
        value: 'Team1',
      ),
      DropdownMenuItem<String>(
        child: Text('Team2'),
        value: 'Team2',
      ),
    ];
  }

  teamPlans() {
    return [
      DropdownMenuItem<String>(
        child: Text('Plan 1'),
        value: 'Plan 1',
      ),
      DropdownMenuItem<String>(
        child: Text('Plan 2'),
        value: 'Plan 2',
      ),
    ];
  }

  getPlans(String dropTypes) {
    if (identical(dropTypes, 'teamNames')) {
      return teamNames();
    }
    return teamPlans();
  }

  getHints(String dropTypes) {
    if (identical(dropTypes, 'teamNames')) {
      return Text('Select Team');
    }
    return Text('Select Plan');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        isExpanded: true,
        items: getPlans(this.dropType),
        onChanged: (String value) {
          setState(() {
            _value = value;
          });
        },
        hint: getHints(this.dropType),
        value: _value,
      ),
    );
  }
}
