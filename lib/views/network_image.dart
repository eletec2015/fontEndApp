import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class NetWorkImage extends StatelessWidget {
  final String url;

  const NetWorkImage(this.url, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(url, fit: BoxFit.cover,
        loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return CircularProgressIndicator();
        case LoadState.completed:
          return AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(microseconds: 0),
            curve: Curves.easeIn,
            child: ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          );
        default:
          return null;
          break;
      }
    });
  }
}
