import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/get_watchlist_series.dart';

class TvSeriesWatchListProvider extends ChangeNotifier {
  final GetWatchListTvsUseCase getWatchListTvsUseCase;

  TvSeriesWatchListProvider({required this.getWatchListTvsUseCase});

  List<TvSeries> _series = [];
  List<TvSeries> get movies => _series;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchListSeries() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getWatchListTvsUseCase();

    result.fold((failure) {
      _state = RequestState.error;
      _message = failure.message;
    }, (tvSeries) {
      _series = tvSeries;
      _state = RequestState.loaded;
    });
    notifyListeners();
  }
}
