import 'dart:async';
import 'dart:convert';
import 'package:cda_members/member.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  Map members;

  _loadMembers()async {
    var url = "https://codingdojo-79fd2.firebaseio.com/members.json";
    var httpClient = createHttpClient();
    var response = await httpClient.get(url);
    print('response'+ response.body);
    setState((){
      members = jsonCodec.decode(response.body);
    });

    print('members.len='+ members.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        itemCount: members == null ? 0 : members.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Text('$index'),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    _loadMembers();
  }
}



const jsonCodec = const JsonCodec(reviver: _reviver);



_reviver(key, value) {
  if(key != null && value is Map && key.contains("-")){
    return new Member.fromJson(value);
  }
  return value;
}
