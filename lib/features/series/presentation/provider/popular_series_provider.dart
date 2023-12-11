import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/usecases/series/get_popular_tvs.dart';

class PopularTvSeriesProvider extends ChangeNotifier {
  final GetPopularTvsUseCase getPopularTvsUseCase;

  PopularTvSeriesProvider({required this.getPopularTvsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;
  int page = 1;

  List<TvSeries> _seriesList = [];
  List<TvSeries> get series => _seriesList;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvSeries() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvsUseCase(page);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (failure) {
        if (_seriesList.isEmpty) {
          _seriesList = series;
        }
        _seriesList.addAll(series);
        _state = RequestState.loaded;
        page = page + 1;
      },
    );
    notifyListeners();
  }
}
