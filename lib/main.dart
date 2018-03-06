import 'dart:convert';
import 'package:cda_members/member.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(
    new MaterialApp(
        home: new CDAStart()
    )
);

const jsonCodec = const JsonCodec(reviver: _reviver);

_reviver(key, value) {
  if(key != null && value is Map && key.contains("-")){
    return new Member.fromJson(value);
  }
  return value;
}

class CDAStart extends StatefulWidget {
  @override
  _CDAStartState createState() => new _CDAStartState();
}

class _CDAStartState extends State<CDAStart> with SingleTickerProviderStateMixin {

  Map members;
  List<Member> memberList = new List();
  PageController pageController = new PageController();

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
            onNotification: (ScrollNotification notification){

            },
            child: new CustomScrollView(
              physics: new BouncingScrollPhysics(),
              slivers: <Widget>[
                new SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: new _SliverAppBarDelegate(
                    minHeight: 90.0,
                    maxHeight: 250.0,
                    child: new Container(
                      padding: const EdgeInsets.only(top: 30.0),
                      alignment: Alignment.bottomCenter.add(new Alignment(1.4, 2.0)),
                      child: new ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: members == null ? 0 : members.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            child: new CircleAvatar(
                              radius: 40.0,
                              child: new ClipOval(
                                child: new Image.network(
                                  memberList[index].photoUri,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                new SliverToBoxAdapter(
                  child: new SizedBox(
                    height: 800.0,
                    child: new PageView(
                      physics: new NeverScrollableScrollPhysics(),
                      controller: pageController,
                      children: memberList.map((Member member){
                        return new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new Text('${member.name}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 20.0, color: Colors.black)),
                            new Card(
                              child: new Container(
                                height: 150.0,
                                margin: const EdgeInsets.all(10.0),
                              ),
                            ),
                            new Card(
                              child: new Container(
                                height: 150.0,
                                margin: const EdgeInsets.all(10.0),
                              ),
                            ),
                            new Card(
                              child: new Container(
                                height: 150.0,
                                margin: const EdgeInsets.all(10.0),
                              ),
                            ),
                            new Card(
                              child: new Container(
                                height: 150.0,
                                margin: const EdgeInsets.all(10.0),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            alignment: Alignment.bottomRight.add(new FractionalOffset(2.0, 0.45)),
            child: new DecoratedBox(
              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(30.0)),
              child: new ClipRRect(
                borderRadius: new BorderRadius.circular(30.0),
                child: new MaterialButton(
                  height: 60.0,
                  minWidth: 250.0,
                  onPressed: null,
                  color: Colors.grey[900],
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new CircleAvatar(
                        radius: 20.0,
                        child: new Image(image: new AssetImage('assets/image/cda_logo.png')),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(left: 25.0),
                        child: new Text('Coding Dojo Angola', textAlign: TextAlign.end, style: const TextStyle(fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w800)),
                      )
                    ],
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override double get minExtent => minHeight;
  @override double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight
        || minHeight != oldDelegate.minHeight
        || child != oldDelegate.child;
  }

  @override
  String toString() => '_SliverAppBarDelegate';
}
