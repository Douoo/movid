import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/domain/entites/season.dart';

import 'package:movid/features/series/domain/usecases/series/get_tv_seasons.dart';

class SeasonsProvider extends ChangeNotifier {
  final GetTvsSeasonsUseCase getTvsSeasonsUseCase;

  SeasonsProvider({required this.getTvsSeasonsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Season> _seasonList = [];
  List<Season> get season => _seasonList;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeasons(int id, int seasonNumber) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvsSeasonsUseCase(id, seasonNumber);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        print("faulure");
      },
      (tvSeason) {
        print("success");
        if (_seasonList.isNotEmpty) {
          _seasonList.clear();
        }
        _seasonList = tvSeason;
        _state = RequestState.loaded;
      },
    );
    notifyListeners();
  }
}
