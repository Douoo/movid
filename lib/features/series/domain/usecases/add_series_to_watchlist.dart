import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class AddTvsToWatchListUseCase {
  final TvSeriesRepository series;
  AddTvsToWatchListUseCase({required this.series});
  Future<bool> call(TvSeries tvSeries) {
    return series.addSeriesToWatchList(tvSeries);
  }
}
