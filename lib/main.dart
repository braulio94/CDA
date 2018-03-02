import 'dart:convert';
import 'package:cda_members/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(
  new MaterialApp(
    home: new CDAStart()
  )
);

enum AppBarBehavior { normal, pinned, floating, snapping }
const double _kViewportFraction = 0.3;


class CDAStart extends StatefulWidget {
  @override
  _CDAStartState createState() => new _CDAStartState();
}

class _CDAStartState extends State<CDAStart> with SingleTickerProviderStateMixin {

  Map members;
  List<Member> memberList = new List();
  final PageController _pageController = new PageController(viewportFraction: _kViewportFraction);
  ValueNotifier<double> selectedIndex = new ValueNotifier<double>(0.0);
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  _loadMembers()async {
    var url = "https://codingdojo-79fd2.firebaseio.com/members.json";
    var httpClient = createHttpClient();
    var response = await httpClient.get(url);
    print('response'+ response.body);
    setState((){
      members = jsonCodec.decode(response.body);
    });

    for(String member in members.keys){
      print('Disponibilities: ${members[member].disponibilities}');
      memberList.add(new Member(members[member].beltColor, members[member].id, members[member].name, members[member].photoUri));
    }

    print('members.len='+ members.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification.depth == 0 && notification is ScrollUpdateNotification) {
                selectedIndex.value = _pageController.page;
                setState(() {});
              }
            },
            child: new PageView(
              controller: _pageController,
              children: _buildPages(),
            ),
          ),
        ],
      ),
    );
  }

  Iterable<Widget> _buildPages() {
    final List<Widget> pages = <Widget>[];
    for (int index = 0; index < memberList.length; index++) {
      var alignment = Alignment.topCenter.add(new Alignment(
          (selectedIndex.value - index) * _kViewportFraction, 0.0));
      var resizeFactor = (1 - (((selectedIndex.value - index).abs() * 0.3).clamp(0.0, 1.0)));
      print('resize factor: $resizeFactor');
      pages.add(new Container(
        margin: const EdgeInsets.only(top: 60.0),
        alignment: alignment,
        child: new CircleAvatar(
          radius: 40.0 * resizeFactor,
          child: new ClipOval(
            child: new Image.network(
              memberList[index].photoUri,
            ),
          ),
        ),
      ));
    }
    return pages;
  }
}

const jsonCodec = const JsonCodec(reviver: _reviver);

_reviver(key, value) {
  if(key != null && value is Map && key.contains("-")){
    return new Member.fromJson(value);
  }
  return value;
}
