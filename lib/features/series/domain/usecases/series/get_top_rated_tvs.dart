import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetTopRatedTvsUseCase {
  final TvSeriesRepository series;
  GetTopRatedTvsUseCase({required this.series});
  Future<List<TvSeries>> call() {
    return series.getTopRatedTvSeries();
  }
}
