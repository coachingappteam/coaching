import 'package:flutter/material.dart';

class Practice {
  final int practiceID;
  final int repetition;
  final double measure;
  final int exerciseID;
  final int unitID;
  final String exerciseDescription;
  final String exerciseName;
  final String unit;

  Practice({
    @required this.practiceID,
    @required this.repetition,
    @required this.measure,
    @required this.exerciseID,
    @required this.unitID,
    @required this.exerciseDescription,
    @required this.exerciseName,
    @required this.unit
  });
}
