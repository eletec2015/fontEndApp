import 'package:bookservice/I18n/i18n.dart';
import 'package:bookservice/bloc/job_bloc.dart';
import 'package:bookservice/views/rally_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'job.dart';
import 'setting.dart';

class StaffPage extends StatefulWidget {
  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
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
    return BlocProvider<JobBloc>(
        create: (context) => JobBloc(),
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            children: [
              RallyTabBar(
                tabs: buildTabs(
                    context,
                    Theme.of(context).textTheme.button.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
                tabController: _tabController,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: buildTabViews(),
                ),
              ),
            ],
          ),
        ));
  }

  List<Widget> buildTabViews() {
    return [JobPage(), SettingPage()];
  }

  List<Widget> buildTabs(context, textStyle) {
    return [
      RallyTab(
        textStyle: textStyle,
        iconData: Icons.date_range,
        title: Localization.of(context).jobs,
        tabIndex: 0,
        tabController: _tabController,
        isVertical: false,
        color: Colors.blue,
        tabCount: 3,
      ),
      RallyTab(
        textStyle: textStyle,
        iconData: Icons.settings,
        title: Localization.of(context).settings,
        tabIndex: 1,
        tabController: _tabController,
        isVertical: false,
        color: Colors.blue,
        tabCount: 3,
      ),
    ];
  }
}
