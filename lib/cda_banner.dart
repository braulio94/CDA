import 'package:flutter/material.dart';


class CDALogoBanner extends StatelessWidget {

  final double offset;

  CDALogoBanner({
    this.offset
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.bottomRight.add(new FractionalOffset(offset, 0.45)),
      child: new DecoratedBox(
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(30.0)),
        child: new ClipRRect(
          borderRadius: new BorderRadius.circular(30.0),
          child: new MaterialButton(
              height: 60.0,
              minWidth: 250.0,
              onPressed: (){
                Navigator.push(
                  context,
                  new HeroDialogRoute(
                    builder: (BuildContext context) {
                      return new Center(
                        child: new AlertDialog(
                          title: new Text(
                              'About',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontFamily: 'Mina')
                          ),
                          content: new Container(
                            constraints: new BoxConstraints(
                              maxHeight: 250.0,
                              maxWidth: 350.0
                            ),
                          child: new Column(
                            children: <Widget>[
                              new Hero(
                                tag: 'logo-hero',
                                child: new Container(
                                  alignment: Alignment.topCenter,
                                  margin: const EdgeInsets.only(bottom: 20.0),
                                  height: 80.0,
                                  width: 80.0,
                                  child: new Image.asset('assets/image/cda_logo.png'),
                                ),
                              ),
                              new Text(
                                'Coding Dojo Angola is a space where interested in software development in Angola can meet to learn and teach programming, look for information about job vacancies in the information technology industry and for companies to find Angolan talent.',
                                style: const TextStyle(fontSize: 13.0, fontFamily: 'Mina'),
                              )
                            ],
                          )
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              color: Colors.grey[900],
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Hero(
                    tag: 'logo-hero',
                    child: new Container(
                      height: 40.0,
                      width: 40.0,
                      child: new Image.asset('assets/image/cda_logo.png'),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    child: new Text(
                        'Coding Dojo Angola',
                        textAlign: TextAlign.end,
                        style: const TextStyle(fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w800, fontFamily: 'Mina')
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({ this.builder }) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(
        opacity: new CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut
        ),
        child: child
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  String get barrierLabel => null;

}