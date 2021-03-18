import 'package:auto_route/auto_route.dart';
import 'package:bookservice/apis/client.dart';
import 'package:bookservice/router/router.gr.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bookservice/I18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  children: [
                    ['assets/images/airConditioned.png', Localization.of(context).serviceType[0], '0'],
                    ['assets/images/electricaling.png', Localization.of(context).serviceType[1], '1'],
                    ['assets/images/plumbingg.png',Localization.of(context).serviceType[2], '2'],
                    ['assets/images/general_maintenanceing.png', Localization.of(context).serviceType[3], '3'],
                    ['assets/images/ducting.png',Localization.of(context).serviceType[4], '4'],
                    ['assets/images/interior_fitoutsing.png',Localization.of(context).serviceType[5], '5'],
                  ].map((item) {
                    return GestureDetector(
                      child: _GridPhotoItem(
                        photo: _Photo(assetName: item[0], title: item[1]),
                      ),
                      onTap: () {
                        print(int.parse(item[2]));
                        ExtendedNavigator.of(context).push('/order/0/post',
                            arguments: OrderPostPageArguments(
                                data: Order(
                              service: int.parse(item[2]),
                            )));
                      },
                    );
                  }).toList(),
                ),
//                Container(
//                  alignment: Alignment.centerLeft,
//                  padding: const EdgeInsets.only(
//                      top: 15, left: 8, right: 8, bottom: 8),
//                  child: Text(
//                    Localization.of(context).contactUs,
//                    style: TextStyle(fontSize: 18),
//                  ),
//                ),
//                CallMeView(),
//                Container(
//                  alignment: Alignment.center,
//                  padding: new EdgeInsets.symmetric(vertical: 18.0),
//                  width: double.infinity,
//                  child: new Text('@Copyright Eletec Technical Works',
//                      style: new TextStyle()),
//                )
              ],
            )),
      );
}

class _Photo {
  _Photo({
    this.assetName,
    this.title,
  });

  final String assetName;
  final String title;
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        text,
        style: GoogleFonts.amiko(),
      ),
    );
  }
}

class _GridPhotoItem extends StatelessWidget {
  _GridPhotoItem({
    Key key,
    @required this.photo,
  }) : super(key: key);

  final _Photo photo;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Colors.blue[100];

    final Widget image = Image.asset(
      photo.assetName,
      height: 65,
      // color: bgColor,
      // colorBlendMode: BlendMode.overlay,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 25.0,bottom: 25.0),
      child: GridTile(
        child: Card(
          elevation: 20,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color(0xffffffff),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image,
                SizedBox(height: 5,),
                Text(photo.title,style: TextStyle(fontSize: 14,color: Colors.grey[800]),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CallMeView extends StatelessWidget {
  Future<void> _makePhoneCall() async {
    if (await canLaunch('tel:<042500090>')) {
      await launch('tel:<042500090>');
    } else {
      print('Could not launch');
    }
  }

  @override
  Widget build(BuildContext context) {
    final MaterialColor bgColor = Colors.blue;
    final padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 14);

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          shape: BoxShape.rectangle,
          color: bgColor[200],
        ),
        child: Column(
          children: <Widget>[
            Container(
                padding: padding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  shape: BoxShape.rectangle,
                  color: bgColor,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        Localization.of(context).call,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      GestureDetector(
                        child: Text('04-250-0090',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        onTap: () {
                          _makePhoneCall();
                        },
                      )
                    ])),
            Container(
                padding: padding,
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/images/question.png'),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(Localization.of(context).support,
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    )
                  ],
                ))
          ],
        ));
  }
}

class BannerView extends StatefulWidget {
  @override
  _BannerViewState createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            initialPage: 0,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
          items: [
            'assets/images/slider-1.jpg',
            'assets/images/slider-2.jpg',
            'assets/images/slider-3.jpg',
            'assets/images/slider-4.jpg',
            // 'assets/images/slider-5.jpg',
          ].map((item) {
            return Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: Image.asset(item,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.8)),
            );
          }).toList(),
        )
      ],
    );
  }
}
