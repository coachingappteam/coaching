import 'package:flutter/material.dart';

class Session {
  final DateTime sessionDate;
  final bool isCompetition;
  final String location;
  final String sessionDescription;
  final int sessionID;
  final String sessionTitle;
  final int parentPlanID;

  Session({
    @required this.isCompetition,
    @required this.sessionTitle,
    @required this.sessionID,
    @required this.sessionDescription,
    @required this.sessionDate,
    @required this.location,
    @required this.parentPlanID,
  });
}
