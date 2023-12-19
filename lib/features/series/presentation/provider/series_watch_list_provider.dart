import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';

import '../../domain/entites/series.dart';
import '../../domain/usecases/get_watchlist_series.dart';


class TvWatchListProvider extends ChangeNotifier {
  final GetWatchListTvsUseCase getWatchListTvsUseCase;

  TvWatchListProvider({required this.getWatchListTvsUseCase});

  List<Tv> _tv = [];
  List<Tv> get movies => _tv;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchListTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getWatchListTvsUseCase();

    result.fold((failure) {
      _state = RequestState.error;
      _message = failure.message;
    }, (tv) {
      _tv = tv;
      _state = RequestState.loaded;
    });
    notifyListeners();
  }
}
