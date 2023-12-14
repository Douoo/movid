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

  Future<void> fetchRecommendTvSeres(int id) async {
    _recommendedTvState = RequestState.loading;
    notifyListeners();
    final result = await getRecommendedTvsUseCase(id);

    result.fold((failure) {
      _recommendedTvState = RequestState.error;
      _message = failure.message;
    }, (recommended) {
      _recommendedTv = recommended;
      _recommendedTvState = RequestState.loaded;
    });
    notifyListeners();
  }

  Future<void> fetchDetailTv(int tvId) async {
    _state = RequestState.loading;

    notifyListeners();

    final result = await getDetailTvsUseCase(tvId);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (movieDetail) {
        _tvDetail = movieDetail;
        _state = RequestState.loaded;
      },
    );
    notifyListeners();
  }

  Future<void> addToWatchList(TvDetail tv) async {
    final result = await addTvsToWatchListUseCase(tv);

    result.fold((failure) {
      _watchListMessage = 'Failed to add movie to watchlist';
    }, (successMsg) {
      _watchListMessage = successMsg.toString();
    });

    loadWatchListStatus(tv.id);
    notifyListeners();
  }

  Future<void> removeFromWatchList(TvDetail tv) async {
    final result = await removeTvsFromWatchListUseCase(tv);

    result.fold((failure) {
      _watchListMessage = failure.message;
    }, (successMsg) {
      _watchListMessage = successMsg.toString();
    });
    loadWatchListStatus(tv.id);
    notifyListeners();
  }

  Future<void> loadWatchListStatus(int id) async {
    final result = await getTvWatchListStatus(id);
    _isAddedToWatchList = result;
    notifyListeners();
  }
}
