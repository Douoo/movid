import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class AddTvsToWatchListUseCase {
  final TvRepository repository;
  AddTvsToWatchListUseCase({required this.repository});
  Future<Either<Failure, bool>> call(TvDetail tv) {
    return repository.addTvToWatchList(tv);
  }
}
