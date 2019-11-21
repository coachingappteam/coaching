import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/training_plan.dart';
import '../models/session.dart';

class TrainingSessionsHttpRequests {
  Future<List> getTrainingSessions(TrainingPlan plan) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    var body = {"search": "", "planID": plan.planID};
    var response = await http.post(
      "https://coachingpr.herokuapp.com/plan/session/search",
      headers: {
        "Content-Type": "application/json",
        "token": token,
      },
      body: json.encode(body),
    );
    var data = json.decode(response.body);

    print(data);
    return data['Sessions'];
  }

  Future<List> getAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    var body = {
      "search": "",
    };
    var response = await http.post(
      "https://coachingpr.herokuapp.com/plan/session/timeline/search",
      headers: {
        "Content-Type": "application/json",
        "token": token,
      },
      body: json.encode(body),
    );
    print(response.body);
    var data = json.decode(response.body);

    return data['Sessions'];
  }

  Future<List> getExercises(Session session) async{

  }
}
