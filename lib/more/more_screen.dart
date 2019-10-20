import 'package:flutter/material.dart';

import '../main_color.dart';

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
            ),
          ),
          Container(
            height: 40,
            child: IconButton(
              icon: Icon(Icons.supervised_user_circle),
              color: MainColor().mainColor(),
              splashColor: Colors.pink,

            ),
          ),
          Container(
            height: 40,
            child: IconButton(
              icon: Icon(Icons.tune),
              color: MainColor().mainColor(),
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
