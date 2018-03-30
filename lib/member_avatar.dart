import 'dart:math' as math;
import 'package:flutter/material.dart';

class MemberAvatar extends StatefulWidget {

  final bool init;

  MemberAvatar({Key key, this.init}): super(key: key);

  @override
  _MemberAvatarState createState() => new _MemberAvatarState(init: true);
}

class _MemberAvatarState extends State<MemberAvatar> with TickerProviderStateMixin {

  _MemberAvatarState({this.init});
  bool init;

  TabController _tabController;
  int _currentPage = 0;

  List<AnimationController> _inAnimationControllers = <AnimationController>[];
  List<AnimationController> _outAnimationControllers = <AnimationController>[];

  _makeAnimatedContentWidget({Widget child}) {
    // out animation
    final outAnimationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    Animation<double> outScaleAnimation = new CurvedAnimation(
      parent: outAnimationController,
      curve: Curves.easeOut,
    );
    final outScaleTween = new Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(outScaleAnimation);
    Animation<double> slideAnimation = new CurvedAnimation(
      parent: outAnimationController,
      curve: Curves.easeOut,
    );
    final outSlideTween = new Tween(
      begin: const Offset(0.0, 0.0),
      end: const Offset(3.0, 0.0),
    ).animate(slideAnimation);
    _outAnimationControllers.add(outAnimationController);

    // in animation
    final inAnimationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    Animation<double> inScaleAnimation = new CurvedAnimation(
      parent: inAnimationController,
      curve: Curves.linear,
    );
    final inScaleTween = new Tween(
      begin: 0.6,
      end: 1.0,
    ).animate(inScaleAnimation);
    _inAnimationControllers.add(inAnimationController);

    // widgets
    var outAnimationWrapper = new SlideTransition(
      position: outSlideTween,
      child: new ScaleTransition(
        scale: outScaleTween,
        child: child,
      ),
    );
    var inAnimationWrapper = new ScaleTransition(
      scale: inScaleTween,
      child: outAnimationWrapper,
    );
    return inAnimationWrapper;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //_inAnimationControllers[0].value = 1.0;

    final children = <Widget>[];
    for (int i = 0; i < 7; i++) {
      children.add(
        new Center(
          child: _makeAnimatedContentWidget(
            child:  new CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.white,
                child: new ClipOval(
                    child: new Image.asset('assets/image/user_avatar.png', color: Colors.grey[400])
                )
            ),
          ),
        ),
      );
    }
    return new Material(
      child: new NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            final PageMetrics metrics = notification.metrics;
            final int page = (metrics.pixels / screenWidth).floor();
            final offset = (metrics.pixels - (page * screenWidth)).clamp(0, double.MAX_FINITE);
            _outAnimationControllers[page].value = (offset / screenWidth);
            if (page < (_inAnimationControllers.length - 1)) {
              _inAnimationControllers[page + 1].value = (offset / screenWidth);
            }
          } else if (notification is ScrollEndNotification) {
            final PageMetrics metrics = notification.metrics;
            _currentPage = metrics.page.round();
            _tabController.animateTo(_currentPage);
          }
          return false;
        },
        child: new PageView(
          children: children,
        ),
      ),
    );
  }


}