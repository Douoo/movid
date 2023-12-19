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
import 'package:movid/features/search/presentation/provider/tv_search_provider.dart';
import 'package:movid/features/tv/data/data_sources/tv_series_local_data_source.dart';
import 'package:movid/features/tv/data/data_sources/tv_series_remote_data_source_impl.dart';
import 'package:movid/features/tv/data/repository/series_repository_impl.dart';
import 'package:movid/features/tv/domain/repository/series_repository.dart';
import 'package:movid/features/tv/domain/usecases/add_series_to_watchlist.dart';
import 'package:movid/features/tv/domain/usecases/get_movie_watchlist_status.dart';
import 'package:movid/features/tv/domain/usecases/get_watchlist_series.dart';
import 'package:movid/features/tv/domain/usecases/remove_watchlist_series.dart';
import 'package:movid/features/tv/domain/usecases/series/get_on_air_tvs.dart';
import 'package:movid/features/tv/domain/usecases/series/get_popular_tvs.dart';
import 'package:movid/features/tv/domain/usecases/series/get_series_images.dart';
import 'package:movid/features/tv/domain/usecases/series/get_top_rated_tvs.dart';
import 'package:movid/features/tv/domain/usecases/series/get_tv_detail.dart';
import 'package:movid/features/tv/domain/usecases/series/get_tv_recommendations.dart';
import 'package:movid/features/tv/domain/usecases/series/get_tv_season_episodes.dart';
import 'package:movid/features/tv/domain/usecases/series/search_tvs.dart';

import 'package:movid/features/movies/presentation/provider/watchlist_movies_provider.dart';
import 'package:movid/features/search/domain/usecases/search_movie.dart';
import 'package:movid/features/search/presentation/provider/movie_search_provider.dart';
import 'package:movid/features/tv/series.dart';

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

  ///Tv tv provider
  locator.registerFactory(
    () => TvListProvider(
        getDetailTvsUseCase: locator(),
        getOnAirTvsUseCase: locator(),
        getPopularTvsUseCase: locator(),
        getTopRatedTvsUseCase: locator()),
  );

  locator.registerFactory(() => TvImagesProvider(getTvImages: locator()));
  locator.registerFactory(
      () => PopularTvProvider(getPopularTvsUseCase: locator()));
  locator.registerFactory(
      () => TopRatedTvProvider(getTopRatedTvsUseCase: locator()));
  locator.registerFactory(() => TvDetailProvider(
        getDetailTvsUseCase: locator(),
        addTvsToWatchListUseCase: locator(),
        removeTvsFromWatchListUseCase: locator(),
        getRecommendedTvsUseCase: locator(),
        getTvWatchListStatus: locator(),
      ));

  locator.registerFactory(() => TvSearchProvider(searchTv: locator()));

  locator.registerFactory(
      () => TvWatchListProvider(getWatchListTvsUseCase: locator()));

  locator.registerFactory(() => SeasonEpisodesProvider(
        getTvSeasonEpisodes: locator(),
      ));

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
  locator.registerLazySingleton(() => GetOnAirTvsUseCase(tv: locator()));
  locator.registerLazySingleton(() => GetPopularTvsUseCase(tv: locator()));
  locator.registerLazySingleton(() => GetTvSeasonEpisodes(series: locator()));

  locator.registerLazySingleton(() => GetTopRatedTvsUseCase(tv: locator()));
  locator.registerLazySingleton(() => GetDetailTvsUseCase(tv: locator()));
  locator.registerLazySingleton(() => GetTvImages(locator()));
  locator.registerLazySingleton(() => GetTvWatchListStatus(locator()));
  locator.registerLazySingleton(
      () => RemoveTvsFromWatchListUseCase(repository: locator()));
  locator.registerLazySingleton(
      () => AddTvsToWatchListUseCase(repository: locator()));
  locator.registerLazySingleton(() => GetWatchListTvsUseCase(tv: locator()));
  locator.registerLazySingleton(() => GetRecommendedTvsUseCase(tv: locator()));

  ///Search tv
  locator.registerLazySingleton(() => SearchTvsUseCase(tv: locator()));

  //******** Repository **********//
  ///Movie repo and its implementations
  locator.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        networkConnection: locator(),
      ));

  ///Tv tv
  locator.registerLazySingleton<TvRepository>(() => TvRepositoryImpl(
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
      () => MovieLocalDataSourceImpl());

  ///Tv tv
  locator.registerLazySingleton<TvRemoteDataSource>(
    () => TvRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<TvLocalDataSource>(
    () => TvLocalDataSourceImpl(),
  );

  //******** External Plugin **********//
  // locator.registerLazySingleton(() => seriesWatchListBox);
  locator.registerLazySingleton(() => InternetConnectionChecker());
  locator.registerLazySingleton(() => http.Client());
}
