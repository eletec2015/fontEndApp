import 'package:bookservice/I18n/i18n.dart';
import 'package:bookservice/bloc/app_bloc.dart';
import 'package:bookservice/bloc/order_bloc.dart';
import 'package:bookservice/pages/faqs.dart';
import 'package:bookservice/pages/pages.dart';
import 'package:bookservice/pages/profile.dart';
import 'package:bookservice/views/rally_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:bookservice/pages/offers.dart';
import 'package:auto_route/auto_route.dart';
import 'order.dart';
import 'service.dart';
import 'setting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
int screen=0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
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
return BlocBuilder<AppBloc, AppState>(
      builder: (BuildContext context, state) {
       return BlocProvider<OrderListBloc>(
            create: (_) => OrderListBloc(context),
            child: FocusTraversalGroup(
              policy: OrderedTraversalPolicy(),
              child: Scaffold(

                extendBodyBehindAppBar: true,
                drawer: Drawer(
                  child: ListView(
                    children: [
                      Container(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 70,),
                                  Visibility(
                                    visible: true,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Image.asset(
                                        'assets/images/icon_transparent.png', height: 100,width: 100,),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text("ELETEC TECHNICAL WORK", style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiko"),),
                                  SizedBox(height: 20,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            screen = 1;
                          });
//                      ExtendedNavigator.of(context).push('/orderlistpage',
//                      arguments: OrderListArguments(
//                      ));

//                  context.navigator.router.findMatch(settings)
                          // ignore: unawaited_futures
                          // context.navigator.push('/orderlistpage/');
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderListPage()));
                          Navigator.pop(context);
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/filing.png", height: 30, width: 30,),
                        ),
                        title: Text(Localization
                            .of(context)
                            .bookinghistory, style: TextStyle(color: Theme
                            .of(context)
                            .primaryColor, fontFamily: "Amiko",),
                        ),
                      ),
//                  Divider(color: Theme.of(context).primaryColor),
//                  ListTile(
//                    onTap: (){
//
//                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ))
//                    },
//                    leading: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Image.asset("assets/images/invoiceing.png",height: 30,width: 30,),
//                    ),
//                    title: Text("Payment Details",style: TextStyle(color: Theme.of(context).primaryColor),),
//                  ),
                      Divider(color: Theme
                          .of(context)
                          .primaryColor),
                      ListTile(
                        onTap: () {
                          ExtendedNavigator.of(context);
//                  context.navigator.router.findMatch(settings)
                          // ignore: unawaited_futures
                          context.navigator.push('/address/');
                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => AddressPage()));
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/address.png", height: 30,
                            width: 30,),
                        ),
                        title: Text(Localization
                            .of(context)
                            .address, style: TextStyle(color: Theme
                            .of(context)
                            .primaryColor, fontFamily: "Amiko"),),
                      ),
                      Divider(color: Theme
                          .of(context)
                          .primaryColor),
                      ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Profile(dialogNav : false)));
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/profilenew.png", height: 30,
                            width: 30,),
                        ),
                        title: Text(Localization
                            .of(context)
                            .profile, style: TextStyle(color: Theme
                            .of(context)
                            .primaryColor, fontFamily: "Amiko"),),
                      ),
                      Visibility(
                        visible: false,
                        child: Divider(color: Theme
                            .of(context)
                            .primaryColor),
                      ),
                      Visibility(
                        visible: false,
                        child: ListTile(
                          onTap: () {
                            ExtendedNavigator.of(context);
//                  context.navigator.router.findMatch(settings)
                            // ignore: unawaited_futures
                            context.navigator.push('/contract/');
                          },
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/receipting.png", height: 30,
                              width: 30,),
                          ),
                          title: Text(Localization
                              .of(context)
                              .contactUs,
                            style: TextStyle(fontFamily: "Amiko", color: Theme
                                .of(context)
                                .primaryColor),),
                        ),
                      ),
                      Divider(color: Theme
                          .of(context)
                          .primaryColor),
                      ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => FaqPage()));
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/helping.png", height: 30,
                            width: 30,),
                        ),
                        title: Text(Localization
                            .of(context)
                            .faqs, style: TextStyle(fontFamily: "Amiko", color: Theme
                            .of(context)
                            .primaryColor),),
                      ),
                      Divider(color: Theme
                          .of(context)
                          .primaryColor),

                      Visibility(
                        visible: false,
                        child: ListTile(
                          title: Text(Localization
                              .of(context)
                              .language,style: TextStyle(fontFamily: "Amiko", color: Theme
                              .of(context)
                              .primaryColor),),
                          subtitle: state.locale.languageCode == 'en'
                              ? Text(Localization
                              .of(context)
                              .english,style: TextStyle(fontFamily: "Amiko", color: Theme
                              .of(context)
                              .primaryColor),)
                              : Text(Localization
                              .of(context)
                              .arabic),
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:FaIcon(FontAwesomeIcons.globeAsia,color: Theme
                                .of(context)
                                .primaryColor),
                          ),
                          // secondary:
                          // onChanged: (bool value) {
                          //   // print(value);
                          //   // BlocProvider.of<AppBloc>(context).add(SwitchLanguage(
                          //   //     value ? Locale('ar', 'IQ') : Locale('en', '')));
                          // },
                         // value: state.locale.languageCode != 'en',
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Offers()));
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/receipting.png", height: 30,
                            width: 30,),
                        ),
                        title: Text(Localization
                            .of(context)
                            .offers, style: TextStyle(color: Theme
                            .of(context)
                            .primaryColor, fontFamily: "Amiko"),),
                      ),

                      Divider(color: Theme
                          .of(context)
                          .primaryColor),
                      ListTile(
                        onTap: () {
                          ExtendedNavigator.of(context);
//                  context.navigator.router.findMatch(settings)
                          // ignore: unawaited_futuresv

                          BlocProvider.of<AppBloc>(context).add(SignOut());
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/exiting.png", height: 30,
                            width: 30,),
                        ),
                        title: Text(Localization
                            .of(context)
                            .logout,
                          style: TextStyle(fontFamily: "Amiko", color: Theme
                              .of(context)
                              .primaryColor),),
                      ),
                      SizedBox(height: 20,),
                      Image.asset('assets/images/eletec_logoing.png', height: 30,),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
                 appBar: screen==1?AppBar(
                   iconTheme: IconThemeData(
                     color: Colors.white
                   ),
                   title: Text("Booking History",style: TextStyle(color: Colors.white,fontFamily: "Amiko", fontSize: 16),),
                   backgroundColor: Color(0xFF1d364f),
                   leading: screen==1?IconButton(
                   icon: Icon(Icons.arrow_back,color:Colors.white),
                     onPressed: () {
                       setState(() {
                         screen=0;
                       });
                     },

                   ):null
                 ):AppBar(
                   backgroundColor: Color(0x001d364f),
                   actions: [
                     Visibility(
                       visible: false,
                       child: Container(
                         margin: EdgeInsets.only(right: 20, top: 10),
                         child: Image.asset(
                           'assets/images/icon_transparent.png', height: 50,width: 50,),
                       ),
                     ),
                   ],
                 ),
                body: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: screen==0?BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/pping.jpeg"),
                          fit: BoxFit.cover)
                  ):null,
                  child: screen == 0 ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0,  top: 40.0,right: 30.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Localization
                                    .of(context)
                                    .welcome, style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0,
                                    fontFamily: 'Amiko'),),
                                Text(Localization
                                    .of(context)
                                    .choose_service1, style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontFamily: 'Amiko'),),
                                Text(Localization
                                    .of(context)
                                    .choose_service2, style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontFamily: 'Amiko'),),
                              ],
                            ),
                            state.locale.languageCode == 'en' ?SizedBox(width: MediaQuery.of(context).size.width*0.06,):
                            SizedBox(width: MediaQuery.of(context).size.width*0.23,),
                            Visibility(
                              visible: true,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  'assets/images/splash.jpg', height: 50,width: 50,),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ServicePage(),
                    ],
                  ) : OrderListPage(),
                ),
              ),
