import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../models/athlete.dart';
import '../../main_color.dart';

class AddAthletesScreen extends StatefulWidget {
  _AddAthletesScreenState createState() => _AddAthletesScreenState();
}

class _AddAthletesScreenState extends State<AddAthletesScreen> {
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
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Name",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Phone",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Email",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.assignment_ind),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Height",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.assignment_ind),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Weight",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Sex",
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
                    maxTime: DateTime(2022, 12, 31), onChanged: (date) {
                  print('change $date');
                }, onConfirm: (date) {
                  print('confirm $date');
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Text(
                'Choose Birthdate',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
