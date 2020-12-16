import 'package:flutter/material.dart';

class IfNoneWidget<T> extends StatelessWidget {
  final bool basis;
  final WidgetBuilder builder;
  final Widget none;

  const IfNoneWidget(
      {Key key, @required this.basis, @required this.builder, this.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return basis ? builder(context) : none != null ? none : Container();
  }
}
