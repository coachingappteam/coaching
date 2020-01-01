import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsHttpRequests {
  Future<List> getAnalytics(int athleteID, int roleID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.get('token');
    var body = {
      "athleteID": athleteID,
      "roleID": roleID,
    };
    var response = await http.post(
      "https://coachingpr.herokuapp.com/analytic/athlete/role/competition",
      headers: {
        "Content-Type": "application/json",
        "token": token,
      },
      body: json.encode(body),
    );
    var data = json.decode(response.body);
    print(data);
    return data['Results'];

  }
}
