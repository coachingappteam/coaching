import 'package:flutter/material.dart';

import './feed/feed_screen.dart';
import './my_teams/my_teams_screen.dart';
import './statistics/statistics_screen.dart';
import './more/more_screen.dart';

class TabNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabNavigationState();
  }
}

class _TabNavigationState extends State<TabNavigation> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Text> _widgetTitles = <Text>[
    Text(
      'Home',
    ),
    Text(
      'My Teams',
    ),
    Text(
      'Statistics',
    ),
    Text(
      'More',
    ),
  ];
  static List<Widget> _widgetOptions = <Widget>[
    FeedScreen(),
    MyTeamsScreen(),
    StatisticsScreen(),
    MoreScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color.fromRGBO(207,216,220, 1),
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.assignment),
            title: new Text('My Teams'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Statistics'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            title: Text('More'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(0, 125, 167, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
