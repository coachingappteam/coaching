import 'package:flutter/material.dart';

import 'athlete_details_screen.dart';
import '../../http_requests/athlete_http_requests.dart';
import '../../models/athlete.dart';
import 'add_athletes_screen.dart';
import '../../main_color.dart';

class AthletesScreen extends StatefulWidget {
  @override
  _AthletesState createState() => _AthletesState();
}

class _AthletesState extends State<AthletesScreen> {
  List<Athlete> athletesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeams();
  }

  getTeams() async {
    var request = await AthleteHttpRequests().getAthletes();
    List<Athlete> athletes = [];
    if(request != null){
      for (int i = 0; i < request.length; i++) {
        var tmpRequestAthlete = request[i];
        var tmpAthlete = Athlete(
          id: tmpRequestAthlete['athleteID'],
          firstName: tmpRequestAthlete['firstName'],
          lastName: tmpRequestAthlete['lastName'],
          email: tmpRequestAthlete['email'],
          phone: tmpRequestAthlete['phone'],
          birthDate: tmpRequestAthlete['birthDate'],
          sex: tmpRequestAthlete['sex'],
        );
        athletes.add(tmpAthlete);
      }
      setState(() {
        athletesList = athletes;
      });
    }
  }

  verifyListLength() {
    if (athletesList.length == 0) {
      setState(() {
        athletesList.length = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    ListTile makeListTile(Athlete athlete) => ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AthleteDetailsScreen(
                  athlete: athlete,
                ),
              ),
            );
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
    Widget makeBody(){
      if (athletesList != null) {
        if (athletesList.length == 0) {
          return new Container(
            child: Center(
              child: Text('No athletes'),
            ),
          );
        } else {
          return new Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: athletesList.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(athletesList[index]);
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: makeBody(),
      floatingActionButton: FloatingActionButton(
        splashColor: MainColor().lightMainColor(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAthletesScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
