import 'package:connectivity/connectivity.dart';

class NetworkCheck {
  Future<bool> check() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile) {
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return true;
      }
      return false;
    } catch (e) {
      print('))))))))))))))))))))))))');
      print(e);
    }
  }

  dynamic checkInternet(Function func) {
    check().then((intenet) {
      if (intenet != null && intenet) {
        func(true);
      } else {
        func(false);
      }
    });
  }
}
