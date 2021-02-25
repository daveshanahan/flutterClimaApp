import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clima_app/utilities/constants.dart';

class NetworkHelper {
  // created networking class that passes in a url
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    // we use the get request to make a request to the url we passed in
    http.Response response = await http.get(url);

    // if the request is successful, we store the req.body in a variable
    if (response.statusCode == 200) {
      String data = response.body;

      // we use jsonDecode to parse the data and make it accessible
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
