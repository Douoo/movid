import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class SearchTvsUseCase {
  final TvSeriesRepository series;
  SearchTvsUseCase({required this.series});
  Future<List<TvSeries>> call(String data) {
    return series.searchTvSeries(data);
  }
}
