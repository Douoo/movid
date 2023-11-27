import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetOnAirTvsUseCase {
  final TvSeriesRepository series;
  GetOnAirTvsUseCase({required this.series});
  Future<List<TvSeries>> call() {
    return series.getOnAirTvSeries();
  }
}
