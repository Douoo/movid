import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movid/core/network/network_connection.dart';

@GenerateMocks([
  NetworkConnection,
  InternetConnectionChecker,
], customMocks: [
  MockSpec<http.Client>(as: #Mock)
])
void main() {}
