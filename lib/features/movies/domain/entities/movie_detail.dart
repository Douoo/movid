import 'package:equatable/equatable.dart';
import 'package:movid/features/movies/domain/entities/genre.dart';

class MovieDetail extends Equatable {
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String? language;
  final String overview;
  final String? posterPath;
  final String releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;
  final int voteCount;

  const MovieDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    this.language,
    required this.overview,
     this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        overview,
        posterPath,
        releaseDate,
        runtime,
        title,
        voteAverage,
        voteCount,
      ];
}
