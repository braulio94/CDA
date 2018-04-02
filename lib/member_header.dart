import 'package:CodingDojoAngola/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
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
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight
        || minHeight != oldDelegate.minHeight
        || child != oldDelegate.child;
  }

  @override
  String toString() => '_SliverAppBarDelegate';
}

class MemberHeader extends StatelessWidget {

  final String photo;
  MemberHeader({this.photo});

  @override
  Widget build(BuildContext context) {
    return  new Container(
      padding: const EdgeInsets.only(top: 50.0),
      alignment: new FractionalOffset(0.1, 2.0),
      child: new CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.white,
        child: new ClipOval(
          child: new Image.network(photo),
        ),
      ),
    );
  }
}