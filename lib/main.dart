import 'package:flutter/material.dart';

void main() => runApp(
  new MaterialApp(
    home: new CDAStart()
  )
);


class CDAStart extends StatefulWidget {
  @override
  _CDAStartState createState() => new _CDAStartState();
}

class _CDAStartState extends State<CDAStart> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: new Text(
            'Coding Dojo Angola',
            textDirection: TextDirection.ltr,
          )
      ),
    );
  }
}



