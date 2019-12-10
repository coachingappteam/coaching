import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseHttpRequests{

  getExercises(int sessionID) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    var body = {
      "search": "",
      "sessionID": sessionID
    };
    var response = await http.post(
      "https://coachingpr.herokuapp.com/plan/session/practice/search",
      headers: {
        "Content-Type": "application/json",
        "token": token,
      },
      body: json.encode(body),
    );
    print(response.body);
    var data = json.decode(response.body);
    return data['Practices'];
  }
}