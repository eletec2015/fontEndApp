import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:bookservice/I18n/i18n.dart';
import 'package:bookservice/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore_for_file: close_sinks
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (BuildContext context, state) {
        return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: <Widget>[
              GestureDetector(
                  onTap: () =>
                      context.navigator.push('/users/${state.user.id}'),
                  child: Container(
                      height: 160,
                      child: Stack(children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.blueAccent, Colors.blue],
                                tileMode: TileMode.repeated),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 1)),
                            ],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Container(
                            height: 160,
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 20),
                                Container(
                                    width: 120,
                                    height: 120,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.yellow,
                                        width: 2,
                                      ),
                                      image: DecorationImage(
                                          image: state.user
                                                      ?.photo['thumbnail'] !=
                                                  null
                                              ? NetworkImage(state
                                                  .user?.photo['thumbnail'])
                                              : ExactAssetImage(
                                                  'assets/images/user.png')),
                                    )),
                                SizedBox(width: 20),
                                Flexible(
                                    child: Container(
                                        height: 160,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Visibility(
                                              visible: !(state.user.first_name
                                                      .isEmpty ||
                                                  state.user.last_name.isEmpty),
                                              child: Flexible(
                                                child: Text(
                                                  '${state.user.first_name} ${state.user.last_name} ',
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                                visible: !(state.user.first_name
                                                        .isEmpty ||
                                                    state.user.last_name
                                                        .isEmpty),
                                                child: SizedBox(
                                                  height: 20,
                                                )),
                                            Container(
                                              child: Text(
                                                  '${state.user.username}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                            )
                                          ],
                                        )))
                              ],
                            ))
                      ]))),
              SizedBox(height: 15),
              Card(
                  elevation: 3,
                  child: ListBody(
                    children: <Widget>[
                      SizedBox(height: 10),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.addressCard),
                        title: Text(Localization.of(context).address),
                        onTap: () {
                          context.navigator.push('/address');
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.fileContract),
                        title: Text(Localization.of(context).contract),
                        onTap: () {
                          context.navigator.push('/contract');
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.info),
                        title: Text(Localization.of(context).faqs),
                        onTap: () {
                          context.navigator.push('/faqs');
                        },
                      ),
                      Divider(),
                      SwitchListTile(
                        title: Text(Localization.of(context).language),
                        subtitle: state.locale.languageCode == 'en'
                            ? Text(Localization.of(context).english)
                            : Text(Localization.of(context).arabic),
                        secondary: FaIcon(FontAwesomeIcons.globeAsia),
                        onChanged: (bool value) {
                          print(value);
                          BlocProvider.of<AppBloc>(context).add(SwitchLanguage(
                              value ? Locale('ar', 'IQ') : Locale('en', '')));
                        },
                        value: state.locale.languageCode != 'en',
                      ),
                    ],
                  )),
              SizedBox(height: 10),
              RaisedButton(
                  child: Text(Localization.of(context).logout),
                  onPressed: () {
                    ExtendedNavigator.of(context);
                    BlocProvider.of<AppBloc>(context).add(SignOut());
                  })
            ]);
      },
    );
  }
}
