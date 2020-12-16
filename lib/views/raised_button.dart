import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class CRaisedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final bool loading;
  final double radius;

  const CRaisedButton(
      {Key key,
      this.onPressed,
      this.child,
      this.radius = 5.0,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, __) {
        return Container(
            width: __.maxWidth,
            height: 45,
            child: Theme(
              data: ThemeData(
                  buttonTheme: ButtonThemeData(
                      height: 45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      textTheme: ButtonTextTheme.primary),
                  textTheme: TextTheme(
                    button:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              child: loading
                  ? BounceInUp(
                      child: LoadingBouncingGrid.square(
                          size: 45,
                          backgroundColor: Colors.blueAccent,
                          inverted: true))
                  : RaisedButton(onPressed: onPressed, child: child),
            ));
      },
    );
  }
}

class CRaisedTimerButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double radius;
  final int timer;

  const CRaisedTimerButton(
      {Key key, this.onPressed, this.child, this.radius = 5.0, this.timer = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, __) {
        return Container(
            width: timer > 0 ? 45 : __.maxWidth,
            height: 45,
            child: Theme(
              data: ThemeData(
                  buttonTheme: ButtonThemeData(
                      height: 45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      textTheme: ButtonTextTheme.primary),
                  textTheme: TextTheme(
                    button:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              child: timer > 0
                  ? BounceInUp(
                      child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.red,
                            width: 5,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      child: Text("$timer"),
                    ))
                  : RaisedButton(onPressed: onPressed, child: child),
            ));
      },
    );
  }
}
