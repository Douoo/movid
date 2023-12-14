import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetTvWatchListStatus {
  final TvRepository repository;

  GetTvWatchListStatus(this.repository);

  Future<bool> call(int movieId) async {
    return repository.isAddedToWatchList(movieId);
  }
}
