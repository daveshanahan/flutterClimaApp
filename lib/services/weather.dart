import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/networking.dart';
import 'package:clima_app/utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$kOpenWeatherMapUrl?q=$cityName&appid=$kApiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    // initialise a location object and call it's get current location method
    Location location = Location();
    await location.getCurrentLocation();

    // instead of having to created new variables to pass into the API url, we can use the location object directly
    // initialise new networkHelper object and pass in the URL
    NetworkHelper networkHelper = NetworkHelper(
        '$kOpenWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');

    // store the parsed req.body object that is returned as a variable to use in the location screen
    // you have to mark this await or else the data will return null on the location screen
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
