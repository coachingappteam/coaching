import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/team.dart';

class TrainingSessionsHttpRequests {
  Future<List> getTrainingSessions(Team team) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    var body = {
      "search": "",
      "teamID": team.teamId
    };
    var response = await http.post(
      "https://coachingpr.herokuapp.com/plan/search",
      headers: {
        "Content-Type": "application/json",
        "token": token,
      },
      body: json.encode(body),
    );
    var data = jsonDecode(response.body);

    return data['Plans'];
  }
}