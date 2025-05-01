import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  InternetConnectionChecker get instance => InternetConnectionChecker.I;
}

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@Injectable(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker instance;

  NetworkInfoImpl({required this.instance});
  @override
  Future<bool> get isConnected => instance.hasConnection;
}
