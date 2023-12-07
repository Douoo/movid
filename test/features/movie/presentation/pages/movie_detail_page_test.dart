import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/entities/movie.dart';
import 'package:movid/features/movies/presentation/pages/movie_detail_page.dart';
import 'package:movid/features/movies/presentation/provider/movie_detail_provider.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/movie/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([
  MovieDetailProvider,
])
void main() {
  late MockMovieDetailProvider mockProvider;

  setUp(() {
    mockProvider = MockMovieDetailProvider();
  });

  Widget makeTestableWidget(body) {
    return ChangeNotifierProvider<MovieDetailProvider>.value(
      value: mockProvider,
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
      'watchlist button should show + icon when movie is not added to watchlist',
      (widgetTester) async {
    //arrange
    when(mockProvider.state).thenReturn(RequestState.loaded);
    when(mockProvider.movieDetail).thenReturn(testMovieDetail);
    when(mockProvider.isAddedToWatchlist).thenReturn(false);
    when(mockProvider.recommendedMoviesState).thenReturn(RequestState.loaded);
    when(mockProvider.recommendedMovies).thenReturn(<Movie>[]);

    //act
    final watchlistButton = find.byIcon(Icons.add);

    await widgetTester.pumpWidget(makeTestableWidget(const MovieDetailPage(
      movieId: 1,
    )));
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
    //assert
    expect(watchlistButton, findsOneWidget);
  });
  testWidgets(
      'watchlist button should show check icon when movie is added to watchlist',
      (widgetTester) async {
    //arrange
    when(mockProvider.state).thenReturn(RequestState.loaded);
    when(mockProvider.movieDetail).thenReturn(testMovieDetail);
    when(mockProvider.isAddedToWatchlist).thenReturn(true);
    when(mockProvider.recommendedMoviesState).thenReturn(RequestState.loaded);
    when(mockProvider.recommendedMovies).thenReturn(<Movie>[]);

    //act
    final watchlistButton = find.byIcon(Icons.check);

    await widgetTester.pumpWidget(makeTestableWidget(const MovieDetailPage(
      movieId: 1,
    )));
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
    //assert
    expect(watchlistButton, findsOneWidget);
  });
  testWidgets(
      'should display a flutter toast when movie is added to/removed from watchlist',
      (widgetTester) async {
    //arrange
    when(mockProvider.state).thenReturn(RequestState.loaded);
    when(mockProvider.movieDetail).thenReturn(testMovieDetail);
    when(mockProvider.recommendedMoviesState).thenReturn(RequestState.loaded);
    when(mockProvider.recommendedMovies).thenReturn(<Movie>[]);
    when(mockProvider.isAddedToWatchlist).thenReturn(false);
    when(mockProvider.watchlistMessage).thenReturn('Added to watchlist');

    //act
    final watchlistButton = find.byKey(const Key('movieToWatchlist'));

    await widgetTester.pumpWidget(
      makeTestableWidget(
        const MovieDetailPage(
          movieId: 1,
        ),
      ),
      const Duration(milliseconds: 500),
    );
    expect(find.byIcon(Icons.add), findsOneWidget);

    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
    await widgetTester.tap(watchlistButton);
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
    //assert
    expect(find.text('Added to watchlist'), equals(findsNothing));
  });
  testWidgets(
      'should show an alert dialog in case a movie is not added to watchlist successfully',
      (widgetTester) async {
    //arrange
//arrange
    when(mockProvider.state).thenReturn(RequestState.loaded);
    when(mockProvider.movieDetail).thenReturn(testMovieDetail);
    when(mockProvider.recommendedMoviesState).thenReturn(RequestState.loaded);
    when(mockProvider.recommendedMovies).thenReturn(<Movie>[]);
    when(mockProvider.isAddedToWatchlist).thenReturn(false);
    when(mockProvider.watchlistMessage)
        .thenReturn('Failed to add movie to watchlist');
    //act
    final watchlistButton = find.byKey(const Key('movieToWatchlist'));

    await widgetTester.pumpWidget(
      makeTestableWidget(
        const MovieDetailPage(
          movieId: 1,
        ),
      ),
      const Duration(milliseconds: 500),
    );
    expect(find.byIcon(Icons.add), findsOneWidget);

    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
    await widgetTester.tap(watchlistButton);
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
    //assert
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed to add movie to watchlist'), findsOneWidget);
  });
}
