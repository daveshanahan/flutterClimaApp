import 'package:clima_app/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/networking.dart';
import 'package:clima_app/utilities/constants.dart';

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

    // store the parsed req.body object that is returned as a variable to use later
    var weatherData = networkHelper.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
