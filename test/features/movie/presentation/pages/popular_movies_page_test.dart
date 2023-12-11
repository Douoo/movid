import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/presentation/pages/popular_movies_page.dart';
import 'package:movid/features/movies/presentation/provider/popular_movies_provider.dart';
import 'package:provider/provider.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([
  PopularMoviesProvider,
])
void main() {
  late MockPopularMoviesProvider mockProvider;

  setUp(() {
    mockProvider = MockPopularMoviesProvider();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularMoviesProvider>.value(
      value: mockProvider,
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
      'page should display circular progress bar at center when loading data',
      (widgetTester) async {
    //arrange
    when(mockProvider.state).thenReturn(RequestState.loading);

    //act
    final centerWidget = find.byType(Center);
    final progressBar = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(
      makeTestableWidget(const PopularMoviesPage()),
    );

    //assert
    expect(centerWidget, findsOneWidget);
    expect(progressBar, findsOneWidget);
  });

  testWidgets('page should display list view when data is loaded',
      (widgetTester) async {
    //arrange
    when(mockProvider.state).thenReturn(RequestState.loaded);
    when(mockProvider.movies).thenReturn([]);
    //act
    final listView = find.byType(ListView);

    await widgetTester
        .pumpWidget(makeTestableWidget(const PopularMoviesPage()));
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
    //assert
    expect(listView, findsOneWidget);
  });

  testWidgets(
      'page should display error message when the RequestState is error',
      (widgetTester) async {
    //arrange
    when(mockProvider.state).thenReturn(RequestState.error);
    when(mockProvider.message)
        .thenReturn('Something went wrong while fetching data');

    //act
    final errorTextWidget = find.byKey(const Key('error_message'));
    await widgetTester
        .pumpWidget(makeTestableWidget(const PopularMoviesPage()));
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
    //assert
    expect(errorTextWidget, findsOneWidget);
  });
}
