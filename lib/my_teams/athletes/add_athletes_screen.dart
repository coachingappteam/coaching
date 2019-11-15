import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../../http_requests/athlete_http_requests.dart';
import 'dart:async';
import 'dart:convert';

import '../../main_color.dart';

class AddAthletesScreen extends StatefulWidget {
  _AddAthletesScreenState createState() => _AddAthletesScreenState();
}

class _AddAthletesScreenState extends State<AddAthletesScreen> {
  var options = ['M','F','X'];
  var sex;
  var dateText = 'Choose Birthdate';
  var dateChosen = Text('Choose Birthdate');

  var _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var _textValidations = [true, true, true, true];

  createAthlete() async {
    var birthDate = DateFormat("yyyy/MM/dd", "en_US").parse(dateText);
    print(birthDate);
    var athlete = {
      'firstName': _controllers[0].text,
      'lastName': _controllers[1].text,
      'phone': _controllers[2].text,
      'email': _controllers[3].text,
      'birthdate': birthDate,
      'sex': sex,
    };
    print(athlete);
//    AthleteHttpRequests().createAthlete(athlete);
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
    if (!isTextEmpty && (dateText != 'Choose Birthdate')) {
      createAthlete();
    } else {
      if (dateText == 'Choose Birthdate') {
        print('maaal');
        setState(() {
          this.dateChosen = Text(
            'Choose Birthdate',
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

  changeDate(String date) {
    setState(() {
      this.dateText = date;
      this.dateChosen = Text(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        brightness: Brightness.light,
        actionsIconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        iconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        backgroundColor: Colors.white,
        title: new Text('Add new athlete'),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.save),
            onPressed: submitForm,
          ),
        ],
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              controller: _controllers[0],
              decoration: new InputDecoration(
                hintText: "First Name",
                errorText:
                    !_textValidations[0] ? 'Value Can\'t Be Empty' : null,
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              controller: _controllers[1],
              decoration: new InputDecoration(
                hintText: "Last Name",
                errorText:
                    !_textValidations[1] ? 'Value Can\'t Be Empty' : null,
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextField(
              controller: _controllers[2],
              decoration: new InputDecoration(
                hintText: "Phone",
                errorText:
                    !_textValidations[2] ? 'Value Can\'t Be Empty' : null,
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextField(
              controller: _controllers[3],
              decoration: new InputDecoration(
                hintText: "Email",
                errorText:
                    !_textValidations[3] ? 'Value Can\'t Be Empty' : null,
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: Container(
              child: DropdownButton<String>(
                isExpanded: true,
                items: [
                  DropdownMenuItem<String>(
                    child: Text(options[0]),
                    value: 'M',
                  ),
                  DropdownMenuItem<String>(
                    child: Text(options[1]),
                    value: 'F',
                  ),
                  DropdownMenuItem<String>(
                    child: Text(options[2]),
                    value: 'X',
                  ),
                ],
                onChanged: (String value) {
                  setState(() {
                    this.sex = value;
                  });
                },
                hint: Text('Select sex'),
                value: sex,
              ),
            ),
          ),
          const Divider(
            height: 1.0,
          ),
          new ListTile(
            leading: Icon(Icons.date_range),
            title: FlatButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2022, 12, 31),
                    onChanged: (date) {}, onConfirm: (date) {
                  String formattedDate = DateFormat('yyyy/MM/dd').format(date);
                  changeDate(formattedDate);
                  print(formattedDate);
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: dateChosen,
            ),
          ),
        ],
      ),
    );
  }
}
