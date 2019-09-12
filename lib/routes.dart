library routes;

import 'package:contact/redux/actions/actions.dart';
import 'package:contact/redux/models/model.dart';
import 'package:contact/screens/contact_profile_screen.dart';
import 'package:contact/screens/contact_screen.dart';
import 'package:contact/screens/home_screen.dart';
import 'package:contact/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum ScreenKeys {
  addScreen,
}

Widget makeRoute(
    {@required BuildContext context,
    @required String routeName,
    store,
    Object arguments}) {
  final Widget child = _buildRoute(
      context: context,
      store: store,
      routeName: routeName,
      arguments: arguments);
  return child;
}

Widget _buildRoute({
  @required BuildContext context,
  @required String routeName,
  Object arguments,
  store,
}) {
  switch (routeName) {
    case '/':
      return new StoreBuilder<AppState>(
        builder: (context, store) {
          return new HomeScreen();
        },
      );
    case '/home':
      return new StoreBuilder<AppState>(
        builder: (context, store) {
          return new HomeScreen();
        },
      );
    case '/contact':
      return new StoreBuilder<AppState>(
        builder: (context, store) {
          var args = arguments as Map;
          
          return new ContactScreen(
            contact: args ?? null,
          );
        },
      );
    case '/add_edit_contact':
      return new StoreBuilder<AppState>(
        builder: (context, store) {
          var args = arguments as Map;
          
          return new ContactProfileScreen(
            contact: args ?? null,
          );
        },
      );
    case '/splash':
      return new StoreBuilder<AppState>(
        builder: (context, store) {
          return new SplashScreen();
        },
      );
    default:
      throw 'Route $routeName is not defined';
  }
}
