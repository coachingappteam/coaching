import 'package:flutter/material.dart';

import '../../../models/athlete.dart';
import '../../../http_requests/results_http_requests.dart';
import '../../../models/athlete_result.dart';
import '../../../main_color.dart';
import '../../../manager/date_convertert.dart';
import 'package:intl/intl.dart';

class AthleteResults extends StatefulWidget{
  final Athlete athlete;
  AthleteResults({@required this.athlete});
  _AthleteResultsState createState() => _AthleteResultsState(athlete: this.athlete);
}

class _AthleteResultsState extends State<AthleteResults> {
  final Athlete athlete;
  List<AthleteResult> results = [];

  _AthleteResultsState({@required this.athlete});


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResults();
  }

  Future<List> getResults() async{
    var request = await ResultsHttpRequests().getAthleteResults(this.athlete);
    List<AthleteResult> tmpRoleList = [];
    for (int i = 0; i < request.length; i++) {
      var rResult = request[i];
      var tmpRole = AthleteResult(
        athleteID: rResult['athleteID'],
        practiceID: rResult['practiceID'],
        result: rResult['result'],
        resultDate: DateFormat("yyyy/MM/dd", "en_US").parse(DateConverter().convertDate(rResult['resultDate'])),
        resultDescription: rResult['resultDescription']
      );
      tmpRoleList.add(tmpRole);
    }
    setState(() {
      results = tmpRoleList;
    });
  }


  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(AthleteResult result) =>
        ListTile(
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
            result.resultDate.toString(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Icon(Icons.linear_scale, color: MainColor().mainColor()),
              Text(
                result.result.toString(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        );

    Card makeCard(AthleteResult result) =>
        Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: makeListTile(result),
          ),
        );
    Widget makeBody() {
      if (results != null) {
        if (results.length == 0) {
          return new Container(
            child: Center(
              child: Text('No roles'),
            ),
          );
        } else {
          return new Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: results.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(results[index]);
              },
            ),
          );
        }
      }
    }
    return makeBody();
  }
}