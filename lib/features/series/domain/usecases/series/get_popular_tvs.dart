import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetPopularTvsUseCase {
  final TvSeriesRepository series;
  GetPopularTvsUseCase({required this.series});
  Future<List<TvSeries>> call() {
    return series.getPopularTvSeries();
  }
}
