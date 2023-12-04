import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String? backdropPath;
  final List<int>? genreIds;
  final int id;
  final String? language;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final String title;
  final double? voteAverage;
  final int? voteCount;

  const Movie({
    this.backdropPath,
    this.genreIds,
    required this.id,
    this.language,
    this.overview,
    this.posterPath,
    this.releaseDate,
    required this.title,
    this.voteAverage,
    this.voteCount,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        overview,
        posterPath,
        releaseDate,
        title,
        voteAverage,
        voteCount,
      ];
}
