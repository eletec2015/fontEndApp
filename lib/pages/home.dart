import 'package:bookservice/bloc/app_bloc.dart';
import 'package:bookservice/pages/customer.dart';
import 'package:bookservice/pages/staff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

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
}
