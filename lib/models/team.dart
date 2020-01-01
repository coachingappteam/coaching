import 'package:flutter/material.dart';
class Team{
  final int teamId;
  final String teamName;
  final String sport;
  final String description;

  const Team({
    @required this.teamId,
    @required this.teamName,
    @required this.sport,
    @required this.description
  });
}