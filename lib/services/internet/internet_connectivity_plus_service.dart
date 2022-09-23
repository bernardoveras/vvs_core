import 'package:connectivity_plus/connectivity_plus.dart';

import 'connection_type.dart';
import 'internet_service.dart';

class InternetConnectivityPlusService implements IInternetService {
  final Connectivity connectivity;

  InternetConnectivityPlusService(this.connectivity);

  @override
  Future<ConnectionType> check() async {
    try {
      var result = await connectivity.checkConnectivity();

      if (result == ConnectivityResult.wifi) {
        return ConnectionType.wifi;
      } else if (result == ConnectivityResult.mobile) {
        return ConnectionType.mobile;
      } else if (result == ConnectivityResult.none) {
        return ConnectionType.none;
      } else {
        return ConnectionType.none;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isWifi() async => (await check()) == ConnectionType.wifi;
  @override
  Future<bool> isMobileData() async => (await check()) == ConnectionType.mobile;
}
