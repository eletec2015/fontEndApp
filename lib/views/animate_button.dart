// import 'dart:async';
// import 'dart:ui' show lerpDouble;
// import 'package:animator/animator.dart';
// import 'package:flutter/material.dart';

// class AnimateButton extends StatelessWidget {
//   final String buttonText;
//   final double minWidth;
//   final double height;
//   final AnimatorKey<double> animatorKey;
//   final VoidCallback onPressed;

//   const AnimateButton(
//       {Key key,
//       this.buttonText,
//       this.height = 45,
//       this.minWidth = 88.0,
//       this.animatorKey,
//       this.onPressed})
//       : super(key: key);

//   double lerpWidth(a, b, t) {
//     if (a == 0.0 || b == 0.0) {
//       return null;
//     } else {
//       return a + (b - a) * t;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (_, constraints) {
//         return Animator(
//           animatorKey: animatorKey,
//           tween: Tween<double>(begin: 0, end: 1.0),
//           cycles: 1,
//           builder: (context, animate, child) {
//             final double width =
//                 lerpWidth(constraints.maxWidth, height, animate.value);

//             return Container(
//               height: height,
//               width: width,
//               child: ButtonTheme(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         lerpDouble(5, height / 2, animate.value)),
//                   ),
//                   child: width > minWidth
//                       ? RaisedButton(
//                           child: Text(buttonText ?? '',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold)),
//                           onPressed: onPressed)
//                       : Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.blue,
//                           ),
//                           padding: const EdgeInsets.all(10),
//                           child: SpinKitRotatingCircle(
//                             color: Colors.white,
//                           ),
//                         )),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class AnimateTimerButton extends StatefulWidget {
//   final String buttonText;
//   final double minWidth;
//   final double height;
//   final AnimatorKey<double> animatorKey;
//   final VoidCallback onPressed;

//   const AnimateTimerButton(
//       {Key key,
//       this.buttonText,
//       this.height = 45,
//       this.minWidth = 88.0,
//       this.animatorKey,
//       this.onPressed})
//       : super(key: key);

//   @override
//   State<StatefulWidget> createState() => AnimateTimerButtonState();
// }

// class AnimateTimerButtonState extends State<AnimateTimerButton> {
//   int secondsLeft = 0;
//   Timer _timer;
//   Stream emptyStream = Stream.empty();

//   void animateForward() {
//     widget.animatorKey.controller.forward();
//   }

//   void startTimer(int newTime) {
//     if (newTime == 0) {
//       throw ("Count Down Time can not be null");
//     }

//     animateForward();

//     setState(() {
//       secondsLeft = newTime;
//     });

//     if (_timer != null) {
//       _timer.cancel();
//     }

//     var oneSec = const Duration(seconds: 1);
//     _timer = new Timer.periodic(
//       oneSec,
//       (Timer timer) => setState(
//         () {
//           if (secondsLeft < 1) {
//             timer.cancel();
//           } else {
//             secondsLeft = secondsLeft - 1;
//           }
//         },
//       ),
//     );
//   }

//   double lerpWidth(a, b, t) {
//     if (a == 0.0 || b == 0.0) {
//       return null;
//     } else {
//       return a + (b - a) * t;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (_, constraints) {
//         return Animator(
//           animatorKey: widget.animatorKey,
//           tween: Tween<double>(begin: 0, end: 1.0),
//           cycles: 1,
//           builder: (context, animate, child) {
//             final double width =
//                 lerpWidth(constraints.maxWidth, widget.height, animate.value);

//             return Container(
//               height: widget.height,
//               width: width,
//               child: ButtonTheme(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         lerpDouble(5, widget.height / 2, animate.value)),
//                   ),
//                   child: width > widget.minWidth
//                       ? RaisedButton(
//                           child: Text(widget.buttonText ?? '',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold)),
//                           onPressed: widget.onPressed)
//                       : StreamBuilder(
//                           stream: emptyStream,
//                           builder: (context, snapshot) {
//                             if (secondsLeft == 0) {
//                               animate.controller.reverse();
//                             }
//                             return Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(50)),
//                               margin: EdgeInsets.all(5),
//                               alignment: Alignment.center,
//                               width: 40,
//                               height: 40,
//                               child: Text("$secondsLeft"),
//                             );
//                           })),
//             );
//           },
//         );
//       },
//     );
//   }
// }
