import 'package:flutter/material.dart';

import '../../models/athlete.dart';
import 'add_coach_screen.dart';
import '../../main_color.dart';

class CoachesScreen extends StatefulWidget {
  @override
  _CoachesScreenState createState() => _CoachesScreenState();
}

class _CoachesScreenState extends State<CoachesScreen> {
  @override
  Widget build(BuildContext context) {
    List<Athlete> getAthletes() {
      List<Athlete> athletes = [];
      return athletes;
    }

    final list = getAthletes();
    ListTile makeListTile(Athlete athlete) => ListTile(
//      onTap: () {
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => TeamsDetail(
//              //team: team,
//            ),
//          ),
//        );
//      },
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(
              Icons.person,
              color: MainColor().mainColor(),
            ),
          ),
          title: Text(
            athlete.firstName + athlete.lastName,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Icon(
                Icons.mail_outline,
                color: MainColor().mainColor(),
              ),
              Text(athlete.email, style: TextStyle(color: Colors.black))
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        );

    Card makeCard(Athlete athlete) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: makeListTile(athlete),
          ),
        );
    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(list[index]);
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Coaches'),
        iconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        actionsIconTheme: IconThemeData(
          color: MainColor().mainColor(),
        ),
        brightness: Brightness.light,
      ),
      backgroundColor: Colors.white,
      body: makeBody,
      floatingActionButton: FloatingActionButton(
        splashColor: MainColor().lightMainColor(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCoachScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
