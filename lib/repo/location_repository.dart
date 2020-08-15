import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

LocationData locationData;
Location location = new Location();

bool _serviceEnabled;
PermissionStatus _permissionGranted;

Future<LocationData> setCurrentLocation() async {
  var location = new Location();

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.DENIED) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.DENIED) {
      return null;
    }
  }

  location = (await location.getLocation()) as Location;

  return locationData;
}

Location getLocation() {
  return location;
}
