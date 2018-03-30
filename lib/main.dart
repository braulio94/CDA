import 'dart:convert';
import 'package:cda_members/cda_banner.dart';
import 'package:cda_members/member.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(
    new MaterialApp(
      color: Colors.red,
        home: new Scaffold(
          body: new CDAStart(),
        )
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
  ValueNotifier<double> offset = new ValueNotifier<double>(0.0);
  ValueNotifier<int> page = new ValueNotifier<int>(0);

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

  _handleScrollNotification(ScrollNotification notification){
    if(notification is ScrollStartNotification){
      offset.value = 2.0;
    }
    if(notification is ScrollEndNotification){
      offset.value = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [Colors.redAccent[200], Colors.red[700]],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.0, 0.5),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
        ),
      ),
      child: new Stack(
        children: <Widget>[
          new NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification){
              _handleScrollNotification(notification);
              setState(() {});
            },
            child: new CustomScrollView(
              physics: new BouncingScrollPhysics(),
              slivers: <Widget>[
                new SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: new _SliverAppBarDelegate(
                    minHeight: 90.0,
                    maxHeight: 200.0,
                    child: new Container(
                      padding: const EdgeInsets.only(top: 30.0),
                      alignment: Alignment.bottomLeft.add(new FractionalOffset(0.58, 1.0)),
                      child: new CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.white,
                        child: new ClipOval(
                            child: memberList.isEmpty ? new Image.asset('assets/image/user_avatar.png', color: Colors.grey[300]) : new Image.network(memberList[page.value].photoUri),
                        ),
                      )
                    ),
                  ),
                ),
                new SliverToBoxAdapter(
                  child: new SizedBox(
                    height: 800.0,
                    child: new PageView(
                      //physics: new NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          page.value = index;
                        });
                      },
                      controller: pageController,
                      children: memberList.map((Member member){
                        return new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                              child: new Card(
                                child: new Container(
                                  height: 200.0,
                                  child: new Text('${member.name}', textAlign: TextAlign.right, style: const TextStyle(fontSize: 20.0, color: Colors.black)),
                                ),
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                              child:new Card(
                                child: new Container(
                                  height: 150.0,
                                ),
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                              child:new Card(
                                child: new Container(
                                  height: 150.0,
                                ),
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                              child:new Card(
                                child: new Container(
                                  height: 150.0,
                                ),
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
          new CDALogoBanner(offset: offset.value)
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