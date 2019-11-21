import 'package:flutter/material.dart';
import 'dart:async';

import '../../models/team.dart';
import '../../models/athlete.dart';
import '../../models/role.dart';
import '../../main_color.dart';
import '../../http_requests/my_teams_http_requests.dart';
import '../../http_requests/athlete_http_requests.dart';
import '../../http_requests/roles_http_requests.dart';
import 'meet_results_charts.dart';

class MeetResultsSetupScreen extends StatefulWidget {
  _MeetResultsSetupState createState() => _MeetResultsSetupState();
}

class _MeetResultsSetupState extends State<MeetResultsSetupScreen> {
  List<Team> teamList = [];
  List<DropdownMenuItem<int>> drpTeam = [];
  List<DropdownMenuItem<int>> drpAthlete = [];
  List<DropdownMenuItem<int>> drpRoles = [];
  List<Athlete> athletesList = [];
  int teamIDSelected;
  int athleteIDSelected;
  int roleIDSelected;

  @override
  initState() {
    super.initState();
    getTeams();
  }

  Future<List<DropdownMenuItem<int>>> getTeams() async {
    var request = await MyTeamsHttpRequests().getTeams();
    List<Team> teams = [];
    List<DropdownMenuItem<int>> drp = [];
    for (int i = 0; i < request.length; i++) {
      var tmpRequestTeam = request[i];
      var tmpTeam = Team(
        teamId: tmpRequestTeam['teamID'],
        teamName: tmpRequestTeam['teamName'],
        sport: 'Swimming',
        description: tmpRequestTeam['teamDescription'],
      );
      teams.add(tmpTeam);
    }
    for (int i = 0; i < teams.length; i++) {
      var tmpDI = DropdownMenuItem<int>(
        child: Text(teams[i].teamName),
        value: teams[i].teamId,
      );
      drp.add(tmpDI);
    }
    print(teams);
    print(drp);
    setState(() {
      drpTeam = drp;
      teamList = teams;
    });
  }

  getAthletes() async {
    var request = await AthleteHttpRequests().getAthletes(this.teamIDSelected);

    List<Athlete> athletes = [];
    if (request != null) {
      for (int i = 0; i < request.length; i++) {
        var tmpRequestAthlete = request[i];
        var tmpAthlete = Athlete(
          id: tmpRequestAthlete['athleteID'],
          firstName: tmpRequestAthlete['firstName'],
          lastName: tmpRequestAthlete['lastName'],
          email: tmpRequestAthlete['email'],
          phone: tmpRequestAthlete['phone'],
          birthDate: tmpRequestAthlete['birthDate'],
          sex: tmpRequestAthlete['sex'],
        );
        athletes.add(tmpAthlete);
      }
      List<DropdownMenuItem<int>> drp = [];
      for (int i = 0; i < athletes.length; i++) {
        var tmpDI = DropdownMenuItem<int>(
          child: Text(athletes[i].firstName + ' ' + athletes[i].lastName),
          value: athletes[i].id,
        );
        drp.add(tmpDI);
      }
      print(drp);
      setState(() {
        drpAthlete = drp;
        athletesList = athletes;
      });
    }
  }

  getAllRoles() async {
    var request = await RolesHttpRequests().getRoles();
    List<DropdownMenuItem<int>> tmpRoleList = [];
    for (int i = 0; i < request.length; i++) {
      var rRole = request[i];
      var tmpRole = Role(
        roleID: rRole['roleID'],
        roleDescription: rRole['roleDescription'],
        roleName: rRole['roleName'],
      );
      DropdownMenuItem<int> drp = DropdownMenuItem(
        child: Text(tmpRole.roleName),
        value: tmpRole.roleID,
      );
      tmpRoleList.add(drp);
    }
    setState(() {
      drpRoles = tmpRoleList;
    });
  }

  createChart() {
    if (teamIDSelected != null &&
        athleteIDSelected != null &&
        roleIDSelected != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MeetResultsCharts(
            teamID: teamIDSelected,
            athleteID: athleteIDSelected,
            roleID: roleIDSelected,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: MainColor().mainColor()),
        actionsIconTheme: IconThemeData(color: MainColor().mainColor()),
        title: Text('Create Chart'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: createChart),
        ],
      ),
      body: Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.assignment),
            title: Container(
              child: DropdownButton<int>(
                isExpanded: true,
                items: drpTeam,
                onChanged: (int value) {
                  setState(() {
                    this.teamIDSelected = value;
                    getAthletes();
                  });
                },
                hint: Text('Select team'),
                value: teamIDSelected,
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.pool),
            title: Container(
              child: DropdownButton<int>(
                isExpanded: true,
                items: drpAthlete,
                onChanged: (int value) {
                  setState(() {
                    this.athleteIDSelected = value;
                    getAllRoles();
                  });
                },
                hint: Text('Select athlete'),
                value: athleteIDSelected,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.linear_scale),
            title: DropdownButton<int>(
              isExpanded: true,
              items: drpRoles,
              onChanged: (int value) {
                setState(() {
                  this.roleIDSelected = value;
                  print(this.roleIDSelected);
                });
              },
              hint: Text('Select role'),
              value: roleIDSelected,
            ),
          ),
        ],
      ),
    );
  }
}
