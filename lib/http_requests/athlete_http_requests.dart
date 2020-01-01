import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/team.dart';

class AthleteHttpRequests {
  Future<List> getAthletes(int teamID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    var response = await http.get(
        'https://coachingpr.herokuapp.com/coach/team/member/athletes/' +
            teamID.toString(),
        headers: {
          "Content-Type": "application/json",
          "token": token,
        });
    var data = json.decode(response.body);
    return data['Athletes'];
  }

  Future<List> getAllAthletes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    var body = {
      "search": "",
    };
    var response = await http.post(
      'https://coachingpr.herokuapp.com/coach/athlete/search',
      headers: {
        "Content-Type": "application/json",
        "token": token,
      },
      body: json.encode(body),
    );
    var data = json.decode(response.body);
    return data['Athletes'];
  }

  Future<String> createAthlete(String athlete, int teamID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    var response = await http.post(
      'https://coachingpr.herokuapp.com/coach/athlete/create',
      headers: {
        "Content-Type": "application/json",
        "token": token,
      },
      body: athlete,
    );
    var data = jsonDecode(response.body);
    if (data['athleteID'] != null) {
      var body = {
        "athleteID": data['athleteID'],
        "teamID": teamID,
      };
      var response2 = await http.post(
        'https://coachingpr.herokuapp.com/coach/team/member/create',
        headers: {
          "Content-Type": "application/json",
          "token": token,
        },
        body: json.encode(body),
      );
      var data2 = jsonDecode(response2.body);
      print(data2);
      if (data2['Success'] != null) {
        return "OK";
      }
    }
  }
}
