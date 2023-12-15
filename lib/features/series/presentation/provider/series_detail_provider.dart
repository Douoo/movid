import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/usecases/add_series_to_watchlist.dart';
import 'package:movid/features/series/domain/usecases/get_movie_watchlist_status.dart';
import 'package:movid/features/series/domain/usecases/remove_watchlist_series.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_detail.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_recommendations.dart';

class TvDetailProvider extends ChangeNotifier {
  static const watchListAddSuccessMessage = 'Added to watchList';
  static const watchListRemoveSuccessMessage = 'Removed from watchList';

  final GetDetailTvsUseCase getDetailTvsUseCase;
  final GetRecommendedTvsUseCase getRecommendedTvsUseCase;
  final GetTvWatchListStatus getTvWatchListStatus;
  final AddTvsToWatchListUseCase addTvsToWatchListUseCase;
  final RemoveTvsFromWatchListUseCase removeTvsFromWatchListUseCase;
  TvDetailProvider({
    required this.getDetailTvsUseCase,
    required this.addTvsToWatchListUseCase,
    required this.getRecommendedTvsUseCase,
    required this.getTvWatchListStatus,
    required this.removeTvsFromWatchListUseCase,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  RequestState _recommendedTvState = RequestState.empty;
  RequestState get recommendedTvState => _recommendedTvState;
  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  late List<Tv> _recommendedTv = [];
  List<Tv> get recommendedTv => _recommendedTv;

  bool _isAddedToWatchList = false;
  bool get isAddedToWatchList => _isAddedToWatchList;

  String _message = '';
  String get message => _message;

  String _watchListMessage = '';
  String get watchListMessage => _watchListMessage;

  Future<void> fetchRecommendedTv(int tvId) async {
    _recommendedTvState = RequestState.loading;
    notifyListeners();
    final recommendedTvResult = await getRecommendedTvsUseCase(tvId);
    recommendedTvResult.fold(
      (failure) {
        _recommendedTvState = RequestState.error;
        _message = failure.message;
      },
      (tvs) {
        _recommendedTvState = RequestState.loaded;
        _recommendedTv = tvs;
      },
    );
    notifyListeners();
  }

  Future<void> fetchDetailTvSeries(int tvId) async {
    _state = RequestState.loading;

    notifyListeners();

    final detailResult = await getDetailTvsUseCase(tvId);

    fetchRecommendedTv(tvId);

    detailResult.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (tvDetails) {
        _state = RequestState.loaded;
        _tvDetail = tvDetails;
      },
    );
    notifyListeners();
  }

  Future<void> addTvToWatchList(TvDetail tv) async {
    final result = await addTvsToWatchListUseCase(tv);

    result.fold((failure) {
      _watchListMessage = 'Failed to add movie to watchlist';
    }, (successMsg) {
      _watchListMessage = successMsg.toString();
    });

    loadTvWatchListStatus(tv.id);
    notifyListeners();
  }

  Future<void> removeTvFromWatchList(TvDetail tv) async {
    final result = await removeTvsFromWatchListUseCase(tv);

    result.fold((failure) {
      _watchListMessage = failure.message;
    }, (successMsg) {
      _watchListMessage = successMsg.toString();
    });
    loadTvWatchListStatus(tv.id);
    notifyListeners();
  }

  Future<void> loadTvWatchListStatus(int id) async {
    final result = await getTvWatchListStatus(id);
    _isAddedToWatchList = result;
    notifyListeners();
  }
}
