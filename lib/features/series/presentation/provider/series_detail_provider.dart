import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/usecases/add_series_to_watchlist.dart';
import 'package:movid/features/series/domain/usecases/get_movie_watchlist_status.dart';
import 'package:movid/features/series/domain/usecases/remove_watchlist_series.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_detail.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_recommendations.dart';

class TvSeriesDetailProvider extends ChangeNotifier {
  static const watchListAddSuccessMessage = 'Added to watchList';
  static const watchListRemoveSuccessMessage = 'Removed from watchList';

  final GetDetailTvsUseCase getDetailTvsUseCase;
  final GetRecommendedTvsUseCase getRecommendedTvsUseCase;
  final GetSeriesWatchListStatus getSeriesWatchListStatus;
  final AddTvsToWatchListUseCase addTvsToWatchListUseCase;
  final RemoveTvsFromWatchListUseCase removeTvsFromWatchListUseCase;
  TvSeriesDetailProvider({
    required this.getDetailTvsUseCase,
    required this.addTvsToWatchListUseCase,
    required this.getRecommendedTvsUseCase,
    required this.getSeriesWatchListStatus,
    required this.removeTvsFromWatchListUseCase,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  RequestState _recommendedSeriesState = RequestState.empty;
  RequestState get recommendedSeriesState => _recommendedSeriesState;
  late SeriesDetail _seriesDetail;
  SeriesDetail get seriesDetail => _seriesDetail;

  late List<TvSeries> _recommendedTvSeries;
  List<TvSeries> get recommendedTvSeries => _recommendedTvSeries;

  bool _isAddedToWatchList = false;
  bool get isAddedToWatchList => _isAddedToWatchList;

  String _message = '';
  String get message => _message;

  String _watchListMessage = '';
  String get watchListMessage => _watchListMessage;

  Future<void> fetchDetailTvSeries(int seriesId) async {
    _state = RequestState.loading;
    print(seriesId);

    notifyListeners();

    final result = await getDetailTvsUseCase(seriesId);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (movieDetail) {
        _seriesDetail = movieDetail;
        _state = RequestState.loaded;
      },
    );
    notifyListeners();
  }

  Future<void> addToWatchList(SeriesDetail series) async {
    final result = await addTvsToWatchListUseCase(series);

    result.fold((failure) {
      _watchListMessage = 'Failed to add movie to watchlist';
    }, (successMsg) {
      _watchListMessage = successMsg.toString();
    });

    loadWatchListStatus(series.id);
    notifyListeners();
  }

  Future<void> removeFromWatchList(SeriesDetail series) async {
    final result = await removeTvsFromWatchListUseCase(series);

    result.fold((failure) {
      _watchListMessage = failure.message;
    }, (successMsg) {
      _watchListMessage = successMsg.toString();
    });
    loadWatchListStatus(series.id);
    notifyListeners();
  }

  Future<void> loadWatchListStatus(int id) async {
    final result = await getSeriesWatchListStatus(id);
    _isAddedToWatchList = result;
    notifyListeners();
  }
}
