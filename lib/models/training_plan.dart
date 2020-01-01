import 'package:flutter/material.dart';

class TrainingPlan {
  final DateTime startDate;
  final DateTime endDate;
  final String title;
  final int planID;
  final String planDescription;


  TrainingPlan({
    @required this.startDate,
    @required this.endDate,
    @required this.planID,
    @required this.planDescription,
    @required this.title,
  });
}
