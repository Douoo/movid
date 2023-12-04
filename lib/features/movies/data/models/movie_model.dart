// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../domain/entities/movie.dart';
import 'movie_table.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    super.backdropPath,
    super.genreIds,
    super.language,
    super.overview,
    super.posterPath,
    super.releaseDate,
    required super.title,
    super.voteAverage,
    super.voteCount,
  });

  MovieModel.copy(MovieData movie)
      : this(
          releaseDate: movie.releaseDate,
          id: movie.id,
          title: movie.title,
          posterPath: movie.posterPath,
          overview: movie.overview,
          voteAverage: movie.voteAverage,
        );

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      backdropPath: map['backdrop_path'] as String?,
      genreIds: map['genre_ids'] != null ? List.from((map['genre_ids'])) : null,
      id: map['id'] as int,
      language: map['original_language'] as String?,
      overview: map['overview'] as String?,
      posterPath: map['poster_path'] as String?,
      releaseDate: map['release_date'] as String?,
      title: map['title'],
      voteAverage: map['vote_average'] as double?,
      voteCount: map['vote_count'] as int?,
    );
  }

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
