import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movid/core/network/network_connection.dart';
import 'package:movid/features/movies/data/data_sources/movie_local_data_source.dart';
import 'package:movid/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

@GenerateMocks([
  NetworkConnection,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  InternetConnectionChecker,
  TvSeriesRepository,
  HiveInterface,
  http.Client,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
])
void main() {}
