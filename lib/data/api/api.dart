import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API {
  Future<Map> getRequest(
      {@required String url,
      Map<String, String> headers,
      BuildContext context}) async {
    http.Response response = await http.get(Uri.parse(url), headers: headers);
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
