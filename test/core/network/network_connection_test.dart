import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/network/network_connection.dart';
import '../../helpers/global_test_helpers.mocks.dart';

void main() {
  late MockInternetConnectionChecker mockConnection;
  late NetworkConnectionImpl networkConnection;
  bool testHasConnection = true;

  setUp(() {
    mockConnection = MockInternetConnectionChecker();
    networkConnection =
        NetworkConnectionImpl(connectionChecker: mockConnection);
  });

  group('Connection available', () {
    test('should forward the call to InternetConnectionChecker.hasConnection',
        () async {
      //arrange
      when(mockConnection.hasConnection)
          .thenAnswer((_) async => testHasConnection);
      //act
      final result = await networkConnection.isAvailable;
      //assert
      expect(result, testHasConnection);
    });
  });

  group('Connection unavailable', () {
    test('should forward the call to InternetConnectionChecker.hasConnection',
        () async {
      //arrange
      when(mockConnection.hasConnection)
          .thenAnswer((_) async => !testHasConnection);
      //act
      final result = await networkConnection.isAvailable;
      //assert
      expect(result, !testHasConnection);
    });
  });
}
