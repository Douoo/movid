import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class RemoveTvsFromWatchListUseCase {
  final TvRepository repository;

  RemoveTvsFromWatchListUseCase({required this.repository});

  Future<Either<Failure, bool>> call(TvDetail tv) {
    return repository.removeWatchListTv(tv);
  }
}
