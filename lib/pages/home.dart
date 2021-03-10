import 'dart:convert';
import 'dart:io';

import 'package:bookservice/apis/client.dart';
import 'package:bookservice/bloc/app_bloc.dart';
import 'package:bookservice/pages/customer.dart';
import 'package:bookservice/pages/profile.dart';
import 'package:bookservice/pages/staff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;

import '../constanc.dart';

const int tabCount = 3;

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabCount, vsync: this)
      ..addListener(() {
        setState(() {});
      });

    fetchAlbum().then((profile) {
      ProfileDetails  pd =profile;

      if(pd.first_name.isEmpty ) {
        _showDialog();
      }

    });

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: false,
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state.user.role == 0) {
              return CustomerPage();
            } else {
              return StaffPage();
            }
          },
        ));
  }


  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showAlertDialog(context);
  }

  showAlertDialog(BuildContext context) {

    Widget continueButton = FlatButton(
      child: Text("Okay"),
      onPressed:  () {

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Profile(dialogNav : true)));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Profile Updation"),
      content: Text("Please fill your profile details before proceeding further."),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Future<ProfileDetails> fetchAlbum() async {

    var token = await CacheService.instance.getToken();
    final response = await http.get(
      Constant.Host+'/profileDetails/info',
      headers: {HttpHeaders.authorizationHeader: token},
    );
    final responseJson = jsonDecode(response.body);

    print(responseJson);

    return ProfileDetails.fromJson(responseJson['result']);
  }


}
