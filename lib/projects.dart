import 'package:flutter/material.dart';

class MemberProjects extends StatelessWidget {

  final String memberId;
  MemberProjects(this.memberId);

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> _buildProjectList(){
      final List<Widget> projectList = <Widget>[];
      for(int index = 0; index < 5; index++){
        projectList.add(
          new Container(
            margin: const EdgeInsets.only(right: 5.0, left: 5.0),
            width: 150.0,
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(1.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(color: Colors.black38,
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                      offset: new Offset(0.0, 1.0)),
                ],
            ),
            child: new Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: new Text('Project\nName', style: const TextStyle(color: Colors.black, fontSize: 13.0, fontFamily: 'Mina')),
            ),
          ),
        );
      }
      return projectList;
    }

    return new Container(
      constraints: const BoxConstraints(maxHeight: 150.0),
      margin: const EdgeInsets.only(top: 10.0),
      child: new Align(
        alignment: Alignment.center,
        child: new ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
                left: 15.0, bottom: 20.0, right: 15.0),
            scrollDirection: Axis.horizontal,
            children: _buildProjectList(),
        ),
      ),
    );
  }
}
