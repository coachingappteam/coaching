import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main_color.dart';
import '../models/team.dart';
import '../http_requests/training_plan_http_requests.dart';
import 'add_team_plan.dart';
import '../models/training_plan.dart';
import '../manager/date_convertert.dart';
import 'training_plan_detail_screen.dart';

class TrainingPlanScreen extends StatefulWidget {
  final Team team;

  TrainingPlanScreen({@required this.team});

  _TrainingPlanScreenState createState() =>
      _TrainingPlanScreenState(team: this.team);
}

class _TrainingPlanScreenState extends State<TrainingPlanScreen> {
  Team team;
  List<TrainingPlan> plans = [];

  _TrainingPlanScreenState({@required this.team});

  @override
  initState() {
    super.initState();
    getTrainingPlans();
  }

  getTrainingPlans() async {
    var response = await TrainingPlanHttpRequests().getTrainingPlan(this.team);
    print(response);
    if (response != null) {
      List<TrainingPlan> tmpList = [];
      for (int i = 0; i < response.length; i++) {

        var rPlan = response[i];
        var startDate = DateConverter().convertDate(rPlan['startDate']);
        var endDate = DateConverter().convertDate(rPlan['endDate']);
        var tmpPlan = TrainingPlan(
          startDate: DateFormat("yyyy/MM/dd", "en_US").parse(startDate),
          endDate: DateFormat("yyyy/MM/dd", "en_US").parse(endDate),
          planID: rPlan['planID'],
          planDescription: rPlan['planDescription'],
          title: rPlan['title'],
        );
        tmpList.add(tmpPlan);
      }
      setState(() {
        this.plans = tmpList;
      });
    }
    print(plans);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ListTile makeListTile(TrainingPlan plan) => ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrainingPlanDetailScreen(
              team: this.team,
              plan: plan,
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
          Icons.description,
          color: MainColor().mainColor(),
        ),
      ),
      title: Text(
        plan.title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Icon(Icons.linear_scale, color: MainColor().mainColor()),
          Text(
            plan.planDescription,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
    );

    Card makeCard(TrainingPlan plan) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: makeListTile(plan),
      ),
    );
    Widget makeBody() {
      if (plans != null) {
        if (plans.length == 0) {
          return new Container(
            child: Center(
              child: Text('No teams'),
            ),
          );
        } else {
          return new Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: plans.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(plans[index]);
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
//      appBar: AppBar(
//        title: Text('Training plans'),
//        backgroundColor: Colors.white,
//        actionsIconTheme: IconThemeData(color: MainColor().mainColor()),
//        iconTheme: IconThemeData(color: MainColor().mainColor()),
//      ),
      body: makeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTeamPlan(
                team: this.team,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
