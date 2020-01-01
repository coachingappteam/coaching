import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/athlete.dart';

class RolesHttpRequests {
  Future<List> getRoles() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.get('token');
    var body = {
      "search": "",
    };
    var client = http.Client();
    try {
      var response = await client.post(
        "https://coachingpr.herokuapp.com/sport/role/search",
        headers: {
          "Content-Type": "application/json",
          "token": token,
        },
        body: json.encode(body),
      );
      print(response.body);
      var data = json.decode(response.body);
      return data['Roles'];
    } finally {
      client.close();
    }
  }

  Future<List> getAthleteRoles(Athlete athlete) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.get('token');
    var body = {
      "search": "",
    };
    var client = http.Client();
    try {
      var response = await client.get(
        "https://coachingpr.herokuapp.com/coach/athlete/focus/roles/" +
            athlete.id.toString(),
        headers: {
          "Content-Type": "application/json",
          "token": token,
        },
      );
      print(response.body);
      var data = json.decode(response.body);
      return data['Roles'];
    } finally {
      client.close();
    }
  }

  Future<bool> createRole(int roleID, int athleteID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.get('token');
    var body = {
      "roleID": roleID,
      "athleteID": athleteID,
    };
    var client = http.Client();
    try {
      var response = await client.post(
        "https://coachingpr.herokuapp.com/coach/athlete/focus/create",
        headers: {
          "Content-Type": "application/json",
          "token": token,
        },
        body: json.encode(body),

      );
      print(response.body);
      var data = json.decode(response.body);
      if(data['Success'] != null){
        return true;
      }
      return false;
    } finally {
      client.close();
    }
  }
}
