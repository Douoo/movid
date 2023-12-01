import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movid/core/network/network_connection.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //******** Core Dependency Injection **********//
  locator.registerLazySingleton<NetworkConnection>(
    () => NetworkConnectionImpl(
      connectionChecker: locator(),
    ),
  );

  //******** External Plugin **********//
  locator.registerLazySingleton(() => InternetConnectionChecker());
  locator.registerLazySingleton(() => http.Client());
}
