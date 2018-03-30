import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {

  final List<Social> socialList = <Social>[
    new Social('assets/image/social/github-logo.png', ''),
    new Social('assets/image/social/linkedin.png', ''),
    new Social('assets/image/social/meduim.png', ''),
    new Social('assets/image/social/twitter.png', ''),
    new Social('assets/image/social/youtube.png', ''),
  ];

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 30.0,
      child: new Row(
          children: [
            new Image.asset(socialList[0].assetImage),
            new Image.asset(socialList[1].assetImage),
            new Image.asset(socialList[2].assetImage),
            new Image.asset(socialList[3].assetImage),
            new Image.asset(socialList[4].assetImage),
          ]
      ),
    );
  }
}

class Social {
  String assetImage;
  String link;

  Social(this.assetImage, this.link);
}