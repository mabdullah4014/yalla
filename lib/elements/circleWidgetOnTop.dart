import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerWithCircle extends StatelessWidget {
  final Widget child;
  final Color childBgColor;
  final ImageProvider imageProvider;

  ContainerWithCircle({this.child, this.childBgColor, this.imageProvider});

  static const double _circleRadius = 80.0;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: _circleRadius / 2.0),
          child: Container(
              color: childBgColor,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(
                  left: 10, right: 10, top: (_circleRadius / 2.0) + 10),
              child: child)),
      Container(
          width: _circleRadius,
          height: _circleRadius,
          decoration:
              ShapeDecoration(shape: CircleBorder(), color: Colors.white),
          child: DecoratedBox(
            decoration: ShapeDecoration(
                shape: CircleBorder(),
                image:
                    DecorationImage(fit: BoxFit.cover, image: imageProvider)),
          ))
    ]);
  }
}
