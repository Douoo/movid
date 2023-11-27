import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class RemoveTvsFromWatchListUseCase {
  final TvSeriesRepository series;
  RemoveTvsFromWatchListUseCase({required this.series});
  Future<bool> call(TvSeries tvSeries) {
    return series.removeWatchListSeries(tvSeries);
  }
}
