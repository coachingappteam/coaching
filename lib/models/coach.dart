import 'package:flutter/material.dart';
class Coach{
  final String coachID;
  final String firstName;
  final String lastName;
  final String email;
  final String createDate;
  final bool isActiveMember;
  final bool isActiveUser;
  final bool prefersImperial;
  final bool phone;


  const Coach({
    @required this.coachID,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.phone,
    @required this.createDate,
    @required this.isActiveMember,
    @required this.isActiveUser,
    @required this.prefersImperial
  });
}