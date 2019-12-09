import 'package:flutter/material.dart';

import '../main_color.dart';
import 'settings.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text('More'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: <Widget>[
          Container(
            height: 40,
            child: IconButton(
              icon: Icon(Icons.settings),
              color: MainColor().mainColor(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ),
                );
              },
            ),
          ),
        ],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
      ),
    );
  }
}
