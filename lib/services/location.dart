import 'package:geolocator/geolocator.dart';

// create a location class to get the lat and long for a location from the geolocator package
class Location {
  double latitude;
  double longitude;

  // method that gets current location by getting the current position and specifying the accuracy
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        forceAndroidLocationManager: true,
      );
      // assign the lat and long to the positions that come back from the get current position
      latitude = position.latitude;
      longitude = position.longitude;
      // if there is an error catch it and print it
    } catch (e) {
      print(e);
    }
  }
}
