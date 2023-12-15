import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/series/get_popular_tvs.dart';

class PopularTvProvider extends ChangeNotifier {
  final GetPopularTvsUseCase getPopularTvsUseCase;

  PopularTvProvider({required this.getPopularTvsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;
  int page = 1;

  List<Tv> _tvList = [];
  List<Tv> get tv => _tvList;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvsUseCase(page);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (series) {
        if (_tvList.isEmpty) {
          _tvList = series;
        } else {
          _tvList.addAll(series);
        }

        _state = RequestState.loaded;
        page = page + 1;
      },
    );
    notifyListeners();
  }
}
