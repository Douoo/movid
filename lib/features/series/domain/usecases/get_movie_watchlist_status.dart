import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetSeriesWatchListStatus {
  final TvSeriesRepository repository;

  GetSeriesWatchListStatus(this.repository);

  Future<bool> call(int movieId) async {
    return repository.isAddedToWatchList(movieId);
  }
}
