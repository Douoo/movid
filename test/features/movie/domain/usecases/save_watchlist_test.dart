import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/movies/domain/usecases/save_watchlist.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import '../../../../helpers/movie/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late SaveWatchlist saveWatchlist;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    saveWatchlist = SaveWatchlist(mockMovieRepository);
  });

  test('should save watchlist movie via the repository', () async {
    //arrange
    when(mockMovieRepository.saveWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('SAVE MOVIE TO WATCHLIST'));
    //act
    final result = await saveWatchlist(testMovieDetail);
    //assert
    verify(mockMovieRepository.saveWatchlist(testMovieDetail));
    expect(result, const Right('SAVE MOVIE TO WATCHLIST'));
  });
}
