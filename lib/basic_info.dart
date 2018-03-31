import 'package:CodingDojoAngola/member.dart';
import 'package:flutter/material.dart';

class MemberBasicInfo extends StatelessWidget {

  final Member member;

  MemberBasicInfo(this.member);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: new Card(
        child: new Container(
          height: 200.0,
          child: new Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(top: 20.0, right: 15.0),
              child: new Column(
                children: <Widget>[
                  new Text(
                      '${member.name}',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'Mina')
                  ),
                  new Text(
                      '${member.email}',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'Mina')
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
