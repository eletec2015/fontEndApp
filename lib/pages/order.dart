import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:bookservice/I18n/i18n.dart';
import 'package:bookservice/apis/client.dart';
import 'package:bookservice/bloc/addition_bloc.dart';
import 'package:bookservice/bloc/app_bloc.dart';
import 'package:bookservice/bloc/comment_bloc.dart';
import 'package:bookservice/bloc/order_bloc.dart';
import 'package:bookservice/constanc.dart';
import 'package:bookservice/router/router.gr.dart';
import 'package:bookservice/views/date_time/any_field_bloc_builder.dart';
import 'package:bookservice/views/dialog.dart';
import 'package:bookservice/views/ifnone_widget.dart';
import 'package:bookservice/views/modal.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flashy_tab_bar/flashy_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_form_bloc/src/utils/style.dart' as IStyle;
import 'package:photo_view/photo_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:bookservice/views/date_time/date_time_field_bloc_builder.dart'
    as _IL;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

// ignore_for_file: close_sinks
// ignore_for_file: implementation_imports
// ignore_for_file: non_constant_identifier_names

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  static const _pageSize = 20;

  final PagingController<int, Order> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      print(pageKey);
      final newItems = await RestService.instance.getOrders(query: {
        'pageNo': pageKey + 1,
        'pageSize': _pageSize,
        'sorter': '-id'
      });
      final isLastPage = newItems.data.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.data);
      } else {
        final nextPageKey = pageKey + newItems.data.length;
        _pagingController.appendPage(newItems.data, nextPageKey);
      }
    } catch (error) {
      print('Error while fetching orders $error');
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_pagingController.hasListeners == true) {
      _pagingController.refresh();
    }
    return BlocBuilder<OrderListBloc, OrderListState>(
      builder: (context, state) {
        OrderListBloc bloc = BlocProvider.of<OrderListBloc>(context);

        return PagedListView<int, Order>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Order>(
            itemBuilder: (context, item, i) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  _buildItem(item),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildItem(order) {
    final MaterialColor bgColor = Colors.blue;

    final List<String> images = [
      'assets/images/airConditioned.png',
      'assets/images/electricaling.png',
      'assets/images/plumbingg.png',
      'assets/images/general_maintenanceing.png',
      'assets/images/ducting.png',
      'assets/images/interior_fitoutsing.png',
    ];

    return GestureDetector(
      onTap: () {
        ExtendedNavigator.of(context).push('/order/${order.id}',
            arguments: OrderPageArguments(data: order));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ClipPath(
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(color: const Color(0xFF1d364f), width: 3)),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      color: const Color(0xFF9DA2C8),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Image(
                              image: AssetImage(images[order.service]),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(order.from_date)),
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'Amiko', fontWeight: FontWeight.w600)),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                              DateFormat('hh:mm a').format(
                                  DateTime.parse(order.from_date)),
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Amiko', fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Container(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Localization.of(context)
                                        .serviceType[order.service],
                                    style: TextStyle(
                                        color: const Color(0xFF1d364f),
                                        fontFamily: 'Amiko', fontWeight: FontWeight.w700),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Localization.of(context)
                                                .mainInfo[order.service]
                                            [order.main_info],
                                        style: TextStyle(
                                            color: const Color(0xFF1d364f),
                                            fontFamily: 'Amiko'),
                                      ),
                                      Text(
                                        Localization.of(context)
                                                .subInfo[order.service]
                                            [order.main_info][order.sub_info],
                                        style: TextStyle(
                                            color: const Color(0xFF1d364f),
                                            fontFamily: 'Amiko'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          DateFormat('dd-MM-yyyy').format(
                                              DateTime.parse(order.to_date)),
                                          style: TextStyle(
                                              color: const Color(0xFF1d364f),
                                              fontFamily: 'Amiko'),
                                        ),
                                        Text(
                                          Localization.of(context)
                                              .orderStatus[order.status],
                                          style: TextStyle(
                                              color: const Color(0xFF1d364f),
                                              fontFamily: 'Amiko'),
                                        ),
                                      ],
                                    ),
                                    RaisedButton(
                                      elevation: 5,
                                      onPressed: Localization.of(context)
                                                  .orderStatus[order.status] !=
                                              Localization.of(context)
                                                  .orderStatus[1]
                                          ? () async {
                                              // delete api call
                                              try {
                                                _showMyDialog(order.id);
                                              } catch (e) {
                                                print(
                                                    'error while deleting order $e');
                                              }
                                            }
                                          : null,
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Amiko'),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14))),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert..!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure to proceed?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  Dio dio = new Dio();
                  dio.options.headers.addAll({
                    "authorization": "${await CacheService.instance.getToken()}"
                  });
                  await dio.post(Constant.Host + 'orders/$id/ord_delete/',
                      data: {'deleted': true});
                  Navigator.of(context).pop();
                  _pagingController.refresh();
                },
                child: Text('Yes',
                    style: TextStyle(color: const Color(0xFF1d364f)))),
            TextButton(
              child: Text(
                'No',
                style: TextStyle(color: const Color(0xFF1d364f)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class OrderPostPage extends StatefulWidget {
  final Order data;

  const OrderPostPage({Key key, this.data}) : super(key: key);

  @override
  _OrderPostPageState createState() => _OrderPostPageState();
}

enum AlertMessageType {
  success, error
}

class _OrderPostPageState extends State<OrderPostPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  Future<void> _showDialog(String title, String message, AlertMessageType type ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                type == AlertMessageType.success ?
                  Icon(Icons.check_circle, color: Colors.green[500], size: 60,)
                  : Icon(Icons.close_rounded, color: Colors.redAccent, size: 60,),
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok', style: TextStyle(color: Color(0xFF1d364f), fontFamily: 'Amiko'),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool post = widget?.data?.id == null;

    Widget body() {
      return Builder(
        builder: (context) {
          OrderFormBloc formBloc = BlocProvider.of<OrderFormBloc>(context);
          // print('main info 2 ${formBloc.main_info.value.main}');
          DateTime dateTime = DateTime.now();
          Widget body = FormBlocListener<OrderFormBloc, String, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
                if (formBloc.nextStep) {
                  context.navigator.replace('/addition/post',
                      arguments:
                          AdditionPostPageArguments(postId: formBloc.data.id));
                } else {
                  context.navigator.pop();
                }
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);
              },
              child: ListView(
                primary: post,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: <Widget>[
                  Visibility(
                    visible: !post,
                    child: DropdownFieldBlocBuilder(
                      showEmptyItem: false,
                      decoration: InputDecoration(
                          labelText: Localization.of(context).status,
                          border: OutlineInputBorder()),
                      itemBuilder: (context, value) =>
                          Localization.of(context).orderStatus[value],
                      // selectFieldBloc: formBloc.status,
                    ),
                  ),
                  DropdownFieldBlocBuilder(
                    showEmptyItem: false,
                    isEnabled: Localization.of(context)
                            .orderStatus[widget.data.status] !=
                        Localization.of(context)
                            .orderStatus[1], // status not equal to confirmed,
                    decoration: InputDecoration(
                        labelText: Localization.of(context).service,
                        border: OutlineInputBorder()),
                    itemBuilder: (context, value) =>
                        Localization.of(context).serviceType[value],
                    selectFieldBloc: formBloc.service,
                  ),
                  DropdownFieldBlocBuilder(
                    showEmptyItem: false,
                    isEnabled: Localization.of(context)
                            .orderStatus[widget.data.status] !=
                        Localization.of(context)
                            .orderStatus[1], // status not equal to confirmed,
                    decoration: InputDecoration(
                        labelText: Localization.of(context).maininfo,
                        border: OutlineInputBorder()),
                    itemBuilder: (context, value) => Localization.of(context)
                        .mainInfo[value.service][value.main],
                    selectFieldBloc: formBloc.main_info,
                  ),
                  DropdownFieldBlocBuilder(
                    showEmptyItem: false,
                    isEnabled: Localization.of(context)
                            .orderStatus[widget.data.status] !=
                        Localization.of(context)
                            .orderStatus[1], // status not equal to confirmed,
                    decoration: InputDecoration(
                        labelText: Localization.of(context).subinfo,
                        border: OutlineInputBorder()),
                    itemBuilder: (context, value) => Localization.of(context)
                        .subInfo[value.service][value.main][value.sub],
                    selectFieldBloc: formBloc.sub_info,
                  ),
                  AnyFieldBlocBuilder<Address>(
                      inputFieldBloc: formBloc.address,
                      onPick: showAddressPickModal,
                      isEnabled: Localization.of(context)
                              .orderStatus[widget.data.status] !=
                          Localization.of(context)
                              .orderStatus[1], // status not equal to confirmed,
                      showClearIcon: post,
                      decoration: InputDecoration(
                          labelText: Localization.of(context).address,
                          border: OutlineInputBorder()),
                      builder: (context, state) {
                        print(jsonEncode(state.value));
                        String address;
                        if(state?.value?.address != null) {
                          address = state?.value?.address;
                        } else if(state?.value?.roomNo != null || state?.value?.building != null) {
                          address = '${state?.value?.roomNo} ${state?.value?.building} ${state?.value?.street} ${state?.value?.community}';
                        }
                        return Text(
                          address ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: IStyle.Style.getDefaultTextStyle(
                            context: context,
                            isEnabled: true,
                          ),
                        );
                      }),
                  _IL.DateTimeFieldBlocBuilder(
                    dateTimeFieldBloc: formBloc.from_date,
                    canSelectTime: true,
                    isEnabled: Localization.of(context)
                            .orderStatus[widget.data.status] !=
                        Localization.of(context)
                            .orderStatus[1], // status not equal to confirmed,
                    showClearIcon: false,
                    format: DateFormat('dd-MM-yyyy HH:mm'),
                    initialDate: DateTime(
                        dateTime.year, dateTime.month, dateTime.day + 1, 12),
                    firstDate: DateTime(
                        dateTime.year, dateTime.month, dateTime.day, 12),
                    lastDate: DateTime(
                        dateTime.year, dateTime.month, dateTime.day + 30),
                    decoration: InputDecoration(
                        labelText: Localization.of(context).fromdate,
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder()),
                  ),
                  _IL.DateTimeFieldBlocBuilder(
                    dateTimeFieldBloc: formBloc.to_date,
                    canSelectTime: true,
                    isEnabled: Localization.of(context)
                            .orderStatus[widget.data.status] !=
                        Localization.of(context)
                            .orderStatus[1], // status not equal to confirmed,
                    showClearIcon: false,
                    format: DateFormat('dd-MM-yyyy HH:mm'),
                    initialDate: DateTime(
                        dateTime.year, dateTime.month, dateTime.day + 1, 14),
                    firstDate: DateTime(
                        dateTime.year, dateTime.month, dateTime.day, 14),
                    lastDate: DateTime(
                        dateTime.year, dateTime.month, dateTime.day + 30),
                    decoration: InputDecoration(
                        labelText: Localization.of(context).Todate,
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: post,
                    child: RaisedButton(
                      child: Text(Localization.of(context).submit),
                      onPressed: () {
                        LoadingDialog.show(context);
                        // formBloc.submit();
                        RestService.instance.postOrder({
                          'service': formBloc.service.value,
                          'main_info': formBloc.main_info.value.main,
                          'sub_info': formBloc.sub_info.value.sub,
                          'address': formBloc.address.value.address ?? formBloc.address.value.toTitle,
                          'lat': formBloc.lat.valueToDouble,
                          'lng': formBloc.lat.valueToDouble,
                          'from_date': DateFormat('yyyy-MM-dd HH:mm:ss').format(formBloc.from_date.value),
                          'to_date': DateFormat('yyyy-MM-dd HH:mm:ss').format(formBloc.to_date.value)
                        }).then((value) async {
                          LoadingDialog.hide(context);
                          await _showDialog('Success', 'Successfully Added', AlertMessageType.success);
                          Navigator.pop(context);
                        }).catchError((onError) {
                          LoadingDialog.hide(context);
                          _showDialog('Success', 'Successfully Added', AlertMessageType.success);
                        });
                      },
                    ),
                  ),
                  Visibility(
                    visible: !post &&
                        Localization.of(context)
                                .orderStatus[widget.data.status] !=
                            Localization.of(context).orderStatus[
                                1], // status not equal to confirmed
                    child: RaisedButton(
                      child: Text('Update'),
                      onPressed: () async {
                        // TODO: call update api
                        LoadingDialog.show(context);
                        final putData = {
                          'service': formBloc.service.value,
                          'main_info': formBloc.main_info.value.main,
                          'sub_info': formBloc.sub_info.value.sub,
                          'address': formBloc.address.value.address ??
                              formBloc.address.value.toTitle,
                          'user_id':
                              BlocProvider.of<AppBloc>(context).state.user.id,
                          'from_date': DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(formBloc.from_date.value),
                          'to_date': DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(formBloc.to_date.value)
                        };
                        print(putData);
                        try {
                          await Dio().post(
                            Constant.Host +
                                'orders/${widget.data.id}/ord_update/',
                            data: putData,
                            options: Options(
                              headers: {
                                "authorization":
                                    '${await CacheService.instance.getToken()}', // set content-length
                              },
                            ),
                          );
                          LoadingDialog.hide(context);
                          await _showDialog('Success', 'Updated successfully', AlertMessageType.success);
                          Navigator.pop(context);
                        } catch (e) {
                          LoadingDialog.hide(context);
                          _showDialog('Error', 'Failed To Update', AlertMessageType.error);
                          print('error while updating order ${e.message}');
                        }
                      },
                    ),
                  ),
                ],
              ));

          return post
              ? Scaffold(
                  backgroundColor: Colors.white,
                  key: _scaffoldKey,
                  appBar: AppBar(
                    title: Text('Order New',
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Amiko", fontSize: 17)),
                  ),
                  body: body)
              : body;
        },
      );
    }

    if (post) {
      return BlocProvider<OrderFormBloc>(
          create: (_) => OrderFormBloc(context, widget.data, true),
          child: body());
    } else {
      return BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(),
          child: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
            OrderBloc bloc = BlocProvider.of<OrderBloc>(context);

            return SmartRefresher(
              enablePullDown: true,
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
              onRefresh: () => bloc.add(RefreshOrder(widget.data.id)),
              child: BlocProvider<OrderFormBloc>(
                  create: (_) => OrderFormBloc(context, state.order, true),
                  child: state.order != null ? body() : Container()),
            );
          }));
    }
  }
}

