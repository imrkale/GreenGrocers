import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

class GoogleLocation extends StatefulWidget {
  @override
  _GoogleLocationState createState() => _GoogleLocationState();
}

class _GoogleLocationState extends State<GoogleLocation> {
  double latitude;
  double longitude;
  LocationData myLocation;
  String error;
  Location location = new Location();

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Center(
      child: Container(
        child: Column(
          children: [
            Text("Address"),
          ],
        ),
      ),
    );
  }

  getLocation() async {
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Please grant the permission';
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied please enable it from app settings';
      }
      myLocation = null;
    }
    final coordinates =
        new Coordinates(myLocation.latitude, myLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("hhhhhhhhhhhh");
    print(first.addressLine);
    print(first.subLocality);

    print(
        '${first.locality},${first.adminArea},${first.subLocality},${first.subAdminArea}'
        ',${first.addressLine},${first.featureName},${first.thoroughfare},${first.subThoroughfare}');
  }
}
