import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget body;
  final double opacity;
  final Widget background;
  final Color backgroundColor;

  const BackgroundWidget(
      {Key key,
      @required this.body,
      this.opacity = 0.2,
      this.background,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) => new SafeArea(
        top: true,
        child: new Stack(
          children: <Widget>[
            new Opacity(
                opacity: opacity ?? 0.2,
                child: new Container(
                  color: backgroundColor ??
                      Theme.of(context).scaffoldBackgroundColor,
                  alignment: Alignment.bottomCenter,
                  child: background ??
                      new Image.asset('assets/images/background.png'),
                )),
            body,
          ],
        ),
      );
}
