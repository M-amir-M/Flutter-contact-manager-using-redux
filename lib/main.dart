import 'package:contact/consts.dart';
import 'package:contact/redux/models/model.dart';
import 'package:contact/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:contact/redux/reducers/app_state_reducer.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:contact/redux/middleware/middlware.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  final ThemeData androidTheme = new ThemeData(
      fontFamily: 'is',
      primaryColorDark: Color(0xFF185a9d),
      primaryColorLight: Color(0xFF43cea2),
      accentColor: Color(0xFF43cea2),
      primaryColor: Colors.white,
      primaryTextTheme: TextTheme(caption: TextStyle(fontSize: 12.0)));

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final logger = new LoggingMiddleware.printer();

    final store = Store<AppState>(
      appReducer,
      middleware: [appStateMiddleware]
        ..add(logger), //new,
      initialState: AppState.initialState(),
    );

    return StoreProvider(
      store: store,
      child: new Directionality(
          textDirection: TextDirection.rtl,
          child: new MaterialApp(
            navigatorKey: GlobalKeys.navigatorKey,
            theme: androidTheme,
            title: '',
            initialRoute: '/splash',
            // routes: getRoutes(context, store),
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                builder: (BuildContext context) => makeRoute(
                      context: context,
                      routeName: settings.name,
                      arguments: settings.arguments,
                    ),
                maintainState: true,
                fullscreenDialog: false,
              );
            },
          )),
    );

  }
}
