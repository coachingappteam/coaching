import 'package:flutter/material.dart';

import '../main_color.dart';
import 'category_item.dart';

class StatisticsScreen extends StatefulWidget {
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('Statistics'),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: MainColor().mainColor()),
        iconTheme: IconThemeData(color: MainColor().mainColor()),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          CategoryItem(
            'Meet Results',
            MainColor().mainColor(),
          ),
          CategoryItem(
            'Athletes Attendance',
            MainColor().mainColor(),
          ),
          CategoryItem(
            'Training Plan',
            MainColor().mainColor(),
          ),
        ],
      ),
    );
  }
}
