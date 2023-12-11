import 'package:equatable/equatable.dart';
import 'package:movid/features/series/domain/entites/genre.dart';

class SeriesDetail extends Equatable {
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final List<dynamic> language;
  final String? posterPath;
  final String releaseDate;
  final String overView;
  final String title;
  final double voteAverage;
  final int voteCount;
  final int numberOfEpisodes;
  final int numberOfSeasons;

  const SeriesDetail({
    required this.backdropPath,
    required this.genres,
    required this.overView,
    required this.id,
    required this.posterPath,
    required this.releaseDate,
    required this.language,
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
        language,
        posterPath,
        releaseDate,
        title,
        voteAverage,
        voteCount,
        numberOfEpisodes,
        numberOfEpisodes,
        overView,
      ];
}
