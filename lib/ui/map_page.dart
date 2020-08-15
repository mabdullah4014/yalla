import 'dart:async';

import 'package:arbi/generated/l10n.dart';
import 'package:arbi/location_controller.dart';
import 'package:arbi/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final Function(LatLng) onLatLngFinalized;

  MapPage({this.onLatLngFinalized});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final double _defaultPaddingMargin = 10;

  Completer<GoogleMapController> _controller;
  LocationController locationController;

  CameraPosition _qatarLocation = CameraPosition(
    target: LatLng(25.313258, 51.198361),
    zoom: 9,
  );

  Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();
    _controller = Completer();
    locationController = LocationController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            child: GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: _qatarLocation,
                onTap: (LatLng latLng) {
                  setState(() {
                    markers.clear();
                    markers
                        .add(Marker(markerId: MarkerId('1'), position: latLng));
                  });
                },
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  animateToCurrentLocation();
                }),
            margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 50)),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AppUtils.submitButton(context, S.of(context).done, () {
              if (markers.length > 0) {
                LatLng latLng = markers.elementAt(0).position;
                widget.onLatLngFinalized(latLng);
                Navigator.pop(context);
              } else {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(S.of(context).app_name),
                      content: SingleChildScrollView(
                          child: ListBody(children: <Widget>[
                        Text(S.of(context).tap_for_location)
                      ])),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(S.of(context).ok),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            })),
        Positioned(
            left: _defaultPaddingMargin,
            top: _defaultPaddingMargin,
            child: GestureDetector(
              child: Icon(
                CupertinoIcons.clear_thick_circled,
                color: Colors.grey.shade600,
                size: 40,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )),
      ],
    );
  }

  void animateToCurrentLocation() {
    while (locationController.getLocation() == null) {
      locationController.initState();
    }
    if (locationController.getLocation() != null) {
      locationController
          .getLocation()
          .onLocationChanged()
          .listen((LocationData currentLatLng) {
        if (currentLatLng != null) {
          _controller.future.then((mapController) => {
                mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(
                            currentLatLng.latitude, currentLatLng.longitude),
                        zoom: 17.0)))
              });
        }
      });
    }
  }
}
