import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AthleteHttpRequests {
  Future<List> getAthletes() async {
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
    print(response.body);
  }
}
