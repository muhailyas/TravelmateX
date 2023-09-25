import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:travelmatex/controllers/destination_controller.dart';

class LocationAccess extends StatefulWidget {
  const LocationAccess({Key? key}) : super(key: key);

  @override
  LocationAccessState createState() => LocationAccessState();
}

class LocationAccessState extends State<LocationAccess> {
  final destinationController = Get.find<DestinationController>();
  String address = 'searching...';

  @override
  void initState() {
    super.initState();
    _getLocationAndAddress();
  }

  Future<void> _getLocationAndAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        address = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          address = 'Location permissions are denied.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        address = 'Location permissions are permanently denied.';
      });
      return;
    }

    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      await _getAddressFromLatLong(position);
    } catch (e) {
      // print('Error fetching location: $e');
    }
  }

  Future<void> _getAddressFromLatLong(Position position) async {
    String? district;
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        address = '${place.subLocality}, ${place.administrativeArea}';
        district = place.subLocality;
      });
    } catch (e) {
      setState(() {
        address = 'not available.';
      });
    } finally {
      destinationController.fetchDestinationNearbyMe(district);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      address,
      style: const TextStyle(color: Colors.black),
    );
  }
}