class OrderAdditionPage extends StatefulWidget {
  final Order data;

  const OrderAdditionPage({Key key, this.data}) : super(key: key);

  @override
  _OrderAdditionPageState createState() => _OrderAdditionPageState();
}

class _OrderAdditionPageState extends State<OrderAdditionPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdditionBloc, AdditionState>(
      builder: (context, state) {
        AdditionBloc bloc = BlocProvider.of<AdditionBloc>(context);

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
          onRefresh: () => bloc.add(AdditionRefreshList(widget.data.id)),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            separatorBuilder: (context, index) {
              return SizedBox(height: 20);
            },
            itemBuilder: (c, i) => GestureDetector(
                onTap: () {
                  context.navigator.push('/image/order',
                      arguments: ViewOrderImageArguments(
                          url: state.list[i].image['full_size']));
                },
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                              image: NetworkImage(
                                  state.list[i].image['full_size']))),
                      child: Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Text(
                            state.list[i].tag ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          )),
                    ),
                  ],
                )),
            itemCount: state.list.length,
          ),
        );
      },
    );
  }
}

class OrderCommentPage extends StatefulWidget {
  final Order data;

  const OrderCommentPage({Key key, this.data}) : super(key: key);

  @override
  _OrderCommentPageState createState() => _OrderCommentPageState();
}

