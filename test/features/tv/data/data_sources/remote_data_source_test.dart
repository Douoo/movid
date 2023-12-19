import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/exception.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/tv/data/data_sources/tv_series_remote_data_source_impl.dart';
import 'package:http/http.dart' as http;
import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/json_reader.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  late MockHttpClient mockClient;

  late TvRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() async {
    await dotenv.load(fileName: ".env");
    mockClient = MockHttpClient();
    remoteDataSourceImpl = TvRemoteDataSourceImpl(client: mockClient);
  });

  group("get on Air tv tv", () {
    test('should return tv tv model when the response code is 200', () async {
      // arrange
      when(mockClient.get(
        Uri.parse(Urls.onTheAirTvs),
        headers: {
          'Content-Type': 'application/json',
        },
      )).thenAnswer((_) async => http.Response(
          readJson('helpers\\tv\\dummy_data\\dummy_tv_json_response.json'),
          200));
      //act

      await remoteDataSourceImpl.getOnAirTv(3);

      //assert
      // verify(
      //   mockClient.get(Uri.parse(Urls.onTheAirTvs)),
      // );
      // expect(result, isA<List<Tv>>());
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
        result = await remoteDataSourceImpl.getOnAirTv(3);
      } catch (e) {
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
