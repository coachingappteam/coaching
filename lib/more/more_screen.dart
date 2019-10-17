import 'package:flutter/material.dart';

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
              color: Color.fromRGBO(0, 125, 167, 1),
            ),
          ),
          Container(
            height: 40,
            child: IconButton(
              icon: Icon(Icons.supervised_user_circle),
              color: Color.fromRGBO(0, 125, 167, 1),
              splashColor: Colors.pink,

            ),
          ),
          Container(
            height: 40,
            child: IconButton(
              icon: Icon(Icons.tune),
              color: Color.fromRGBO(0, 125, 167, 1),
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
