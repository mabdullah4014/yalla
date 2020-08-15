import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'repo/location_repository.dart' as locationRepo;

class LocationController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;

  LocationController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    locationRepo.setCurrentLocation().then((locationData) {
      setState(() {
        locationRepo.locationData = locationData;
      });
    });
  }

  Location getLocation() {
    return locationRepo.location;
  }
}
