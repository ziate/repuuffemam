import 'dart:convert';
import 'dart:developer';

import 'package:efood_multivendor/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class API {
  Future<Map> getRequest(
      {@required String url,
      Map<String, String> headers,
      BuildContext context}) async {
    SharedPreferences _sharedData = await SharedPreferences.getInstance();
    String token = _sharedData.get(AppConstants.TOKEN);
    http.Response response = await http.get(Uri.parse(url), headers: headers
        //  {
        //   'Content-Type': 'application/json; charset=UTF-8',
        //   'Authorization': 'Bearer $token'
        // }

        );
    log(response.body);
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      return data;
      // } else {
      //   //throw Exception('status code not 200 it is ${response.statusCode}');

      // }
    }
  }

  Future<dynamic> postRequest(
      {@required String url,
      Map body,
      @required Map<String, String> headers}) async {
    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var resBody = json.decode(response.body);
      print(resBody);
      return resBody;
    } else {
      var resBody = json.decode(response.body);
      print(resBody);
      throw Exception('status code not 200 it is ${response.statusCode}');
    }
  }
}
