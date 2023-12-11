import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/series/get_top_rated_tvs.dart';

class TopRatedTvSeriesProvider extends ChangeNotifier {
  final GetTopRatedTvsUseCase getTopRatedTvsUseCase;
  //The following state is for controlling the state of the operation
  RequestState _state = RequestState.empty;

  TopRatedTvSeriesProvider({required this.getTopRatedTvsUseCase});
  RequestState get state => _state;

  List<TvSeries> _series = [];
  List<TvSeries> get series => _series;
  int page = 1;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedMovies() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvsUseCase(page);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (movies) {
        _series = movies;
        _state = RequestState.loaded;
        page = page + 1;
      },
    );
    notifyListeners();
  }
}
