import 'package:flutter/material.dart';

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  List slides = [
    { 'pic': 'assets/images/slider-1.jpg' },
    { 'pic': 'assets/images/slider-2.jpg' },
    { 'pic': 'assets/images/slider-3.jpg' },
    { 'pic': 'assets/images/slider-4.jpg' },
    { 'pic': 'assets/images/slider-5.jpg' },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(   backgroundColor: Color(0xFF213c56),
        title: Text("Offers",style: TextStyle(color: Colors.white,fontFamily: 'Amiko'),),
      ),
      body: ListView.builder(
          itemCount: slides.length,
          itemBuilder: (context,index) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Image.asset(slides[index]['pic']),
            ),
          )
      ),
    );
  }
}
