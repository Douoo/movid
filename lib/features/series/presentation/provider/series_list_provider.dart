import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/usecases/series/get_on_air_tvs.dart';
import 'package:movid/features/series/domain/usecases/series/get_popular_tvs.dart';
import 'package:movid/features/series/domain/usecases/series/get_top_rated_tvs.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_detail.dart';

class TvListProvider extends ChangeNotifier {
  final GetOnAirTvsUseCase getOnAirTvsUseCase;
  final GetPopularTvsUseCase getPopularTvsUseCase;
  final GetTopRatedTvsUseCase getTopRatedTvsUseCase;
  final GetDetailTvsUseCase getDetailTvsUseCase;

  TvListProvider({
    required this.getOnAirTvsUseCase,
    required this.getPopularTvsUseCase,
    required this.getTopRatedTvsUseCase,
    required this.getDetailTvsUseCase,
  });

  List<Tv> _onAirTvs = [];
  int onAirPage = 0;
  List<Tv> get onAirTvs => _onAirTvs;

  RequestState _onAirTvsState = RequestState.empty;
  RequestState get onAirTvsState => _onAirTvsState;

  List<Tv> _popularTvs = [];
  List<Tv> get popularMovies => _popularTvs;
  int popularPage = 1;

  RequestState _popularTvsState = RequestState.empty;
  RequestState get popularTvsState => _popularTvsState;

  List<Tv> _topRatedTvs = [];
  List<Tv> get topRatedTvs => _topRatedTvs;
  int topRatedPage = 1;

  RequestState _topRatedTvsState = RequestState.empty;
  RequestState get topRatedTvsState => _topRatedTvsState;

  late TvDetail _tvDetail;
  TvDetail get Tvtail => _tvDetail;

  RequestState _detailTvsState = RequestState.empty;
  RequestState get detailTvsState => _detailTvsState;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAirTv() async {
    _onAirTvsState = RequestState.loading;
    notifyListeners();

    final result = await getOnAirTvsUseCase(onAirPage);
    result.fold((failure) {
      _message = failure.message;
      _onAirTvsState = RequestState.error;
    }, (tv) {
      _onAirTvs = tv;
      _onAirTvsState = RequestState.loaded;
      onAirPage = onAirPage + 1;
    });
    notifyListeners();
  }

  Future<void> fetchPopularTv() async {
    _popularTvsState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvsUseCase(popularPage);

    result.fold((failure) {
      _message = failure.message;
      _popularTvsState = RequestState.error;
    }, (tv) {
      if (tv.isEmpty) {
        _popularTvs = tv;
      } else {
        _popularTvs.addAll(tv);
      }
      _popularTvsState = RequestState.loaded;
      popularPage = popularPage + 1;
    });
    notifyListeners();
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvsState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvsUseCase(topRatedPage);

    result.fold((failure) {
      _message = failure.message;
      _topRatedTvsState = RequestState.error;
    }, (tv) {
      if (tv.isEmpty) {
        _topRatedTvs = tv;
      } else {
        _topRatedTvs.addAll(tv);
      }

      _topRatedTvsState = RequestState.loaded;
      topRatedPage = topRatedPage + 1;
    });
    notifyListeners();
  }

  Future<void> fetchDetailTv(int tvId) async {
    _detailTvsState = RequestState.loading;

    notifyListeners();

    final result = await getDetailTvsUseCase(tvId);
    result.fold(
      (failure) {
        _message = failure.message;
        _detailTvsState = RequestState.error;
      },
      (tvDetail) {
        _tvDetail = tvDetail;
        _detailTvsState = RequestState.loaded;
      },
    );
    notifyListeners();
  }
}
