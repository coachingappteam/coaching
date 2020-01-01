import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/team.dart';

class TrainingPlanHttpRequests{
  Future<List> getTrainingPlan(Team team) async{
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

  Future<int> createTeamPlan(String plan) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    var response = await http.post(
      "https://coachingpr.herokuapp.com/plan/create",
      headers: {
        "Content-Type": "application/json",
        "token": token,
      },
      body: plan,
    );
    print(response.body);
    var data = json.decode(response.body);
    if(data['planID'] != null){
      return data['planID'];
    }
    return -1;
  }
}