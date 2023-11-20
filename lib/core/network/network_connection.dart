// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkConnection {
  Future<bool> get isAvailable;
}

class NetworkConnectionImpl implements NetworkConnection {
  final InternetConnectionChecker connectionChecker;
  NetworkConnectionImpl({
    required this.connectionChecker,
  });
  @override
  Future<bool> get isAvailable => connectionChecker.hasConnection;
}
