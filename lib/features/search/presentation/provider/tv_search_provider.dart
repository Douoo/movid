import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/tv/domain/entites/series.dart';
import 'package:movid/features/tv/domain/usecases/series/search_tvs.dart';

class TvSearchProvider extends ChangeNotifier {
  final SearchTvsUseCase searchTv;
  TvSearchProvider({required this.searchTv});

  RequestState _searchState = RequestState.empty;
  RequestState get searchState => _searchState;

  String _message = '';
  String get message => _message;

  List<Tv> _queryTv = [];
  List<Tv> get queryTv => _queryTv;

  Future<void> searchTvs(String query) async {
    _searchState = RequestState.loading;

    notifyListeners();

    final result = await searchTv(query, 1);

    result.fold((failure) {
      _searchState = RequestState.error;
      _message = failure.message;
    }, (tvs) {
      if (tvs.isEmpty) {
        _searchState = RequestState.empty;
      } else {
        _searchState = RequestState.loaded;
      }
      _queryTv = tvs;
    });
    notifyListeners();
  }
}