class _OrderCommentPageState extends State<OrderCommentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        CommentBloc bloc = BlocProvider.of<CommentBloc>(context);

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
          onRefresh: () => bloc.add(CommentRefreshList(widget.data.id)),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (c, i) => Container(
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          image: DecorationImage(
                              image: state.list[i].user?.photo['thumbnail'] !=
                                      null
                                  ? NetworkImage(
                                      state.list[i].user?.photo['thumbnail'])
                                  : ExactAssetImage('assets/images/user.png')),
                        )),
                    title: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(fontSize: 18),
                              text: state.list[i].comment),
                          TextSpan(text: '\n'),
                          TextSpan(
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(color: Colors.grey[600]),
                              text:
                                  '${state.list[i].user.name}  ${state.list[i].create_at}'),
                        ],
                      ),
                    ),
                    subtitle: RatingBar(
                      initialRating: state.list[i].rating.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 24,
                      unratedColor: Colors.grey,
                      itemPadding:
                          EdgeInsets.symmetric(horizontal: 1.0, vertical: 12),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.reply),
                      onPressed: () {
                        showCommentModal(context, state.list[i].id, 'comment',
                                reply: state.list[i])
                            .then((value) {
                          if (value != null && value) {
                            bloc.add(CommentRefreshList(widget.data.id));
                            bloc.refreshController.requestRefresh();
                          }
                        });
                      },
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: ListBody(
                        children: state.list[i].child.map((e) {
                          return ListTile(
                              isThreeLine: true,
                              dense: true,
                              leading: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    image: DecorationImage(
                                        image: state.list[i].user
                                                    ?.photo['thumbnail'] !=
                                                null
                                            ? NetworkImage(state.list[i].user
                                                ?.photo['thumbnail'])
                                            : ExactAssetImage(
                                                'assets/images/user.png')),
                                  )),
                              title: Text('${e.comment}'),
                              subtitle: Text('${e.user.name}  ${e.create_at}'));
                        }).toList(),
                      ))
                ],
              ),
            ),
            itemCount: state.list.length,
          ),
        );
      },
    );
  }
}

