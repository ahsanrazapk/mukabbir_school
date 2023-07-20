import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/login_response.dart';

class ApiCalls {

  static Future<LoginResponse> getLoginResponse(BuildContext context, String username, String password) async {

    late LoginResponse result;

    try {
      /*final response = await http.post(
        "https://jsonplaceholder.typicode.com/posts/1",
      );*/

      var response = await http.post(
          Uri.parse('https://syedu19.sg-host.com/api/login'),
          body: {
            "username": username,
            "password": password
          });


      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = LoginResponse.fromJson(item);
      } else {
        /*Toast.show("Data not found", context,
            duration: 2, backgroundColor: Colors.redAccent);*/
      }
    } catch (e) {
      //log(e);
    }
    return result;

  }

}