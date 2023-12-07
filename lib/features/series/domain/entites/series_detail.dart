import 'package:equatable/equatable.dart';
import 'package:movid/features/series/domain/entites/genre.dart';

class SeriesDetail extends Equatable {
  final String? backdropPath;
  final List<Genre> genres;
  final int id;

  final String? posterPath;
  final String releaseDate;
  final List<dynamic> runtime;
  final String title;
  final double voteAverage;
  final int voteCount;
  final int numberOfEpisodes;
  final int numberOfSeasons;

  const SeriesDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
  });
  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        posterPath,
        releaseDate,
        runtime,
        title,
        voteAverage,
        voteCount,
        numberOfEpisodes,
        numberOfEpisodes
      ];
}
