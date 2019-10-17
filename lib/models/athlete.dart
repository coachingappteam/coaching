import 'package:flutter/material.dart';

class Athlete{
  final int id;
  final String name;
  final double weight;
  final String sex;

  const Athlete({
    @required this.id,
    @required this.name,
    @required this.weight,
    @required this.sex
  });
}