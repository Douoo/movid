import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/usecases/series/get_tv_detail.dart';

class TvSeriesDetailProvider extends ChangeNotifier {
  final GetDetailTvsUseCase getDetailTvsUseCase;
  TvSeriesDetailProvider({required this.getDetailTvsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  late SeriesDetail _seriesDetail;
  SeriesDetail get seriesDetail => _seriesDetail;

  String _message = '';
  String get message => _message;

  Future<void> fetchDetailTvSeries(int seriesId) async {
    _state = RequestState.loading;

    notifyListeners();

    final result = await getDetailTvsUseCase(seriesId);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        print("boooo $_message");
      },
      (movieDetail) {
        print("boooo $movieDetail");
        _seriesDetail = movieDetail;
        _state = RequestState.loaded;
      },
    );
    notifyListeners();
  }
}
