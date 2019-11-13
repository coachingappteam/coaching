import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyTeamsHttpRequests {
  Future<List> getTeams() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    var body = {
      "search": "",
    };
    var response = await http.post(
      "https://coachingpr.herokuapp.com/coach/team/search",
      headers: {
        "Content-Type": "application/json",
        "token": token,
      },
      body: json.encode(body),
    );
    print(response.body);
    var data = json.decode(response.body);
    print(data['Teams']);
    print(data['Teams'].length);
    return data['Teams'];
  }

  Future<String> createTeam(String teamName, String teamDescription) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    var body = {
      "sportID": 1,
      "teamName": teamName,
      "teamDescription": teamDescription
    };
    var response = await http.post(
      "https://coachingpr.herokuapp.com/coach/team/create",
      headers: {
        "Content-Type": "application/json",
        "token": token,
      },
      body: json.encode(body),
    );
    print(response.body);
    return response.body;
  }
}
