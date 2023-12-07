import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/entities/movie.dart';
import 'package:movid/features/movies/presentation/pages/top_rated_movies_page.dart';
import 'package:movid/features/movies/presentation/provider/top_rated_movies_provider.dart';
import 'package:provider/provider.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([
  TopRatedMoviesProvider,
])
void main() {
  late MockTopRatedMoviesProvider mockProvider;

  setUp(() {
    mockProvider = MockTopRatedMoviesProvider();
  });

  Widget _makeTestableWidget(body) {
    return ChangeNotifierProvider<TopRatedMoviesProvider>.value(
      value: mockProvider,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('''should show circular progress bar at the center of 
  the page when data is loading''', (widgetTester) async {
    //arrange
    when(mockProvider.state).thenReturn(RequestState.loading);

    //act
    final centerWidget = find.byType(Center);
    final progressBar = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(
      _makeTestableWidget(
        const TopRatedMoviesPage(),
      ),
    );
    //assert
    expect(centerWidget, findsOneWidget);
    expect(progressBar, findsOneWidget);
  });

  testWidgets('should render a list view when data is loaded',
      (widgetTester) async {
    //arrange
    when(mockProvider.state).thenReturn(RequestState.loaded);
    when(mockProvider.movies).thenReturn(<Movie>[]);

    //act
    final listView = find.byType(ListView);

    await widgetTester
        .pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
    //assert
    expect(listView, findsOneWidget);
  });
  testWidgets(
      'should return a text widget with an error text when data fails to load',
      (widgetTester) async {
    //arrange
    when(mockProvider.state).thenReturn(RequestState.error);
    when(mockProvider.message)
        .thenReturn('Something went wrong while fetching data');
    //act
    final errorTextWidget = find.byKey(Key('error_message'));

    await widgetTester.pumpWidget(
      _makeTestableWidget(
        const TopRatedMoviesPage(),
      ),
    );
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
    //assert
    expect(errorTextWidget, findsOneWidget);
  });
}
