// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../apis/client.dart';
import '../pages/pages.dart';

class Routes {
  static const String authentication = '/';
  static const String _userPage = '/users/:id';
  static String userPage({@required dynamic id}) => '/users/$id';
  static const String faqPage = '/faqs';
  static const String contractPage = '/contract';
  static const String addressPage = '/address';
  static const String pickaddr = '/pickaddr';
  static const String _orderPage = '/order/:id?';
  static const String _orderlistpage='/orderlistpage';
  static String orderPage({dynamic id = ''}) => '/order/$id';
  static const String _orderPostPage = '/order/:id?/post';
  static String orderPostPage({dynamic id = ''}) => '/order/$id/post';
  static const String additionPostPage = '/addition/post';
  static const String viewOrderImage = '/image/order';
  static const String orderCommentPostPage = '/comment/post';
  static const all = <String>{
    authentication,
    _orderlistpage,
    _userPage,
    faqPage,
    contractPage,
    addressPage,
    pickaddr,
    _orderPage,
    _orderPostPage,
    additionPostPage,
    viewOrderImage,
    orderCommentPostPage,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.authentication, page: Authentication),
    RouteDef(
      Routes._userPage,
      page: UserPage,
      generator: UserPageRouter(),
    ),
    RouteDef(Routes.faqPage, page: FaqPage),
    RouteDef(
      Routes.contractPage,
      page: ContractPage,
      generator: ContractPageRouter(),
    ),
    RouteDef(
      Routes.addressPage,
      page: AddressPage,
      generator: AddressPageRouter(),
    ),
    RouteDef(Routes.pickaddr, page: AddressListPage),

    RouteDef(Routes._orderlistpage, page: OrderListPage),
    RouteDef(Routes._orderPage, page: OrderPage),
    RouteDef(Routes._orderPostPage, page: OrderPostPage),
    RouteDef(Routes.additionPostPage, page: AdditionPostPage),
    RouteDef(Routes.viewOrderImage, page: ViewOrderImage),
    RouteDef(Routes.orderCommentPostPage, page: OrderCommentPostPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    Authentication: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => Authentication(),
        settings: data,
      );
    },
    UserPage: (data) {
      return buildAdaptivePageRoute<Widget>(
        builder: (context) => UserPage(),
        settings: data,
      );
    },
    FaqPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => FaqPage(),
        settings: data,
      );
    },
    ContractPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ContractPage(),
        settings: data,
      );
    },
    AddressPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AddressPage(),
        settings: data,
      );
    },
    AddressListPage: (data) {
      final args = data.getArgs<AddressListPageArguments>(
        orElse: () => AddressListPageArguments(),
      );
      return buildAdaptivePageRoute<Address>(
        builder: (context) => AddressListPage(
          key: args.key,
          pick: args.pick,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    OrderListPage: (data) {
      final args = data.getArgs<OrderListArguments>(
        orElse: () => OrderListArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => OrderListPage(

        ),
        settings: data,
      );
    },
    OrderPage: (data) {
      final args = data.getArgs<OrderPageArguments>(
        orElse: () => OrderPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => OrderPage(
          key: args.key,
          data: args.data,
        ),
        settings: data,
      );
    },
    OrderPostPage: (data) {
      final args = data.getArgs<OrderPostPageArguments>(
        orElse: () => OrderPostPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => OrderPostPage(
          key: args.key,
          data: args.data,
        ),
        settings: data,
      );
    },
    AdditionPostPage: (data) {
      final args = data.getArgs<AdditionPostPageArguments>(
        orElse: () => AdditionPostPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AdditionPostPage(
          key: args.key,
          postId: args.postId,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    ViewOrderImage: (data) {
      final args = data.getArgs<ViewOrderImageArguments>(
        orElse: () => ViewOrderImageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ViewOrderImage(
          key: args.key,
          url: args.url,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    OrderCommentPostPage: (data) {
      final args = data.getArgs<OrderCommentPostPageArguments>(
        orElse: () => OrderCommentPostPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => OrderCommentPostPage(
          key: args.key,
          objectid: args.objectid,
          contenttype: args.contenttype,
          reply: args.reply,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
  };
}

class UserPageRoutes {
  static const String userProfilePage = '/';
  static const String userPhotoPage = '/photo';
  static const String _userPostPage = '/post/:field?';
  static String userPostPage({dynamic field = ''}) => '/post/$field';
  static const String _emailValidatePage = '/emailvalidate/:email?';
  static String emailValidatePage({dynamic email = ''}) =>
      '/emailvalidate/$email';
  static const String joinPage = '/join';
  static const all = <String>{
    userProfilePage,
    userPhotoPage,
    _userPostPage,
    _emailValidatePage,
    joinPage,
  };
}

class UserPageRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(UserPageRoutes.userProfilePage, page: UserProfilePage),
    RouteDef(UserPageRoutes.userPhotoPage, page: UserPhotoPage),
    RouteDef(UserPageRoutes._userPostPage, page: UserPostPage),
    RouteDef(UserPageRoutes._emailValidatePage, page: EmailValidatePage),
    RouteDef(UserPageRoutes.joinPage, page: JoinPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    UserProfilePage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => UserProfilePage(),
        settings: data,
      );
    },
    UserPhotoPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => UserPhotoPage(),
        settings: data,
      );
    },
    UserPostPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => UserPostPage(),
        settings: data,
      );
    },
    EmailValidatePage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => EmailValidatePage(),
        settings: data,
      );
    },
    JoinPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => JoinPage(),
        settings: data,
      );
    },
  };
}

