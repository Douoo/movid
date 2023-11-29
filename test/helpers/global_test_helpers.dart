import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

@GenerateMocks([
  InternetConnectionChecker,
  TvSeriesRepository,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
