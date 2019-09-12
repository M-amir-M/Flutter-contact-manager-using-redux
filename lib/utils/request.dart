import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:contact/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = BaseUrl.baseUrl;
String token = '';

Future<Response> request(String path,
    {data, queryParameters, Options options, CancelToken cancelToken}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = preferences.getString('auth');
  if (string != null) {
    Map map = json.decode(string);
    token = map['api_token'];
  }

  BaseOptions customOptions = new BaseOptions(baseUrl: baseUrl, headers: {
    "Accept": "application/json",
    "Authorization": 'Bearer $token'
  });
  Dio dio = new Dio(customOptions);

  try {
    final response = dio.request(path,
        data: data, queryParameters: queryParameters, options: options);
    return response;
  } catch (e) {
    return e;
  }
}
