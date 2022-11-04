import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

class LiveData extends StatefulWidget {
  const LiveData({Key? key}) : super(key: key);

  @override
  State<LiveData> createState() => _LiveDataState();
}

class _LiveDataState extends State<LiveData> {
  var locationData;
  GeoCode geoCode = new GeoCode();
  getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

    Address data = await geoCode.reverseGeocoding(
        latitude: _locationData.latitude!, longitude: _locationData.longitude!);
    var abc = data.toString().split(",")[4];
    var streetAddress = abc.split("=").last;
    print(streetAddress);

    setState(() {
      locationData = streetAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(2, 4),
                    blurRadius: 3,
                    spreadRadius: 5)
              ]),
              child: Column(
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        getCurrentLocation();
                      },
                      icon: Icon(Icons.room),
                      label: Text("Get My Location")),
                  Text(locationData == null
                      ? ""
                      : "Latitude:${locationData}\nLongitude:${locationData}")
                ],
              ))),
    );
  }
}