class OrderCommentPostPage extends StatefulWidget {
  final int objectid;
  final String contenttype;
  final Comment reply;

  const OrderCommentPostPage(
      {Key key, this.objectid, this.contenttype, this.reply})
      : super(key: key);

  @override
  _OrderCommentPostPageState createState() => _OrderCommentPostPageState();
}

class _OrderCommentPostPageState extends State<OrderCommentPostPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentFormBloc>(
        create: (_) =>
            CommentFormBloc(context, widget.objectid, widget.contenttype),
        child: Builder(
          builder: (context) {
            CommentFormBloc formBloc =
                BlocProvider.of<CommentFormBloc>(context);
            return FormBlocListener<CommentFormBloc, String, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
                context.navigator.pop(true);
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);
              },
              child: Scaffold(
                body: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    IfNoneWidget(
                      basis: widget.reply != null,
                      builder: (context) {
                        return ListBody(
                          children: [
                            SizedBox(height: 10),
                            ListTile(
                              leading: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    image: DecorationImage(
                                        image: widget.reply.user
                                                    ?.photo['thumbnail'] !=
                                                null
                                            ? NetworkImage(widget
                                                .reply.user?.photo['thumbnail'])
                                            : ExactAssetImage(
                                                'assets/images/user.png')),
                                  )),
                              title: Text(widget.reply.comment),
                              subtitle: Text(
                                '${widget.reply.user.name}  ${widget.reply.create_at}',
                              ),
                            ),
                          ],
                        );
                      },
                      none: ListBody(
                        children: [
                          SizedBox(height: 10),
                          AnyFieldBlocBuilder<double>(
                            inputFieldBloc: formBloc.rating,
                            showClearIcon: false,
                            decoration: InputDecoration(
                                labelText: 'Rating',
                                border: OutlineInputBorder()),
                            builder: (context, state) {
                              return Container(
                                  alignment: Alignment.center,
                                  child: RatingBar(
                                    initialRating: state.value,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    unratedColor: Colors.grey,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                      formBloc.rating.updateValue(rating);
                                    },
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFieldBlocBuilder(
                      textFieldBloc: formBloc.comment,
                      maxLines: 3,
                      maxLength: 256,
                      decoration: InputDecoration(
                          labelText: 'Comment', border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      child: Text(Localization.of(context).submit),
                      onPressed: () {
                        formBloc.submit();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class OrderPage extends StatefulWidget {
  final Order data;

  const OrderPage({Key key, this.data}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class OrderNav {
  final Color color;
  final IconData icon;
  final String text;

  OrderNav(this.color, this.icon, this.text);
}

class _OrderPageState extends State<OrderPage> {
  int selectedIndex = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        List<Widget> actions(
            AdditionBloc additionBloc, CommentBloc commentBloc) {
          switch (selectedIndex) {
            case 0:
            case 3:
              break;
            case 1:
              return [
                Container(
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    elevation: 0,
                      child: Text(
                          'Add',
                        style: TextStyle(
                          fontFamily: 'Amiko',
                          fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        // TODO: handle image upload here
                        showImagePostModal(context, widget.data.id).then((value) {
                          if (value != null && value) {
                            additionBloc.add(AdditionRefreshList(widget.data.id));
                            additionBloc.refreshController.requestRefresh();
                          }
                        });
                      }),
                )
              ];
            case 2:
              return [
                Container(
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    elevation: 0,
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Amiko',
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        showCommentModal(context, widget.data.id, 'order')
                            .then((value) {
                          if (value != null && value) {
                            commentBloc.add(CommentRefreshList(widget.data.id));
                            commentBloc.refreshController.requestRefresh();
                          }
                        });
                      }),
                )
              ];
          }
          return [];
        }

        List<String> title = [
          Localization.of(context).title[0],
          Localization.of(context).title[1],
          Localization.of(context).title[2]
        ];

        List<Widget> pages() {
          return [
            OrderPostPage(data: widget.data),
            OrderAdditionPage(
              data: widget.data,
            ),
            OrderCommentPage(
              data: widget.data,
            ),
          ];
        }

        // List<OrderNav> tabs() {
        //   return [
        //     OrderNav(Colors.blue, LineIcons.calendar, 'Base'),
        //     OrderNav(Colors.purple, Icons.image, 'Additional'),
        //     OrderNav(Colors.pink, LineIcons.comment, 'Comment'),
        //   ];
        // }

        List<FlashyTabBarItem> tabs() {
          return [
            FlashyTabBarItem(
              icon: Icon(Icons.event),
              title: Text(Localization.of(context).title[0]),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.image),
              title: Text(Localization.of(context).title[1]),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.comment),
              title: Text(Localization.of(context).title[2]),
            ),
          ];
        }

        return MultiBlocProvider(
            providers: [
              BlocProvider<OrderFormBloc>(
                  create: (_) => OrderFormBloc(context, widget.data, false)),
              BlocProvider<AdditionBloc>(create: (context) => AdditionBloc()),
              BlocProvider<CommentBloc>(create: (context) => CommentBloc()),
            ],
            child: BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                return Builder(
                  builder: (context) {
                    AdditionBloc additionBloc =
                        BlocProvider.of<AdditionBloc>(context);
                    CommentBloc commentBloc =
                        BlocProvider.of<CommentBloc>(context);
                    return Scaffold(
                        appBar: AppBar(
                          backgroundColor: Color(0xFF213c56),
                          title: Text(
                            title[selectedIndex],
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Amiko', fontSize: 17),
                          ),
                          actions: state.user.role == 0
                              ? Localization.of(context)
                                          .orderStatus[widget.data.status] !=
                                      Localization.of(context).orderStatus[
                                          1] // status not equal to confirmed
                                  ? actions(additionBloc, commentBloc)
                                  : null
                              : null,
                        ),
                        body: PageView(
                          onPageChanged: (page) {
                            setState(() {
                              selectedIndex = page;
                            });
                          },
                          controller: controller,
                          children: pages(),
                        ),
                        bottomNavigationBar: FlashyTabBar(
                          backgroundColor: Colors.white,
                          animationCurve: Curves.linear,
                          selectedIndex: selectedIndex,
                          showElevation: true,
                          onItemSelected: (index) => setState(() {
                            selectedIndex = index;
                            controller.jumpToPage(index);
                          }),
                          items: tabs(),
                        )
                        // SafeArea(
                        //   child: Container(
                        //     margin: EdgeInsets.symmetric(horizontal: 10),
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(100)),
                        //         boxShadow: [
                        //           BoxShadow(
                        //               spreadRadius: -10,
                        //               blurRadius: 60,
                        //               color: Colors.black.withOpacity(.20),
                        //               offset: Offset(0, 15))
                        //         ]),
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //           horizontal: 5.0, vertical: 5),
                        //       child: GNav(
                        //           tabs: tabs().map((e) {
                        //             return GButton(
                        //               gap: 10,
                        //               iconActiveColor: e.color,
                        //               iconColor: Colors.grey,
                        //               textColor: e.color,
                        //               backgroundColor: e.color.withOpacity(.2),
                        //               iconSize: 24,
                        //               padding: EdgeInsets.symmetric(
                        //                   horizontal: 18, vertical: 5),
                        //               icon: e.icon,
                        //               text: e.text,
                        //             );
                        //           }).toList(),
                        //           selectedIndex: selectedIndex,
                        //           onTabChange: (index) {
                        //             setState(() {
                        //               selectedIndex = index;
                        //             });
                        //             controller.jumpToPage(index);
                        //           }),
                        //     ),
                        //   ),
                        // ),
                        );
                  },
                );
              },
            ));
      },
    );
  }
}

class AdditionPostPage extends StatefulWidget {
  final int postId;

  const AdditionPostPage({Key key, this.postId}) : super(key: key);

  @override
  _AdditionPostPageState createState() => _AdditionPostPageState();
}

class _AdditionPostPageState extends State<AdditionPostPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdditionFormBloc>(
        create: (_) => AdditionFormBloc(context, widget.postId),
        child: Builder(
          builder: (context) {
            AdditionFormBloc formBloc =
                BlocProvider.of<AdditionFormBloc>(context);
            return FormBlocListener<AdditionFormBloc, String, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
                context.navigator.pop(true);
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);
              },
              child: Scaffold(
                body: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    SizedBox(height: 20),
                    AnyFieldBlocBuilder<File>(
                      inputFieldBloc: formBloc.image,
                      showClearIcon: true,
                      onPick: showImagePickModal,
                      builder: (context, state) {
                        return Container(
                            width: 64,
                            height: 96,
                            child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 1,
                                strokeCap: StrokeCap.butt,
                                dashPattern: const <double>[8, 2],
                                child: Container(
                                    alignment: Alignment.center,
                                    child: state.value == null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                                Icon(
                                                  Icons.file_upload,
                                                  color: Colors.grey,
                                                  size: 64,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      'Images for select a picture or take',
                                                      style: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: 11,
                                                          fontFamily: 'Amiko')),
                                                ),
                                              ])
                                        : Stack(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                child: Image.file(
                                                  state.value,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ))));
                      },
                    ),
                    SizedBox(height: 10),
                    TextFieldBlocBuilder(
                      textFieldBloc: formBloc.tag,
                      maxLines: 3,
                      maxLength: 128,
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 11,
                          fontFamily: 'Amiko'),
                      decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(
                              color: primaryColor,
                              fontSize: 11,
                              fontFamily: 'Amiko')),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      child: Text('Add',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontFamily: 'Amiko')),
                      onPressed: () {
                        formBloc.submit();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class ViewOrderImage extends StatelessWidget {
  final String url;

  const ViewOrderImage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.normal),
            appBarTheme: AppBarTheme(
                elevation: 0,
                color: Colors.white,
                iconTheme: IconThemeData(color: Colors.white),
                brightness: Brightness.dark)),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF213c56),
            ),
            body: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
              return Stack(
                children: <Widget>[
                  Center(
                      child: PhotoView(
                          heroAttributes: PhotoViewHeroAttributes(tag: url),
                          loadingBuilder: (context, progress) => Center(
                                child: Container(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    value: progress == null
                                        ? null
                                        : progress.expectedTotalBytes == null ||
                                                progress.cumulativeBytesLoaded ==
                                                    null
                                            ? null
                                            : progress.cumulativeBytesLoaded /
                                                progress.expectedTotalBytes,
                                  ),
                                ),
                              ),
                          imageProvider: NetworkImage(url))),
                ],
              );
            })));
  }
}
