import 'package:flutter/material.dart';

class ChartResult {
  final int id;
  final String firstName;
  final String lastName;
  final double result;
  final String roleName;
  final DateTime sessionDate;
  final String unit;

  ChartResult({
    @required this.id,
    @required this.firstName,
    @required this.sessionDate,
    @required this.roleName,
    @required this.unit,
    @required this.lastName,
    @required this.result,
  });
}
