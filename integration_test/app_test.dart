import 'package:movid/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'robots/home_robot.dart';
import 'robots/movie_detail_robot.dart';
import 'robots/popular_movies_robot.dart';
import 'robots/search_robot.dart';
import 'robots/top_rated_movies_robot.dart';
import 'robots/watclist_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  HomeRobot homeRobot;
  WatchlistRobot watchlistRobot;
  PopularMoviesRobot popularMoviesRobot;
  TopRatedMoviesRobot topRatedMoviesRobot;
  MovieDetailRobot movieDetailRobot;
  SearchRobot searchRobot;

  group('end-to-end test', () {
    testWidgets(
      'whole app',
      (WidgetTester tester) async {
        app.main();

        await tester.pumpAndSettle();

        homeRobot = HomeRobot(tester);
        watchlistRobot = WatchlistRobot(tester);
        popularMoviesRobot = PopularMoviesRobot(tester);
        topRatedMoviesRobot = TopRatedMoviesRobot(tester);
        movieDetailRobot = MovieDetailRobot(tester);
        searchRobot = SearchRobot(tester);

        // See popular movies
        await homeRobot.scrollMoviePage();
        await homeRobot.clickSeePopularMovies();
        await popularMoviesRobot.scrollThePage();
        await popularMoviesRobot.scrollThePage(scrollUp: true);
        await popularMoviesRobot.goBack();

        // See top rated movies
        await homeRobot.clickSeeTopRatedMovies();
        await topRatedMoviesRobot.scrollThePage();
        await topRatedMoviesRobot.scrollThePage(scrollUp: true);
        await topRatedMoviesRobot.goBack();

        // Navigate to tv main page
        await homeRobot.scrollMoviePage(scrollUp: true);
        await homeRobot.clickNavigationDrawerButton();
        await homeRobot.clickTvListTile();

        // Navigate to movie main page
        await homeRobot.scrollTvPage(scrollUp: true);
        await homeRobot.clickNavigationDrawerButton();
        await homeRobot.clickMovieListTile();

        // Navigate from movie main page to detail page
        await homeRobot.clickMovieItem();
        await homeRobot.clickSeeMoreMovieDetail();
        await movieDetailRobot.scrollThePage();
        await movieDetailRobot.scrollThePage(scrollUp: true);
        await movieDetailRobot.clickMovieToWatchlistButton();
        await movieDetailRobot.goBack();
        await homeRobot.closeMovieMinimalDetail();

        // Navigate to tv main page
        await homeRobot.clickNavigationDrawerButton();
        await homeRobot.clickTvListTile();

        //TODO: Test for navigating from tv main page to detail page

        // Navigate to watchlist page
        await homeRobot.clickNavigationDrawerButton();
        await homeRobot.clickWatchlistListTile();
        await watchlistRobot.clickTvWatchlistTab();
        await watchlistRobot.clickMovieWatchlistTab();
        await watchlistRobot.goBack();
        await homeRobot.clickMovieListTile();

        // Navigate to search
        // Search a movie
        await homeRobot.clickSearchButton();
        await searchRobot.openFilterDialog();
        await searchRobot.selectFilterTv();
        await searchRobot.enterSearchQuery('arcane');

        // Search a tv
        await searchRobot.openFilterDialog();
        await searchRobot.selectFilterMovie();
        await searchRobot.enterSearchQuery('spider');
        await searchRobot.goBack();

        // Navigate to about page
        await homeRobot.clickNavigationDrawerButton();
        await homeRobot.clickAboutListTile();
      },
    );
  });
}
