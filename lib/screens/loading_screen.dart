import 'package:clima_app/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/networking.dart';
import 'package:clima_app/utilities/constants.dart';
import 'package:clima_app/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    // put the method into init state so it is called as soon as the screen is accessed
    getLocationData();
  }

  void getLocationData() async {
    // initialise a location object and call it's get current location method
    Location location = Location();
    await location.getCurrentLocation();

    // assign the lat and long that come back from the method to the lat and long variables
    latitude = location.latitude;
    longitude = location.longitude;

    // initialise new networkHelper object and pass in the URL
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    // store the parsed req.body object that is returned as a variable to use in the location screen
    var weatherData = networkHelper.getData();

    // use Navigator to send the weatherData to the location screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // adding spinner while user waits
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
