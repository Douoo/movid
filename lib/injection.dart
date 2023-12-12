import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movid/core/network/network_connection.dart';
import 'package:movid/core/presentation/provider/home_provider.dart';
import 'package:movid/features/movies/data/data_sources/movie_local_data_source.dart';
import 'package:movid/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movid/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:movid/features/movies/domain/repositories/movie_repository.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_images.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_watchlist_status.dart';
import 'package:movid/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movid/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:movid/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movid/features/movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movid/features/movies/domain/usecases/remove_watchlist.dart';
import 'package:movid/features/movies/domain/usecases/save_watchlist.dart';
import 'package:movid/features/movies/presentation/provider/movie_detail_provider.dart';
import 'package:movid/features/movies/presentation/provider/movie_images_provider.dart';
import 'package:movid/features/movies/presentation/provider/movie_list_provider.dart';
import 'package:movid/features/movies/presentation/provider/popular_movies_provider.dart';
import 'package:movid/features/movies/presentation/provider/top_rated_movies_provider.dart';
import 'package:movid/features/series/data/data_sources/local/tv_series_local_data_source.dart';
import 'package:movid/features/series/data/data_sources/tv_series_remote_data_source_impl.dart';
import 'package:movid/features/series/data/repository/series_repository_impl.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';
import 'package:movid/features/series/domain/usecases/add_series_to_watchlist.dart';
import 'package:movid/features/series/domain/usecases/get_movie_watchlist_status.dart';
import 'package:movid/features/series/domain/usecases/get_watchlist_series.dart';
import 'package:movid/features/series/domain/usecases/remove_watchlist_series.dart';
import 'package:movid/features/series/domain/usecases/series/get_on_air_tvs.dart';
import 'package:movid/features/series/domain/usecases/series/get_popular_tvs.dart';
import 'package:movid/features/series/domain/usecases/series/get_series_images.dart';
import 'package:movid/features/series/domain/usecases/series/get_top_rated_tvs.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_detail.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_recommendations.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_seasons.dart';
import 'package:movid/features/series/presentation/provider/popular_series_provider.dart';
import 'package:movid/features/series/presentation/provider/seasons_provider.dart';
import 'package:movid/features/series/presentation/provider/series_detail_provider.dart';
import 'package:movid/features/series/presentation/provider/series_images_provider.dart';
import 'package:movid/features/series/presentation/provider/series_list_provider.dart';
import 'package:movid/features/series/presentation/provider/series_watch_list_provider.dart';
import 'package:movid/features/series/presentation/provider/top_rated_series_provider.dart';
import 'package:movid/features/movies/presentation/provider/watchlist_movies_provider.dart';
import 'package:movid/features/search/domain/usecases/search_movie.dart';
import 'package:movid/features/search/presentation/provider/movie_search_provider.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //******** Core Dependency Injection **********//
  locator.registerLazySingleton<NetworkConnection>(
    () => NetworkConnectionImpl(
      connectionChecker: locator(),
    ),
  );

  //******** Providers **********//
  //Home Content Type Provider
  locator.registerFactory(() => HomeProvider());

  ///Movie provider
  locator.registerFactory(() => MovieDetailProvider(
        getMovieDetail: locator(),
        getMovieRecommendations: locator(),
        getMovieWatchlistStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));
  locator.registerFactory(() => MovieImagesProvider(
        getMovieImages: locator(),
      ));
  locator.registerFactory(() => MovieListProvider(
        getNowPlayingMovies: locator(),
        getPopularMovies: locator(),
        getTopRatedMovies: locator(),
      ));
  locator.registerFactory(() => PopularMoviesProvider(
        getPopularMovies: locator(),
      ));
  locator.registerFactory(() => TopRatedMoviesProvider(
        getTopRatedMovies: locator(),
      ));

  ///Tv Series provider
  locator.registerFactory(
    () => TvSeriesListProvider(
        getDetailTvsUseCase: locator(),
        getOnAirTvsUseCase: locator(),
        getPopularTvsUseCase: locator(),
        getTopRatedTvsUseCase: locator()),
  );

  locator.registerFactory(
      () => TvSeriesImagesProvider(getSeriesImages: locator()));
  locator.registerFactory(
      () => PopularTvSeriesProvider(getPopularTvsUseCase: locator()));
  locator.registerFactory(
      () => TopRatedTvSeriesProvider(getTopRatedTvsUseCase: locator()));
  locator.registerFactory(() => TvSeriesDetailProvider(
        getDetailTvsUseCase: locator(),
        addTvsToWatchListUseCase: locator(),
        removeTvsFromWatchListUseCase: locator(),
        getRecommendedTvsUseCase: locator(),
        getSeriesWatchListStatus: locator(),
      ));
  locator.registerFactory(
    () => MovieSearchProvider(
      searchMovie: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieWatchlistProvider(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
      () => TvSeriesWatchListProvider(getWatchListTvsUseCase: locator()));

  locator
      .registerFactory(() => SeasonsProvider(getTvsSeasonsUseCase: locator()));

  //******** Usecases **********//
  /// Movie related
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieImages(locator()));
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetMovieWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));

  ///Search movies
  locator.registerLazySingleton(() => SearchMovie(locator()));

  ///Tv Series
  locator.registerLazySingleton(() => GetOnAirTvsUseCase(series: locator()));
  locator.registerLazySingleton(() => GetPopularTvsUseCase(series: locator()));
  locator.registerLazySingleton(() => GetTvsSeasonsUseCase(series: locator()));

  locator.registerLazySingleton(() => GetTopRatedTvsUseCase(series: locator()));
  locator.registerLazySingleton(() => GetDetailTvsUseCase(series: locator()));
  locator.registerLazySingleton(() => GetSeriesImages(locator()));
  locator.registerLazySingleton(() => GetSeriesWatchListStatus(locator()));
  locator.registerLazySingleton(
      () => RemoveTvsFromWatchListUseCase(series: locator()));
  locator
      .registerLazySingleton(() => AddTvsToWatchListUseCase(series: locator()));
  locator
      .registerLazySingleton(() => GetWatchListTvsUseCase(series: locator()));
  locator
      .registerLazySingleton(() => GetRecommendedTvsUseCase(series: locator()));

  //******** Repository **********//
  ///Movie repo and its implementations
  locator.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        networkConnection: locator(),
      ));

  ///Tv Series
  locator
      .registerLazySingleton<TvSeriesRepository>(() => TvSeriesRepositoryImpl(
            connection: locator(),
            remoteDataSource: locator(),
            localDataSource: locator(),
          ));

  //******** Local and Remote Data Sources **********//
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(
            client: locator(),
          ));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(
            box: locator(),
          ));

  ///Tv Series
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  final seriesWatchListBox = await Hive.openBox('tvWatchList');
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
    () => TvSeriesLocalDataSourceImpl(
      watchListBox: seriesWatchListBox,
    ),
  );
  //******** External Plugin **********//
  final watchlistBox = await Hive.openBox('watchlist');

  locator.registerLazySingleton(() => watchlistBox);
  // locator.registerLazySingleton(() => seriesWatchListBox);
  locator.registerLazySingleton(() => InternetConnectionChecker());
  locator.registerLazySingleton(() => http.Client());
}
