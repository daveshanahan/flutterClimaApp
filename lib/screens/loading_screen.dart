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

    // instead of having to created new variables to pass into the API url, we can use the location object directly
    // initialise new networkHelper object and pass in the URL
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    // store the parsed req.body object that is returned as a variable to use in the location screen
    // you have to mark this await or else the data will return null on the location screen
    var weatherData = await networkHelper.getData();

    // use Navigator to send the weatherData to the location screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather: weatherData);
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
