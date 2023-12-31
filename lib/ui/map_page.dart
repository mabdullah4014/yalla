import 'dart:async';

import 'package:arbi/generated/l10n.dart';
import 'package:arbi/location_controller.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final Function(LatLng) onLatLngFinalized;

  String latitude, longitude;

  MapPage({String latitude, String longitude, this.onLatLngFinalized}) {
    this.latitude = latitude;
    this.longitude = longitude;
  }

  @override
  State<MapPage> createState() => MapPageState(latitude, longitude);
}

class MapPageState extends State<MapPage> {
  final double _defaultPaddingMargin = 10;

  Completer<GoogleMapController> _controller;
  LocationController locationController;

  CameraPosition _initialLocation;

  Set<Marker> markers = Set();

  String latitude, longitude;

  MapPageState(String latitude, String longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
  }

  @override
  void initState() {
    super.initState();
    _controller = Completer();
    locationController = LocationController();
    if (latitude != null && longitude != null) {
      _initialLocation = CameraPosition(
          target: LatLng(double.parse(latitude), double.parse(longitude)),
          zoom: 17);
    } else {
      _initialLocation =
          CameraPosition(target: LatLng(33.048134, 43.001309), zoom: 9);
    }
    markers.add(
        Marker(markerId: MarkerId('1'), position: _initialLocation.target));
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
                initialCameraPosition: _initialLocation,
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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    animateToCurrentLocation();
                  });
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
    if (locationController.getLocation() != null &&
        latitude == null &&
        longitude == null) {
//      locationController
//          .getLocation()
//          .onLocationChanged()
//          .listen((LocationData currentLatLng) {
//        if (currentLatLng != null) {
//
//        }
//      });
      locationController.getLocation().getLocation().then((value) {
        _controller.future.then((mapController) => {
              mapController.moveCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(value.latitude, value.longitude),
                      zoom: 17.0)))
            });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.future.then((value) => value.dispose());
  }
}
