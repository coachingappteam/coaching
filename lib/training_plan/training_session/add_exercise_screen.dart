import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main_color.dart';
import '../../models/exercise.dart';

class AddExerciseScreen extends StatefulWidget {
  _AddExerciseScreenState createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  String exercise;
  var exerciseList = [];

  ListTile makeListTile(Exercise exercise) => ListTile(
    onTap: () {
//      Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (context) => TeamsDetail(
//            team: team,
//          ),
//        ),
//      );
    },
    contentPadding:
    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: Icon(
        Icons.pool,
        color: MainColor().mainColor(),
      ),
    ),
    title: Text(
      'hdhd',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    subtitle: Row(
      children: <Widget>[
        Icon(Icons.linear_scale, color: MainColor().mainColor()),
        Text(
          'djdjd',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    ),
    trailing:
    Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
  );

  Card makeCard(Exercise exercise) => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.white),
      child: makeListTile(exercise),
    ),
  );

  Widget makeBody() {
    if (exerciseList != null) {
      if (exerciseList.length == 0) {
        return new Container(
          child: Center(
            child: Text('No exercises'),
          ),
        );
      } else {
        return new Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: exerciseList.length,
            itemBuilder: (BuildContext context, int index) {
              return makeCard(exerciseList[index]);
            },
          ),
        );
      }
    } else {
      return new Container(
        child: Center(
          child: Text('No teams'),
        ),
      );
    }
  }

  _showDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text('Add Exercise'),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        hintText: 'Repetition'),
                  ),
                ),
                new Expanded(
                  child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        hintText: 'Measurement'),
                  ),
                ),
                new Expanded(
                  child: Container(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: [
                        DropdownMenuItem<String>(
                          child: Text('M'),
                          value: 'M',
                        ),
                        DropdownMenuItem<String>(
                          child: Text('Y'),
                          value: 'F',
                        ),
                        DropdownMenuItem<String>(
                          child: Text('Z'),
                          value: 'X',
                        ),
                      ],
                      onChanged: (String value) {
                        setState(() {
                          this.exercise = value;
                        });
                      },
                      hint: Text('Select sex'),
                      value: exercise,
                    ),
                  ),
                  ),
              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Save"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Set'),
        iconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        actionsIconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        backgroundColor: Colors.white,
      ),
      body: makeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

class DropdownButtonOptions extends StatefulWidget {
  _DropdownExampleState createState() => _DropdownExampleState();

  getDropValue(){
    return _DropdownExampleState().value;
  }
}

class _DropdownExampleState extends State<DropdownButtonOptions> {
  String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        isExpanded: true,
        items: [
          DropdownMenuItem<String>(
            child: Text('Swimming1'),
            value: 'Swimming1',
          ),
          DropdownMenuItem<String>(
            child: Text('Swimming2'),
            value: 'Swimming2',
          )
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
