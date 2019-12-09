import 'package:flutter/material.dart';

class AthleteResult {
  final int athleteID;
  final int practiceID;
  final double result;
  final DateTime resultDate;
  final String resultDescription;

  AthleteResult({
    @required this.athleteID,
    @required this.result,
    @required this.practiceID,
    @required this.resultDate,
    @required this.resultDescription,
  });
}
