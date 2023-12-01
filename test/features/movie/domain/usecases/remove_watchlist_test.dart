import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/movies/domain/usecases/remove_watchlist.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import '../../../../helpers/movie/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late RemoveWatchlist removeWatchlist;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    removeWatchlist = RemoveWatchlist(mockMovieRepository);
  });

  test('should remove watchlist movie via the repository', () async {
    //arrange
    when(mockMovieRepository.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('REMOVE MOVIE TO WATCHLIST'));
    //act
    final result = await removeWatchlist(testMovieDetail);
    //assert
    verify(mockMovieRepository.removeWatchlist(testMovieDetail));
    expect(result, const Right('REMOVE MOVIE TO WATCHLIST'));
  });
}