class ContractPageRoutes {
  static const String contractListPage = '/';
  static const String _contractPost = '/:id/post';
  static String contractPost({@required dynamic id}) => '/$id/post';
  static const all = <String>{
    contractListPage,
    _contractPost,
  };
}

class ContractPageRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(ContractPageRoutes.contractListPage, page: ContractListPage),
    RouteDef(ContractPageRoutes._contractPost, page: ContractPost),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    ContractListPage: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ContractListPage(),
        settings: data,
      );
    },
    ContractPost: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ContractPost(),
        settings: data,
      );
    },
  };
}

class AddressPageRoutes {
  static const String list = '/';
  static const String post = '/post';
  static const String put = '/put';
  static const all = <String>{
    list,
    post,
    put,
  };
}

class AddressPageRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(AddressPageRoutes.list, page: AddressListPage),
    RouteDef(AddressPageRoutes.post, page: AddressPostPage),
    RouteDef(AddressPageRoutes.put, page: AddressPostPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    AddressListPage: (data) {
      final args = data.getArgs<AddressListPageArguments>(
        orElse: () => AddressListPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AddressListPage(
          key: args.key,
          pick: args.pick,
        ),
        settings: data,
      );
    },
    AddressPostPage: (data) {
      final args = data.getArgs<AddressPostPageArguments>(
        orElse: () => AddressPostPageArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AddressPostPage(
          key: args.key,
          data: args.data,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// AddressListPage arguments holder class
class AddressListPageArguments {
  final Key key;
  final bool pick;
  AddressListPageArguments({this.key, this.pick = false});
}
class OrderListArguments {

  OrderListArguments();
}
/// OrderPage arguments holder class
class OrderPageArguments {
  final Key key;
  final Order data;
  OrderPageArguments({this.key, this.data});
}

/// OrderPostPage arguments holder class
class OrderPostPageArguments {
  final Key key;
  final Order data;
  OrderPostPageArguments({this.key, this.data});
}

/// AdditionPostPage arguments holder class
class AdditionPostPageArguments {
  final Key key;
  final int postId;
  AdditionPostPageArguments({this.key, this.postId});
}

/// ViewOrderImage arguments holder class
class ViewOrderImageArguments {
  final Key key;
  final String url;
  ViewOrderImageArguments({this.key, this.url});
}

/// OrderCommentPostPage arguments holder class
class OrderCommentPostPageArguments {
  final Key key;
  final int objectid;
  final String contenttype;
  final Comment reply;
  OrderCommentPostPageArguments(
      {this.key, this.objectid, this.contenttype, this.reply});
}

/// AddressPostPage arguments holder class
class AddressPostPageArguments {
  final Key key;
  final Address data;
  AddressPostPageArguments({this.key, this.data});
}
