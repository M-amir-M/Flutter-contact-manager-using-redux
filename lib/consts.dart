import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlobalKeys {
  static final navigatorKey = new GlobalKey<NavigatorState>();
  static final scaffoldKey = new GlobalKey<ScaffoldState>();
}

class BaseUrl {
  static final baseUrl = 'https://mock-rest-api-server.herokuapp.com/api/v1';
}

