import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/users_model.dart';

class APIServices {
  Future<List<Users>?> getTopUsers() async {
    var client = http.Client();
    var uri = Uri.parse("https://jsonplaceholder.typicode.com/users");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      return mediaFromJson(jsonResponse);
    } else {
      log("Error Occurs");
      return null;
    }
  }
}
