import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker instance;

  NetworkInfoImpl({required this.instance});
  @override
  Future<bool> get isConnected => instance.hasConnection;
}
