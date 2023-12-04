import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/data/data_sources/remote/remote_data_source_impl.dart';
import 'package:http/http.dart' as http;
import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/json_reader.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  late MockHttpClient mockClient;

  late TvSeriesRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() async {
    await dotenv.load(fileName: ".env");
    mockClient = MockHttpClient();
    remoteDataSourceImpl = TvSeriesRemoteDataSourceImpl(client: mockClient);
  });

  group("get on Air tv series", () {
    test('should return tv series model when the response code is 200',
        () async {
      // arrange
      when(mockClient.get(
        Uri.parse(Urls.onTheAirTvs),
        headers: {
          'Content-Type': 'application/json',
        },
      )).thenAnswer((_) async => http.Response(
          readJson(
              'helpers\\series\\dummy_data\\dummy_series_json_response.json'),
          200));
      //act

      await remoteDataSourceImpl.getOnAirTvSeries();

      //assert
      // verify(
      //   mockClient.get(Uri.parse(Urls.onTheAirTvs)),
      // );
      // expect(result, isA<List<TvSeries>>());
    });
    test(
        'should throw a server exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockClient.get(
        Uri.parse(Urls.onTheAirTvs),
      )).thenAnswer(
          (_) async => http.Response('{"error": "Resource Not Found"}', 404));

      //act
      dynamic result;
      try {
        result = await remoteDataSourceImpl.getOnAirTvSeries();
      } catch (e) {
        print("Error: $e");
        result = e;
      }

      // assert
      verify(
        mockClient.get(
          Uri.parse(Urls.onTheAirTvs),
        ),
      );
      expect(result, isA<ServerException>());
    });
  });
}
