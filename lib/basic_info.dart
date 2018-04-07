import 'package:CodingDojoAngola/member.dart';
import 'package:flutter/material.dart';

class MemberBasicInfo extends StatelessWidget {

  final Member member;

  MemberBasicInfo(this.member);

  Color _getBeltColor(String beltColor){
    switch(beltColor){
      case 'WHITE':
        return Colors.grey[700];
        break;
      case 'BLACK':
        return Colors.black87;
        break;
      case 'ORANGE':
        return Colors.orange[700];
        break;
      case 'BROWN':
        return Colors.brown[700];
        break;
      case 'BLUE':
        return Colors.blueAccent[700];
        break;
      case 'RED':
        return Colors.red[700];
        break;
      case 'YELLOW':
        return Colors.yellow[700];
        break;
      case 'GREEN':
        return Colors.green[700];
        break;
      default:
        return Colors.grey[700];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: new Card(
        child: new Container(
          height: 200.0,
          child: new Stack(
            children: <Widget>[
              new Container(
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
              new Column(
                children: <Widget>[
                  new Container(
                    height: 0.5,
                    width: double.INFINITY,
                    color: Colors.grey[800],
                    margin: const EdgeInsets.only(top: 80.0, bottom: 20.0),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                          'Belt Color',
                          style: const TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'Mina')
                      ),
                      new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        height: 6.5,
                        width: 150.0,
                        decoration: new BoxDecoration(
                            color: _getBeltColor(member.beltColor),
                            borderRadius: new BorderRadius.circular(3.0)
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
