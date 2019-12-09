import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/athlete.dart';

class ResultsHttpRequests {
  getAthleteResults(Athlete athlete) async {
    print(athlete.id);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.get('token');
    var body = {
      "search": "",
      "practiceID": null,
      "athleteID": athlete.id,
    };

    var response = await http.post(
      'https://coachingpr.herokuapp.com/plan/session/practice/result/search',
      headers: {
        "Content-Type": "application/json",
        "token": token,
      },
      body: json.encode(body),
    );

    print(response.body);
    var data = json.decode(response.body);
    return data["Results"];
  }
}