//          child: Column(
//            children: [
////              RallyTabBar(
////                tabs: buildTabs(
////                    context,
////                    Theme.of(context).textTheme.button.copyWith(
////                        fontSize: 18,
////                        fontWeight: FontWeight.bold,
////                        color: Colors.blue)),
////                tabController: _tabController,
////              ),
////              Expanded(
////                child: TabBarView(
////                  controller: _tabController,
////                  children: buildTabViews(),
////                ),
////              ),
//            ],
//          ),
            )
        );

      });
  }

  List<Widget> buildTabViews() {
    return [ServicePage(), OrderListPage(), SettingPage()];
  }

  List<Widget> buildTabs(context, textStyle) {
    return [
      RallyTab(
        textStyle: textStyle,
        iconData: Icons.phone,
        title: Localization.of(context).services,
        tabIndex: 0,
        tabController: _tabController,
        isVertical: false,
        color: Colors.blue,
        tabCount: 3,
      ),
      RallyTab(
        textStyle: textStyle,
        iconData: Icons.date_range,
        title: Localization.of(context).orders,
        tabIndex: 1,
        tabController: _tabController,
        isVertical: false,
        color: Colors.blue,
        tabCount: 3,
      ),
      RallyTab(
        textStyle: textStyle,
        iconData: Icons.settings,
        title: Localization.of(context).settings,
        tabIndex: 2,
        tabController: _tabController,
        isVertical: false,
        color: Colors.blue,
        tabCount: 3,
      ),
    ];
  }
}
