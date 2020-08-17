import 'package:arbi/model/category_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  YallaService service;
  String heroTag;

  ServiceWidget({Key key, this.service, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, top: 10),
      child: Column(
        children: <Widget>[
          // Image of the card
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              width: 220,
              height: 130,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: service.image,
                      placeholder: (context, url) => Image.asset(
                          'assets/images/loading.gif',
                          fit: BoxFit.contain),
                      errorWidget: (context, url, error) => Icon(Icons.error)),
                  Positioned(
                    child: Container(
                      color: Colors.black12,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Column(
                      children: <Widget>[
                        Text(service.name,
                            style: TextStyle(color: Colors.white, fontSize: 15))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
