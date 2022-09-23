import 'connection_type.dart';

abstract class IInternetService {
  Future<ConnectionType> check();
  Future<bool> isWifi();
  Future<bool> isMobileData();
}
