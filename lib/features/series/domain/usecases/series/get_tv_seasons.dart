import 'package:movid/features/series/domain/entites/season.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetTvsSeasonsUseCase {
  final TvSeriesRepository series;
  GetTvsSeasonsUseCase({required this.series});
  Future<List<Season>> call() {
    return series.getTvSeriesSeasons();
  }
}
