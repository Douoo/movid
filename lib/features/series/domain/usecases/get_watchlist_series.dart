import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetWatchListTvsUseCase {
  final TvSeriesRepository series;
  GetWatchListTvsUseCase({required this.series});
  Future<List<TvSeries>> call() {
    return series.getWatchListTvSeries();
  }
}
