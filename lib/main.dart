import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movid/core/presentation/pages/about_page.dart';
import 'package:movid/core/presentation/pages/watchlist_page.dart';
import 'package:movid/features/movies/data/models/movie_table.dart';
import 'package:movid/features/movies/presentation/pages/movie_detail_page.dart';
import 'package:movid/features/movies/presentation/pages/popular_movies_page.dart';
import 'package:movid/features/movies/presentation/pages/top_rated_movies_page.dart';
import 'package:hive/hive.dart';
import 'package:movid/core/presentation/pages/home_page.dart';
import 'package:movid/core/presentation/provider/home_provider.dart';
import 'package:movid/core/styles/colors.dart';
import 'package:movid/features/movies/presentation/provider/movie_detail_provider.dart';
import 'package:movid/features/movies/presentation/provider/movie_images_provider.dart';
import 'package:movid/features/movies/presentation/provider/movie_list_provider.dart';
import 'package:movid/features/movies/presentation/provider/popular_movies_provider.dart';
import 'package:movid/features/movies/presentation/provider/top_rated_movies_provider.dart';
import 'package:movid/features/movies/presentation/provider/watchlist_movies_provider.dart';
import 'package:movid/features/search/presentation/pages/search_movie_page.dart';
import 'package:movid/features/search/presentation/provider/movie_search_provider.dart';
import 'package:movid/injection.dart' as di;
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieDataAdapter(), override: true);

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ///Home Content Type Provider
        ChangeNotifierProvider(
          create: (_) => di.locator<HomeProvider>(),
        ),

        ///Movie Providers
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieImagesProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieWatchlistProvider>(),
        ),

        ///Search movie provider
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movid',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          colorScheme: kColorScheme.copyWith(
            secondary: Colors.redAccent,
          ),
          useMaterial3: true,
        ),
        initialRoute: HomePage.route,
        routes: {
          HomePage.route: (context) => const HomePage(),
          PopularMoviesPage.route: (context) => const PopularMoviesPage(),
          TopRatedMoviesPage.route: (context) => const TopRatedMoviesPage(),
          MovieDetailPage.route: (context) => const MovieDetailPage(),
          MovieSearchPage.routeName: (context) => const MovieSearchPage(),
          WatchlistPage.route: (context) => const WatchlistPage(),
          AboutPage.route: (context) => const AboutPage(),
        },
      ),
    );
  }
}
