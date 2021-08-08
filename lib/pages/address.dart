import 'package:auto_route/auto_route.dart';
import 'package:bookservice/I18n/i18n.dart';
import 'package:bookservice/apis/client.dart';
import 'package:bookservice/bloc/address_bloc.dart';
import 'package:bookservice/constanc.dart';
import 'package:bookservice/router/router.gr.dart';
import 'package:bookservice/views/dialog.dart';
import 'package:bookservice/views/ifnone_widget.dart';
import 'package:card_settings/card_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

enum AlertMessage {
  success, error
}

// ignore_for_file: close_sinks
class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return ExtendedNavigator(
      name: 'address',
      initialRoute: AddressPageRoutes.list,
    );
  }
}

class AddressListPage extends StatefulWidget {
  final bool pick;

  const AddressListPage({Key key, this.pick = false}) : super(key: key);

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  Widget build(BuildContext context) {
    bool pick = widget.pick;

    Widget body = Builder(
        builder: (context) => Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF213c56),
                title: pick
                    ? Text(
                        Localization.of(context).chooseAddress,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Amiko',
                            fontSize: 17),
                      )
                    : Text(Localization.of(context).address,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Amiko',
                            fontSize: 17)),
                leading: pick
                    ? Container()
                    : BackButton(onPressed: () {
                        context.navigator.root.pop();
                      }),
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: RaisedButton(
                      elevation: 0,
                      child: Text(
                        'Add',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiko',
                            color: Color(0xFFFFFFFF)),
                      ),
                      onPressed: () {
                        if (pick) {
                          context.navigator.popAndPush('/address');
                        } else {
                          context.navigator
                              .push('/post',
                                  arguments: AddressPostPageArguments(
                                      data: Address(
                                    defAddr: false,
                                    onMap: false,
                                    model: 0,
                                    style: 0,
                                    city: '',
                                    community: '',
                                    street: '',
                                    building: '',
                                    roomNo: '',
                                    address: '',
                                  )))
                              .then((value) {
                            if (value != null && value) {
                              AddressBloc bloc =
                                  BlocProvider.of<AddressBloc>(context);
                              bloc.refreshController.requestRefresh();
                            }
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
              body: BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  AddressBloc bloc = BlocProvider.of<AddressBloc>(context);

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
                    onRefresh: () => bloc.add(AddressRefreshList()),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (c, i) => _buildItem(
                        state.list[i],
                        pick,
                      ),
                      itemCount: state.list.length,
                    ),
                  );
                },
              ),
            ));

    return BlocProvider(create: (_) => AddressBloc(), child: body);
  }

  Future<void> _showDialog(String title, String message, AlertMessage type ) async {
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
                type == AlertMessage.success ?
                Icon(Icons.check_circle, color: Colors.green[500], size: 60,)
                    : Icon(Icons.close_rounded, color: Colors.redAccent, size: 60,),
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('Ok', style: TextStyle(color: Colors.white, fontFamily: 'Amiko'),),
              onPressed: () {
                context.navigator.pop();
                context.navigator.pop();
                context.navigator.popAndPush('/address/');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showConfirmDialog(Function callback) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?', style: TextStyle(color: Color(0xFF1d364f), fontFamily: 'Amiko'), ),
          actions: <Widget>[
            RaisedButton(
              child: Text('Yes', style: TextStyle(color: Colors.white, fontFamily: 'Amiko'),),
              onPressed: callback,
            ),
            RaisedButton(
              child: Text('No', style: TextStyle(color: Colors.white, fontFamily: 'Amiko'),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _buildItem(Address data, bool pick) {
    final MaterialColor bgColor = Colors.blue;

    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ClipPath(
          child: Container(
            height: 140,
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
                            child: data.style == 0
                                ? Icon(
                                    Icons.location_on,
                                    color: const Color(0xFF1d364f),
                                    size: 60,
                                  )
                                : Icon(
                                    Icons.location_on_outlined,
                                    color: const Color(0xFF1d364f),
                                    size: 60,
                                  )),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.toTitle,
                                  style: TextStyle(
                                      color: const Color(0xFF1d364f),
                                      fontFamily: 'Amiko',
                                      fontWeight: FontWeight.w700),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      fit: FlexFit.loose,
                                      child: pick
                                          ? RaisedButton(
                                        onPressed: () {
                                          context.navigator.pop(data);
                                        },
                                        child: Text('Select'),
                                      )
                                          : RaisedButton(
                                        onPressed: () {
                                          context.navigator
                                              .push('/put',
                                              arguments:
                                              AddressPostPageArguments(
                                                  data: data))
                                              .then((value) {
                                            if (value != null && value) {
                                              AddressBloc bloc =
                                              BlocProvider.of<
                                                  AddressBloc>(context);
                                              bloc.refreshController
                                                  .requestRefresh();
                                            }
                                          });
                                        },
                                        child: Text('View Details'),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.loose,
                                      child: IconButton(
                                        color: Colors.redAccent,
                                        onPressed: () {
                                          _showConfirmDialog(() {
                                            RestService.instance.deleteAddress('${data.id}').then((value) {
                                              _showDialog('Success', 'Deleted successfully', AlertMessage.success);
                                              setState(() {

                                              });
                                            }).catchError((onError) {
                                              print(onError);
                                              _showDialog('Error', 'Failed to Delete', AlertMessage.error);
                                            });
                                          });
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
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
    );
  }
}

class AddressPostPage extends StatefulWidget {
  final Address data;

  const AddressPostPage({Key key, this.data}) : super(key: key);

  @override
  _AddressPostPageState createState() => _AddressPostPageState();
}

class _AddressPostPageState extends State<AddressPostPage> {
  @override
  Widget build(BuildContext context) {
    String path = RouteData.of(context).path;

    Widget body = MultiBlocProvider(
        providers: [
          BlocProvider<AddressPostBloc>(
            create: (_) => AddressPostBloc(
                widget.data.onMap ? AddressMapState() : AddressFormState()),
          ),
          BlocProvider<AddressFormBloc>(
            create: (_) => AddressFormBloc(context, widget.data),
          ),
          BlocProvider<AddressMapBloc>(
            create: (_) => AddressMapBloc(context, widget.data),
          ),
        ],
        child: BlocBuilder<AddressPostBloc, AddressPostState>(
            builder: (context, state) {
          AddressPostBloc postBloc = BlocProvider.of<AddressPostBloc>(context);
          AddressMapBloc mapBloc = BlocProvider.of<AddressMapBloc>(context);
          AddressFormBloc formBloc = BlocProvider.of<AddressFormBloc>(context);

          final Widget mapbody =
              FormBlocListener<AddressMapBloc, String, String>(
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
                  onDeleting: (context, state) {
                    LoadingDialog.show(context);
                  },
                  onDeleteSuccessful: (context, state) {
                    LoadingDialog.hide(context);
                    context.navigator.pop(true);
                  },
                  onDeleteFailed: (context, state) {
                    LoadingDialog.hide(context);
                  },
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    children: <Widget>[
                      DropdownFieldBlocBuilder(
                        showEmptyItem: false,
                        decoration: InputDecoration(
                            labelText: 'Model',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'Amiko')),
                        itemBuilder: (context, value) =>
                            ['Personal', 'Company'][value],
                        selectFieldBloc: mapBloc.model,
                      ),
                      DropdownFieldBlocBuilder(
                        showEmptyItem: false,
                        decoration: InputDecoration(
                            labelText: 'Style',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'Amiko')),
                        itemBuilder: (context, value) =>
                            ['Apartment', 'Villa'][value],
                        selectFieldBloc: mapBloc.style,
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: mapBloc.lat,
                        isEnabled: false,
                        decoration: InputDecoration(
                            labelText: 'Latitude',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'Amiko')),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: mapBloc.lng,
                        isEnabled: false,
                        focusNode: FocusNode(),
                        decoration: InputDecoration(
                            labelText: 'Longitude',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'Amiko')),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: mapBloc.address,
                        isEnabled: false,
                        maxLines: 3,
                        decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'Amiko')),
                      ),
                      FlatButton(
                        child: Text('Select again on the map'),
                        onPressed: () {
                          showLocationPicker(context, Constant.ApiKey,
                                  initialCenter: LatLng(
                                      mapBloc.lat.valueToDouble,
                                      mapBloc.lng.valueToDouble),
                                  myLocationButtonEnabled: path == '/post',
                                  layersButtonEnabled: path == '/post',
                                  automaticallyAnimateToCurrentLocation:
                                      path == '/post')
                              .then((value) {
                            if (value != null) {
                              mapBloc.lat
                                  .updateValue('${value.latLng.latitude}');
                              mapBloc.lng
                                  .updateValue('${value.latLng.longitude}');
                              mapBloc.address.updateValue('${value.address}');
                            }
                          });
                        },
                      ),
                      IfNoneWidget(
                        basis: path == '/post',
                        builder: (context) {
                          return ListBody(
                            children: <Widget>[
                              RaisedButton(
                                child: Text('I want to fill in manually'),
                                onPressed: () async {
                                  postBloc.add(AddressFormEvent());
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ));

          final Widget formbody =
              FormBlocListener<AddressFormBloc, String, String>(
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
                  onDeleting: (context, state) {
                    LoadingDialog.show(context);
                  },
                  onDeleteSuccessful: (context, state) {
                    LoadingDialog.hide(context);
                    context.navigator.pop(true);
                  },
                  onDeleteFailed: (context, state) {
                    LoadingDialog.hide(context);
                  },
                  child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      children: <Widget>[
                        DropdownFieldBlocBuilder(
                          showEmptyItem: false,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(fontFamily: 'Amiko'),
                              labelText: Localization.of(context).model,
                              border: OutlineInputBorder()),
                          itemBuilder: (context, value) => [
                            Localization.of(context).modeltype[0],
                            Localization.of(context).modeltype[1]
                          ][value],
                          selectFieldBloc: formBloc.model,
                        ),
                        DropdownFieldBlocBuilder(
                          showEmptyItem: false,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(fontFamily: 'Amiko'),
                              labelText: Localization.of(context).style,
                              border: OutlineInputBorder()),
                          itemBuilder: (context, value) => [
                            Localization.of(context).styletype[0],
                            Localization.of(context).styletype[1]
                          ][value],
                          selectFieldBloc: formBloc.style,
                        ),
                        TextFieldBlocBuilder(
                            textFieldBloc: formBloc.city,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                labelText: Localization.of(context).city,
                                border: OutlineInputBorder())),
                        TextFieldBlocBuilder(
                            textFieldBloc: formBloc.community,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                labelText: Localization.of(context).community,
                                border: OutlineInputBorder())),
                        TextFieldBlocBuilder(
                            textFieldBloc: formBloc.street,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                labelText: Localization.of(context).street,
                                border: OutlineInputBorder())),
                        TextFieldBlocBuilder(
                            textFieldBloc: formBloc.building,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                labelText: Localization.of(context).building,
                                border: OutlineInputBorder())),
                        TextFieldBlocBuilder(
                            onSubmitted: (value) {
                              formBloc.submit();
                            },
                            textFieldBloc: formBloc.roomNo,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                labelText: Localization.of(context).roomNo,
                                border: OutlineInputBorder())),
                        IfNoneWidget(
                          basis: path == '/post',
                          builder: (context) {
                            return ListBody(
                              children: <Widget>[
                                SizedBox(height: 10),
                                RaisedButton(
                                  child: Text(Localization.of(context).mapinfo),
                                  onPressed: () async {
                                    showLocationPicker(context, Constant.ApiKey,
                                            initialCenter: LatLng(
                                                25.108220955794977,
                                                55.21488390862942),
                                            myLocationButtonEnabled: true,
                                            layersButtonEnabled: true,
                                            automaticallyAnimateToCurrentLocation:
                                                true)
                                        .then((value) {
                                      if (value != null) {
                                        mapBloc.lat.updateValue(
                                            '${value.latLng.latitude}');
                                        mapBloc.lng.updateValue(
                                            '${value.latLng.longitude}');
                                        mapBloc.address
                                            .updateValue('${value.address}');
                                        postBloc.add(AddressMapEvent());
                                      }
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ]));

          return Scaffold(
              appBar: AppBar(
                title: Text(
                  Localization.of(context).address +
                      '${path == '/put' ? ' Detail' : ' New'}',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Amiko', fontSize: 17),
                ),
                actions: <Widget>[
                  IfNoneWidget(
                      basis: path == '/put',
                      builder: (context) {
                        return Visibility(
                          visible: false,
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              if (state is AddressMapState) {
                                mapBloc.delete();
                              } else {
                                formBloc.delete();
                              }
                            },
                          ),
                        );
                      }),
                  FlatButton(
                    child: Text(Localization.of(context).submit,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Amiko')),
                    onPressed: () {
                      if (state is AddressMapState) {
                        mapBloc.submit();
                      } else {
                        formBloc.submit();
                      }
                    },
                  )
                ],
              ),
              body: state is AddressMapState ? mapbody : formbody);
        }));

    return body;
  }
}

// class BottomAppBarDemo extends StatefulWidget {
//   const BottomAppBarDemo();

//   @override
//   State createState() => _BottomAppBarDemoState();
// }

// class _BottomAppBarDemoState extends State<BottomAppBarDemo> {
//   var _showFab = true;
//   var _showNotch = true;
//   var _fabLocation = FloatingActionButtonLocation.endDocked;

//   void _onShowNotchChanged(bool value) {
//     setState(() {
//       _showNotch = value;
//     });
//   }

//   void _onShowFabChanged(bool value) {
//     setState(() {
//       _showFab = value;
//     });
//   }

//   void _onFabLocationChanged(FloatingActionButtonLocation value) {
//     setState(() {
//       _fabLocation = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget body = Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Title'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.only(bottom: 88),
//         children: [
//           SwitchListTile(
//             title: Text(
//               'Title',
//             ),
//             value: _showFab,
//             onChanged: _onShowFabChanged,
//           ),
//           SwitchListTile(
//             title: Text('Notch'),
//             value: _showNotch,
//             onChanged: _onShowNotchChanged,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Text('Position'),
//           ),
//           RadioListTile<FloatingActionButtonLocation>(
//             title: Text('DockedEnd'),
//             value: FloatingActionButtonLocation.endDocked,
//             groupValue: _fabLocation,
//             onChanged: _onFabLocationChanged,
//           ),
//           RadioListTile<FloatingActionButtonLocation>(
//             title: Text('DockedCenter'),
//             value: FloatingActionButtonLocation.centerDocked,
//             groupValue: _fabLocation,
//             onChanged: _onFabLocationChanged,
//           ),
//           RadioListTile<FloatingActionButtonLocation>(
//             title: Text('FloatingEnd'),
//             value: FloatingActionButtonLocation.endFloat,
//             groupValue: _fabLocation,
//             onChanged: _onFabLocationChanged,
//           ),
//           RadioListTile<FloatingActionButtonLocation>(
//             title: Text(
//               'FloatingCenter',
//             ),
//             value: FloatingActionButtonLocation.centerFloat,
//             groupValue: _fabLocation,
//             onChanged: _onFabLocationChanged,
//           ),
//         ],
//       ),
//     );

//     return body;
//   }
// }

// class _BottomAppBar extends StatelessWidget {
//   const _BottomAppBar({
//     this.fabLocation,
//     this.shape,
//   });

//   final FloatingActionButtonLocation fabLocation;
//   final NotchedShape shape;

//   static final centerLocations = <FloatingActionButtonLocation>[
//     FloatingActionButtonLocation.centerDocked,
//     FloatingActionButtonLocation.centerFloat,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       shape: shape,
//       child: IconTheme(
//         data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
//         child: Row(
//           children: [
//             IconButton(
//               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//               icon: const Icon(Icons.menu),
//               onPressed: () {},
//             ),
//             if (centerLocations.contains(fabLocation)) const Spacer(),
//             IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: const Icon(Icons.favorite),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
