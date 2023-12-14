import 'package:dartz/dartz.dart';
import 'package:movid/core/errors/failure.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/repository/series_repository.dart';

class SearchTvsUseCase {
  final TvRepository tv;
  SearchTvsUseCase({required this.tv});
  Future<Either<Failure, List<Tv>>> call(String data, int page) {
    return tv.searchTv(data, page);
  }
}
