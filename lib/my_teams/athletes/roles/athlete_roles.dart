import 'package:flutter/material.dart';

import '../../../models/athlete.dart';
import '../../../models/role.dart';
import '../../../http_requests/roles_http_requests.dart';
import '../../../main_color.dart';

class AthleteRoles extends StatefulWidget {
  final Athlete athlete;

  AthleteRoles({@required this.athlete});

  _AthleteRolesState createState() => _AthleteRolesState(athlete: this.athlete);
}

class _AthleteRolesState extends State<AthleteRoles> {
  Athlete athlete;
  List<DropdownMenuItem<int>> drpRoles;
  int selectedRole;
  List<Role> roleList = [];

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    getRoles(true);
  }

  _AthleteRolesState({@required this.athlete});

  Future<List> getRoles(bool isAthlete) async {
    var request;
    if (isAthlete) {
      request = await RolesHttpRequests().getAthleteRoles(athlete);
      List<Role> tmpRoleList = [];
      for (int i = 0; i < request.length; i++) {
        var rRole = request[i];
        var tmpRole = Role(
          roleID: rRole['roleID'],
          roleDescription: rRole['roleDescription'],
          roleName: rRole['roleName'],
        );
        tmpRoleList.add(tmpRole);
      }
      setState(() {
        roleList = tmpRoleList;
      });
    } else {
      request = await RolesHttpRequests().getRoles();
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
  }

  Future<bool> createRole() async {
    bool success =
        await RolesHttpRequests().createRole(selectedRole, athlete.id);
    if (success) {
      Navigator.pop(context);
      getRoles(true);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Already added role'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }

  showPopup() {
    getRoles(false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text('Add Role'),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: Container(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      items: drpRoles,
                      onChanged: (int value) {
                        setState(() {
                          Navigator.pop(context);
                          this.selectedRole = value;
                          print(this.selectedRole);
                          showPopup();
                        });
                      },
                      hint: Text('Select role'),
                      value: selectedRole,
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Save"),
                onPressed: () {
                  createRole();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Role role) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(
              Icons.pool,
              color: MainColor().mainColor(),
            ),
          ),
          title: Text(
            role.roleName,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Icon(Icons.linear_scale, color: MainColor().mainColor()),
              Text(
                role.roleDescription,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        );

    Card makeCard(Role role) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: makeListTile(role),
          ),
        );
    Widget makeBody() {
      if (roleList != null) {
        if (roleList.length == 0) {
          return new Container(
            child: Center(
              child: Text('No roles'),
            ),
          );
        } else {
          return new Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: roleList.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(roleList[index]);
              },
            ),
          );
        }
      } else {
        return new Container(
          child: Center(
            child: Text('No teams'),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: makeBody(),
      floatingActionButton: FloatingActionButton(
        splashColor: MainColor().lightMainColor(),
        onPressed: () {
          showPopup();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
