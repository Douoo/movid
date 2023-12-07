import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/entities/movie.dart';
import 'package:movid/features/search/presentation/pages/search_movie_page.dart';
import 'package:movid/features/search/presentation/provider/movie_search_provider.dart';
import 'package:provider/provider.dart';

import 'search_movie_page_test.mocks.dart';

@GenerateMocks([
  MovieSearchProvider,
])
void main() {
  late MockMovieSearchProvider mockProvider;

  setUp(() {
    mockProvider = MockMovieSearchProvider();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieSearchProvider>.value(
      value: mockProvider,
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
      'page should display circular progress bar at center when searching data',
      (widgetTester) async {
    //arrange
    when(mockProvider.searchState).thenReturn(RequestState.loading);
    when(mockProvider.movies).thenReturn(<Movie>[]);

    //act
    final progressBar = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(
      makeTestableWidget(const MovieSearchPage()),
    );

    expect(find.text('Search Movie'), findsOneWidget);
    expect(find.byKey(const Key('enterMovieQuery')), findsOneWidget);

    await widgetTester.enterText(
      find.byKey(const Key('enterMovieQuery')),
      'Test Movie',
    );

    await widgetTester.pump();

    //assert
    expect(progressBar, findsOneWidget);
  });
}
