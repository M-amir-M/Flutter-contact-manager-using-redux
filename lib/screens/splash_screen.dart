import 'package:connectivity/connectivity.dart';
import 'package:contact/redux/actions/actions.dart';
import 'package:contact/redux/middleware/middlware.dart';
import 'package:contact/redux/models/model.dart';
import 'package:contact/utils/check_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  fetchPrefrence(bool isNetworkPresent) {
    // Navigator.of(context).pushReplacementNamed('/intro');

    if (isNetworkPresent) {
    } else {}
  }

  _checkNet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool isOn = false;
    if (connectivityResult == ConnectivityResult.mobile) {
      isOn = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isOn = true;
    }
    return isOn;
  }

  @override
  Widget build(BuildContext context) {
    final darkColor = Theme.of(context).primaryColorDark;
    final lightColor = Theme.of(context).primaryColorLight;
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        onInit: (Store<AppState> store) async {
          bool isOn = await _checkNet();
          if (isOn) {
            store.dispatch(GetContactsAction());
          } else {
            var data = await getData('contacts');
            if (data != null) {
              store.dispatch(LoadedContactsAction(data));
              store.dispatch(LoadedFilteredAction(data));
            }
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [lightColor, darkColor],
              )),
              child: Center(
                child: Image.asset(
                  'assets/images/loader.gif',
                  width: 60,
                  height: 60,
                ),
              ),
            ),
          );
        });
  }
}

class _ViewModel {
  factory _ViewModel.create(Store<AppState> store) {}
}
