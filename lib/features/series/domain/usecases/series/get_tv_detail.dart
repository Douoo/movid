import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetDetailTvsUseCase {
  final TvSeriesRepository series;
  GetDetailTvsUseCase({required this.series});
  Future<List<TvSeries>> call(int id) {
    return series.getDetailTvSeries(id);
  }
}
