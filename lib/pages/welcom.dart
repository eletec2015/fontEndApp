import 'package:bookservice/bloc/app_bloc.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:bookservice/apis/client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomPage extends StatefulWidget {
  @override
  _WelcomPageState createState() => _WelcomPageState();
}

class _WelcomPageState extends State<WelcomPage> {
  Stream<String> url;

  @override
  void initState() {
    super.initState();

    url = RestServiceExtra.instance.getAdvertising();
  }

  @override
  Widget build(BuildContext context) {
    final Widget loadingView = AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(microseconds: 500),
        curve: Curves.easeIn,
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Image.asset('assets/images/title.png', fit: BoxFit.cover),
        ));

    Widget widget(state) => Scaffold(
            body: Stack(children: <Widget>[
          Center(
              child: StreamBuilder<String>(
                  stream: url,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData)
                      return ExtendedImage.network(snapshot.data,
                          fit: BoxFit.cover,
                          loadStateChanged: (ExtendedImageState state) {
                        switch (state.extendedImageLoadState) {
                          case LoadState.loading:
                            return loadingView;
                          case LoadState.completed:
                            return AnimatedOpacity(
                              opacity: 1.0,
                              duration: Duration(microseconds: 0),
                              curve: Curves.easeIn,
                              child: ExtendedRawImage(
                                image: state.extendedImageInfo?.image,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            );
                          default:
                            return null;
                            break;
                        }
                      });
                    return loadingView;
                  })),
          SafeArea(
              child: Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints.tight(Size(30, 30)),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.5)),
                      child: Text('${state.leftTime}',
                          style: TextStyle(color: Colors.white)))))
        ]));

    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return widget(state);
    });
  }
}
