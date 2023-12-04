import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movid/features/series/presentation/pages/home.dart';
import 'package:hive/hive.dart';
import 'package:movid/core/presentation/pages/home_page.dart';
import 'package:movid/core/presentation/provider/home_provider.dart';
import 'package:movid/core/styles/colors.dart';
import 'package:movid/features/movies/presentation/provider/movie_detail_provider.dart';
import 'package:movid/features/movies/presentation/provider/movie_images_provider.dart';
import 'package:movid/features/movies/presentation/provider/movie_list_provider.dart';
import 'package:movid/features/movies/presentation/provider/popular_movies_provider.dart';
import 'package:movid/features/movies/presentation/provider/top_rated_movies_provider.dart';
import 'package:movid/injection.dart' as di;
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // await Hive.openBox('watchlist');
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
        home: const HomePage(),
        initialRoute: HomePage.route,
        routes: {},
      ),
    );
  }
}
