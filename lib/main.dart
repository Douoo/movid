import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movid/core/core.dart';
import 'package:movid/features/movies/data/models/movie_table.dart';
import 'package:hive/hive.dart';
import 'package:movid/features/movies/movies.dart';
import 'package:movid/features/search/presentation/pages/search_tv_page.dart';
import 'package:movid/features/search/presentation/provider/tv_search_provider.dart';
import 'package:movid/features/series/data/model/series_data.dart';
import 'package:movid/features/series/presentation/pages/detail_tv_series_page.dart';
import 'package:movid/features/series/presentation/pages/popular_series_page.dart';
import 'package:movid/features/series/presentation/pages/top_rated_series_page.dart';
import 'package:movid/features/series/presentation/provider/popular_series_provider.dart';
import 'package:movid/features/series/presentation/provider/seasons_provider.dart';
import 'package:movid/features/series/presentation/provider/series_detail_provider.dart';
import 'package:movid/features/series/presentation/provider/series_images_provider.dart';
import 'package:movid/features/series/presentation/provider/series_list_provider.dart';
import 'package:movid/features/series/presentation/provider/series_watch_list_provider.dart';
import 'package:movid/features/series/presentation/provider/top_rated_series_provider.dart';

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
  Hive.registerAdapter(TvDataAdapter(), override: true);

  await di.init();
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
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

        ///Tv providers
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvImagesProvider>(),
        ),

        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailProvider>(),
        ),

        ChangeNotifierProvider(
          create: (_) => di.locator<TvWatchListProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeasonsProvider>(),
        ),

        ///Search movie provider
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchProvider>(),
        ),

        ///Search tv provider
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchProvider>(),
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
          PopularTvPage.route: (context) => const PopularTvPage(),
          TopRatedTvPage.route: (context) => const TopRatedTvPage(),
          HomePage.route: (context) => const HomePage(),
          PopularMoviesPage.route: (context) => const PopularMoviesPage(),
          TopRatedMoviesPage.route: (context) => const TopRatedMoviesPage(),
          MovieDetailPage.route: (context) => const MovieDetailPage(),
          MovieSearchPage.routeName: (context) => const MovieSearchPage(),
          WatchlistPage.route: (context) => const WatchlistPage(),
          AboutPage.route: (context) => const AboutPage(),
          DetailTvPage.route: (context) => const DetailTvPage(),
          SearchTvPage.routeName: (context) => const SearchTvPage(),
        },
      ),
    );
  }
}
