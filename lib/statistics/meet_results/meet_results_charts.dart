import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../http_requests/statistics_http_requests.dart';
import '../../models/chart_result.dart';
import 'package:intl/intl.dart';
import '../../manager/date_convertert.dart';
import '../../main_color.dart';

class MeetResultsCharts extends StatefulWidget {
  final int teamID;
  final int athleteID;
  final int roleID;

  MeetResultsCharts(
      {@required this.teamID, @required this.athleteID, @required this.roleID});

  _MeetResultsChartsState createState() => _MeetResultsChartsState(
        teamID: this.teamID,
        athleteID: this.athleteID,
        roleID: this.roleID,
      );
}

class _MeetResultsChartsState extends State<MeetResultsCharts> {
  List<ChartResult> results = [];
  List<double> data = [];
  List<charts.Series<ChartResult, double>> seriesList = [];
  final int teamID;
  final int athleteID;
  final int roleID;

  _MeetResultsChartsState(
      {@required this.teamID, @required this.athleteID, @required this.roleID});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResults();
  }

  getResults() async {
    var request = await StatisticsHttpRequests()
        .getAnalytics(this.athleteID, this.roleID);
    List<ChartResult> tmpR = [];
    List<double> nm = [];
    for (int i = 0; i < request.length; i++) {
      var r = request[i];
      var tmpResult = ChartResult(
        id: i + 1,
        firstName: r['firstName'],
        sessionDate: DateFormat("yyyy/MM/dd", "en_US")
            .parse(DateConverter().convertDate(r['sessionDate'])),
        roleName: r['roleName'],
        unit: r['unit'],
        lastName: r['lastName'],
        result: r['result'],
      );
      tmpR.add(tmpResult);
      nm.add(i.toDouble());
    }
    var tmpS = [
      charts.Series<ChartResult, double>(
        id: 'Result',
        domainFn: (ChartResult results, _) => results.id.toDouble(),
        measureFn: (ChartResult results, _) => results.result,
        data: tmpR,
      )
    ];
    setState(() {
      seriesList = tmpS;
      data = nm;
      results = tmpR;
    });
  }

  Widget getChart() {
    if (data.length == 0) {
      return Container(
        child: Center(
          child: Text('No charts'),
        ),
      );
    }
    return Column(
      children: <Widget>[
//        Card(
//          child: ListTile(
//            title: Text(
//              results[0].firstName +
//                  ' ' +
//                  results[0].lastName +
//                  ': ' +
//                  results[0].roleName,
//              style: TextStyle(fontSize: 28.0),
//            ),
//            subtitle: Center(
//              child: new Container(
//                width: 300.0,
//                height: 200.0,
//                child: new Sparkline(
//                  data: data,
//                  lineColor: MainColor().mainColor(),
//                ),
//              ),
//            ),
//          ),
//        ),
        Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: charts.LineChart(
              seriesList,
              animate: true,
              behaviors: [
                new charts.ChartTitle(
                  results[0].roleName,
                  subTitle: results[0].firstName + ' ' + results[0].lastName,
                  behaviorPosition: charts.BehaviorPosition.top,
                  titleOutsideJustification: charts.OutsideJustification.start,
                  // Set a larger inner padding than the default (10) to avoid
                  // rendering the text too close to the top measure axis tick label.
                  // The top tick label may extend upwards into the top margin region
                  // if it is located at the top of the draw area.
                  innerPadding: 18,
                ),
                new charts.ChartTitle('Meets',
                    behaviorPosition: charts.BehaviorPosition.bottom,
                    titleOutsideJustification:
                        charts.OutsideJustification.middleDrawArea),
                new charts.ChartTitle('Time (' + results[0].unit + ')',
                    behaviorPosition: charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        charts.OutsideJustification.middleDrawArea),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Meet Results'),
        iconTheme: IconThemeData(color: MainColor().mainColor()),
        actionsIconTheme: IconThemeData(color: MainColor().mainColor()),
      ),
      body: getChart(),
    );
  }
}
