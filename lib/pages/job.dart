import 'package:auto_route/auto_route.dart';
import 'package:bookservice/apis/client.dart';
import 'package:bookservice/bloc/job_bloc.dart';
import 'package:bookservice/router/router.gr.dart';
import 'package:bookservice/views/ifnone_widget.dart';
import 'package:card_settings/card_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore_for_file: close_sinks

class JobPage extends StatefulWidget {
  const JobPage({Key key}) : super(key: key);

  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        JobBloc bloc = BlocProvider.of<JobBloc>(context);

        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: bloc.refreshController,
          onRefresh: () => bloc.add(RefreshJobList()),
          onLoading: () => bloc.add(LoadJobList()),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (c, i) => JobItem(
              data: state.list[i],
            ),
            itemCount: state.list.length,
          ),
        );
      },
    );
  }
}

class JobItem extends StatelessWidget {
  final Job data;

  const JobItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          secondaryHeaderColor: Colors.blue, // card header background
          cardColor: Colors.white, // card field background
          buttonColor: Colors.blue, // button background color
          textTheme: Theme.of(context).textTheme.copyWith(
                button: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.white), // button text
                subtitle1: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.black87), // input text
                headline6: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white), // card header text
              ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.black87), // style for labels
          ),
          cardTheme: CardTheme(
              shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ))),
      child: CardSettings.sectioned(
        showMaterialonIOS: true,
        fieldPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.all(0),
        children: [
          CardSettingsSection(
            header: CardSettingsHeader(
              label: '${data.jobID}',
            ),
            children: [
              CardSettingsField(
                fieldPadding: null,
                labelAlign: null,
                requiredIndicator: null,
                label: 'Card',
                content: Text(data.card ?? '',style:TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'Amiko')),
              ),
              CardSettingsField(
                fieldPadding: null,
                labelAlign: null,
                requiredIndicator: null,
                label: 'Unit',
                content: Text('${data.unit}',style:TextStyle(
    color: Colors.white,
    fontSize: 11,
    fontFamily: 'Amiko')),
              ),
              CardSettingsField(
                fieldPadding: null,
                labelAlign: null,
                requiredIndicator: null,
                label: 'Action Date',
                content: Text(data.date ?? '',style:TextStyle(
    color: Colors.white,
    fontSize: 11,
    fontFamily: 'Amiko'))),

              CardSettingsField(
                fieldPadding: null,
                labelAlign: null,
                requiredIndicator: null,
                label: 'Remark',
                contentOnNewLine: true,
                content: IfNoneWidget(
                  basis: data?.remark != null,
                  builder: (context) => Text('${data.remark}', maxLines: 3),
                ),
              ),
              CardSettingsButton(
                label: 'View Order Detail',
                isDestructive: true,
                backgroundColor: Theme.of(context).cardColor,
                textColor: Theme.of(context).buttonColor,
                onPressed: () {
                  ExtendedNavigator.of(context).push('/order/${data.order_id}',
                      arguments:
                          OrderPageArguments(data: Order(id: data.order_id)));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
