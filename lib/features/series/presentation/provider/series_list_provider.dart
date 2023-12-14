import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/usecases/series/get_on_air_tvs.dart';
import 'package:movid/features/series/domain/usecases/series/get_popular_tvs.dart';
import 'package:movid/features/series/domain/usecases/series/get_top_rated_tvs.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_detail.dart';

class TvSeriesListProvider extends ChangeNotifier {
  final GetOnAirTvsUseCase getOnAirTvsUseCase;
  final GetPopularTvsUseCase getPopularTvsUseCase;
  final GetTopRatedTvsUseCase getTopRatedTvsUseCase;
  final GetDetailTvsUseCase getDetailTvsUseCase;

  TvSeriesListProvider({
    required this.getOnAirTvsUseCase,
    required this.getPopularTvsUseCase,
    required this.getTopRatedTvsUseCase,
    required this.getDetailTvsUseCase,
  });

  List<TvSeries> _onAirTvs = [];
  int onAirPage = 0;
  List<TvSeries> get onAirTvs => _onAirTvs;

  RequestState _onAirTvsState = RequestState.empty;
  RequestState get onAirTvsState => _onAirTvsState;

  List<TvSeries> _popularTvs = [];
  List<TvSeries> get popularTvs => _popularTvs;
  int popularPage = 1;

  RequestState _popularTvsState = RequestState.empty;
  RequestState get popularTvsState => _popularTvsState;

  List<TvSeries> _topRatedTvs = [];
  List<TvSeries> get topRatedTvs => _topRatedTvs;
  int topRatedPage = 1;

  RequestState _topRatedTvsState = RequestState.empty;
  RequestState get topRatedTvsState => _topRatedTvsState;

  late SeriesDetail _seriesDetail;
  SeriesDetail get tvSeriesDetail => _seriesDetail;

  RequestState _detailTvsState = RequestState.empty;
  RequestState get detailTvsState => _detailTvsState;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAirTvs() async {
    _onAirTvsState = RequestState.loading;
    notifyListeners();

    final result = await getOnAirTvsUseCase(onAirPage);
    result.fold((failure) {
      _message = failure.message;
      _onAirTvsState = RequestState.error;
    }, (series) {
      _onAirTvs = series;
      _onAirTvsState = RequestState.loaded;
      onAirPage = onAirPage + 1;
    });
    notifyListeners();
  }

  Future<void> fetchPopularSeries() async {
    _popularTvsState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvsUseCase(popularPage);

    result.fold((failure) {
      _message = failure.message;
      _popularTvsState = RequestState.error;
    }, (series) {
      if (series.isEmpty) {
        _popularTvs = series;
      } else {
        _popularTvs.addAll(series);
      }
      _popularTvsState = RequestState.loaded;
      popularPage = popularPage + 1;
    });
    notifyListeners();
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedTvsState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvsUseCase(topRatedPage);

    result.fold((failure) {
      _message = failure.message;
      _topRatedTvsState = RequestState.error;
    }, (series) {
      if (series.isEmpty) {
        _topRatedTvs = series;
      } else {
        _topRatedTvs.addAll(series);
      }

      _topRatedTvsState = RequestState.loaded;
      topRatedPage = topRatedPage + 1;
    });
    notifyListeners();
  }

  Future<void> fetchDetailTvSeries(int seriesId) async {
    _detailTvsState = RequestState.loading;

    notifyListeners();

    final result = await getDetailTvsUseCase(seriesId);
    result.fold(
      (failure) {
        _message = failure.message;
        _detailTvsState = RequestState.error;
      },
      (seriesDetail) {
        _seriesDetail = seriesDetail;
        _detailTvsState = RequestState.loaded;
      },
    );
    notifyListeners();
  }
}
