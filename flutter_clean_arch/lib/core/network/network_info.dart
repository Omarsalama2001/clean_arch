import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  // optional for code main and reuse
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
