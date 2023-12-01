import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/movies/data/data_sources/movie_remote_data_source.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/movie/dummy_objects.dart';

void main() {
  late MockHttpClient mockClient;
  late MovieRemoteDataSourceImpl remoteDataSource;

  setUp(() async {
    await dotenv.load(fileName: ".env");
    mockClient = MockHttpClient();
    remoteDataSource = MovieRemoteDataSourceImpl(client: mockClient);
  });

  void setUpMockClientSuccess200(String url, String responseData) {
    when(mockClient.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    )).thenAnswer((_) async => http.Response(jsonReader(responseData), 200));
  }

  void setUpMockClientFailure404(url) {
    when(mockClient.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    )).thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('Movie Detail', () {
    const tMovieId = 12;
    test('should perform a GET request to Urls.movieDetail movie endpoint',
        () async {
      //arrange
      setUpMockClientSuccess200(
        Urls.movieDetail(tMovieId),
        'test/helpers/movie/dummy_response/movie_detail.json',
      );
      //act
      await remoteDataSource.getMovieDetail(tMovieId);
      //assert
      verify(mockClient.get(
        Uri.parse(Urls.movieDetail(tMovieId)),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('''should return a movie object when status 
    of get request is 200''', () async {
      //arrange
      setUpMockClientSuccess200(Urls.movieDetail(tMovieId),
          'test/helpers/movie/dummy_response/movie_detail.json');
      //act
      final result = await remoteDataSource.getMovieDetail(tMovieId);
      //assert
      expect(result, equals(testMovieDetailModel));
    });

    test('''should throw ServerException in case the connection to 
    Urls.popularMovies is not successful''', () {
      //arrange
      setUpMockClientFailure404(Urls.movieDetail(tMovieId));
      //act
      final call = remoteDataSource.getMovieDetail;
      //assert
      expect(
          () => call(tMovieId), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('Now Playing Movies', () {
    test('should perform a GET request to Urls.nowPlayingMovies endpoint',
        () async {
      //arrange
      setUpMockClientSuccess200(
        Urls.nowPlayingMovies,
        'test/helpers/movie/dummy_response/now_playing_movies.json',
      );
      //act
      await remoteDataSource.getNowPlayingMovies();
      //assert
      verify(mockClient.get(
        Uri.parse(Urls.nowPlayingMovies),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('''should return a list of movie object when status 
    of get request is 200''', () async {
      //arrange
      setUpMockClientSuccess200(Urls.nowPlayingMovies,
          'test/helpers/movie/dummy_response/now_playing_movies.json');
      //act
      final result = await remoteDataSource.getNowPlayingMovies();
      //assert
      expect(result, equals(testMovieList));
    });

    test('''should throw ServerException in case the connection to 
    Urls.popularMovies is not successful''', () {
      //arrange
      setUpMockClientFailure404(Urls.nowPlayingMovies);
      //act
      final call = remoteDataSource.getNowPlayingMovies;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
  group('Popular Movies', () {
    test('should perform a GET request to popular movie endpoint', () async {
      //arrange
      setUpMockClientSuccess200(
        Urls.popularMovies,
        'test/helpers/movie/dummy_response/popular_movies.json',
      );
      //act
      await remoteDataSource.getPopularMovies();
      //assert
      verify(mockClient.get(
        Uri.parse(Urls.popularMovies),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('''should return a list of movie object when status 
    of get request is 200''', () async {
      //arrange
      setUpMockClientSuccess200(Urls.popularMovies,
          'test/helpers/movie/dummy_response/popular_movies.json');
      //act
      final result = await remoteDataSource.getPopularMovies();
      //assert
      expect(result, equals(testMovieList));
    });

    test('''should throw ServerException in case the connection to 
    Urls.popularMovies is not successful''', () {
      //arrange
      setUpMockClientFailure404(Urls.popularMovies);
      //act
      final call = remoteDataSource.getPopularMovies;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('Search Movies', () {
    const testQuery = 'query';
    test('should perform a GET request to Urls.searchMovies endpoint',
        () async {
      //arrange
      setUpMockClientSuccess200(
        Urls.searchMovies(testQuery),
        'test/helpers/movie/dummy_response/search_movies.json',
      );
      //act
      await remoteDataSource.searchMovies(testQuery);
      //assert
      verify(mockClient.get(
        Uri.parse(Urls.searchMovies(testQuery)),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('''should return a list of movie object when status 
    of get request is 200''', () async {
      //arrange
      setUpMockClientSuccess200(Urls.searchMovies(testQuery),
          'test/helpers/movie/dummy_response/search_movies.json');
      //act
      final result = await remoteDataSource.searchMovies(testQuery);
      //assert
      expect(result, equals(testMovieList));
    });

    test('''should throw ServerException in case the connection to 
    Urls.popularMovies is not successful''', () {
      //arrange
      setUpMockClientFailure404(Urls.searchMovies(testQuery));
      //act
      final call = remoteDataSource.searchMovies;
      //assert
      expect(
          () => call(testQuery), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
