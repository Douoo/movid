import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class GetDetailTvsUseCase {
  final TvRepository tv;
  GetDetailTvsUseCase({required this.tv});
  Future<Either<Failure, TvDetail>> call(int id) {
    return tv.getDetailTv(id);
  }
}
