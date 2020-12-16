import 'package:auto_route/auto_route.dart';
import 'package:bookservice/views/ifnone_widget.dart';
import 'package:card_settings/card_settings.dart';
import 'package:bookservice/I18n/i18n.dart';
import 'package:bookservice/apis/client.dart';
import 'package:bookservice/bloc/contract_bloc.dart';
import 'package:bookservice/router/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore_for_file: close_sinks
class ContractPage extends StatefulWidget {
  @override
  _ContractPageState createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContractBloc>(
        create: (context) => ContractBloc(context),
        child: ExtendedNavigator(
          name: 'contract',
          initialRoute: ContractPageRoutes.contractListPage,
        ));
  }
}

class ContractListPage extends StatefulWidget {
  @override
  _ContractListPageState createState() => _ContractListPageState();
}

class _ContractListPageState extends State<ContractListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Localization.of(context).contract,style: TextStyle(color: Colors.white,fontFamily: 'Amiko'),),
          leading: BackButton(onPressed: () {
            context.navigator.root.pop();
          }),
        ),
        body: BlocBuilder<ContractBloc, ContractState>(
          builder: (context, state) {
            ContractBloc bloc = BlocProvider.of<ContractBloc>(context);
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
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
              onRefresh: () => bloc.add(ContractRefreshList()),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (c, i) => ContractItem(
                  data: state.list[i],
                ),
                itemCount: state.list.length,
              ),
            );
          },
        ));
  }
}

class ContractItem extends StatelessWidget {
  final Contract data;

  const ContractItem({Key key, this.data}) : super(key: key);

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
              label: '${data.contractID}',
            ),
            children: [
              CardSettingsField(
                fieldPadding: null,
                labelAlign: null,
                requiredIndicator: null,
                label: 'Option',
                content: Text(
                    '${Localization.of(context).contractOption[data.option]}'),
              ),
              CardSettingsField(
                fieldPadding: null,
                labelAlign: null,
                requiredIndicator: null,
                label: 'Issue Date',
                content: Text('${data.issue_date}'),
              ),
              CardSettingsField(
                fieldPadding: null,
                labelAlign: null,
                requiredIndicator: null,
                label: 'Expiry Date',
                content: Text('${data.expiry_date}'),
              ),
              CardSettingsField(
                fieldPadding: null,
                labelAlign: null,
                requiredIndicator: null,
                label: 'Expiry Date',
                content: Text('${data.expiry_date}'),
              ),
              CardSettingsField(
                fieldPadding: null,
                labelAlign: null,
                requiredIndicator: null,
                label: 'Address',
                contentOnNewLine: true,
                content: IfNoneWidget(
                  basis: data?.address != null,
                  builder: (context) => Text('${data.address}', maxLines: 3),
                ),
              ),
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
              CardSettingsField(
                fieldPadding: null,
                labelAlign: null,
                requiredIndicator: null,
                contentOnNewLine: true,
                label: 'Visit',
                content: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: data.visits != null
                          ? data.visits
                              .map((e) => ListTile(
                                    title: Text(
                                        '${Localization.of(context).serviceType[e.service]} : ${e.count}'),
                                  ))
                              .toList()
                          : Container(),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ContractPost extends StatefulWidget {
  @override
  _ContractPostState createState() => _ContractPostState();
}

class _ContractPostState extends State<ContractPost> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
