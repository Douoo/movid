import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/search/domain/usecases/search_movie.dart';
import 'package:movid/features/search/presentation/provider/movie_search_provider.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import 'movie_search_provider_test.mocks.dart';

@GenerateMocks([
  SearchMovie,
])
void main() {
  late MockSearchMovie mockSearchMovie;
  late MovieSearchProvider notifier;

  setUp(() {
    mockSearchMovie = MockSearchMovie();
    notifier = MovieSearchProvider(searchMovie: mockSearchMovie);
  });

  test('should change the state from loading to loaded when it has loaded data',
      () async {
    //arrange
    when(mockSearchMovie('query'))
        .thenAnswer((_) async => Right(testMovieList));
    //act
    await notifier.searchForMovie('query');
    //assert
    expect(notifier.searchState, RequestState.loaded);
  });
  test(
      'should populate the list of data to a list object when data is received successfully',
      () async {
    //arrange
    when(mockSearchMovie('query'))
        .thenAnswer((_) async => Right(testMovieList));
    //act
    await notifier.searchForMovie('query');
    //assert
    expect(notifier.searchState, RequestState.loaded);
    expect(notifier.movies, testMovieList);
  });
  test(
      '''should change the state obj to RequestState.error if call to usecase was 
      not successful''', () async {
    //arrange
    when(mockSearchMovie('query'))
        .thenAnswer((_) async => const Left(ServerFailure()));
    //act
    await notifier.searchForMovie('query');
    //assert
    expect(notifier.searchState, RequestState.error);
    expect(notifier.message, 'Something went wrong while fetching data');
  });
}
