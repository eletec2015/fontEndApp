import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

bool _isDialogShowing = false;

class LoadingDialog extends StatelessWidget {
  static Future<void> show(BuildContext context, {Key key}) {
    _isDialogShowing = true;
    return showDialog<void>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_) => LoadingDialog(key: key),
    ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));
  }

  static void hide(BuildContext context) {
    if (_isDialogShowing) {
      _isDialogShowing = false;
      Navigator.pop(context);
    }
  }

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: LoadingBouncingGrid.square(
                backgroundColor: Colors.blueAccent, inverted: true),
          ),
        ),
      ),
    );
  }
}
