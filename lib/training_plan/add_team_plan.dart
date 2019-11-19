import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';

import '../models/team.dart';
import '../main_color.dart';
import '../http_requests/training_plan_http_requests.dart';

class AddTeamPlan extends StatefulWidget {
  final Team team;

  AddTeamPlan({@required this.team});

  _AddTeamPlanState createState() => _AddTeamPlanState(team: this.team);
}

class _AddTeamPlanState extends State<AddTeamPlan> {
  Team team;
  var _controllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  var _textValidations = [true,true];
  var startDateText = 'Choose Start Date';
  var startDateChosen = Text('Choose Start Date');
  var endDateText = 'Choose End Date';
  var endDateChosen = Text('Choose End Date');

  _AddTeamPlanState({@required this.team});

  changeStartDate(String date) {
    setState(() {
      this.startDateText = date;
      this.startDateChosen = Text(date);
    });
  }
  changeEndDate(String date) {
    setState(() {
      this.endDateText = date;
      this.endDateChosen = Text(date);
    });
  }

  createPlan() async{
    var startDate = DateFormat("yyyy/MM/dd", "en_US").parse(startDateText);
    var endDate = DateFormat("yyyy/MM/dd", "en_US").parse(endDateText);
    var plan = {
      "teamID": this.team.teamId.toString(),
      "parentPlanID": null,
      "title": this._controllers[0].text,
      "planDescription": this._controllers[1].text,
      "startDate": startDateText,
      "endDate": endDateText,
    };
    print(plan);
    var response = await TrainingPlanHttpRequests().createTeamPlan(json.encode(plan));
    print(response);
    if(response != -1){
      Navigator.pop(context);
    } else{
      //paso algo malo
    }
  }

  submitForm() async {
    var copyV = [true, true, true, true];
    var isTextEmpty = false;
    for (int i = 0; i < _controllers.length; i++) {
      var str = _controllers[i].text;
      if (identical(str, '')) {
        copyV[i] = false;
        isTextEmpty = true;
      }
    }
    if (!isTextEmpty && (startDateText != 'Choose Start Date') && (endDateText != 'Choose End Date')) {
      createPlan();
    } else {
      if (startDateText == 'Choose Start Date') {
        print('maaal');
        setState(() {
          this.startDateChosen = Text(
            'Choose Start Date',
            style: TextStyle(
              color: Colors.red,
            ),
          );
        });
      }
      if (endDateText == 'Choose End Date') {
        print('maaal');
        setState(() {
          this.endDateChosen = Text(
            'Choose End Date',
            style: TextStyle(
              color: Colors.red,
            ),
          );
        });
      }
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
        title: Text('Add new plan'),
        iconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        actionsIconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: submitForm,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.border_color),
            title: TextField(
              controller: _controllers[0],
              decoration: InputDecoration(
                hintText: 'Name',
                errorText:
                !_textValidations[0] ? 'Value Can\'t Be Empty' : null,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.drag_handle),
            title: TextField(
              controller: _controllers[1],
              decoration: InputDecoration(
                hintText: 'Description',
                errorText:
                !_textValidations[1] ? 'Value Can\'t Be Empty' : null,
              ),
            ),
          ),
          new ListTile(
            leading: Icon(Icons.date_range),
            title: FlatButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1950, 1, 1),
                    maxTime: DateTime(2024, 12, 31),
                    onChanged: (date) {}, onConfirm: (date) {
                      String formattedDate = DateFormat('MM/dd/yyyy').format(date);
                      changeStartDate(formattedDate);
                      print(formattedDate);
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: startDateChosen,
            ),
          ),
          new ListTile(
            leading: Icon(Icons.date_range),
            title: FlatButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1950, 1, 1),
                    maxTime: DateTime(2024, 12, 31),
                    onChanged: (date) {}, onConfirm: (date) {
                      String formattedDate = DateFormat('MM/dd/yyyy').format(date);
                      changeEndDate(formattedDate);
                      print(formattedDate);
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: endDateChosen,
            ),
          ),
        ],
      ),
    );
  }
}
