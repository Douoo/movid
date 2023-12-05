import 'dart:convert';

import 'package:movid/features/movies/data/models/genre_model.dart';
import 'package:movid/features/movies/domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  const MovieDetailModel({
    required super.backdropPath,
    required super.genres,
    required super.id,
    super.language,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
    required super.runtime,
    required super.title,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieDetailModel.fromMap(Map<String, dynamic> map) {
    return MovieDetailModel(
      backdropPath: map['backdrop_path'] as String?,
      genres:
          List.from((map['genres']).map((genre) => GenreModel.fromMap(genre))),
      id: map['id'] as int,
      language:  map['original_language'] as String?,
      overview: map['overview'] as String,
      posterPath: map['poster_path'] as String?,
      releaseDate: map['release_date'] as String,
      runtime: map['runtime'] as int,
      title: map['title'] as String,
      voteAverage: map['vote_average'] as double,
      voteCount: map['vote_count'] as int,
    );
  }

  factory MovieDetailModel.fromJson(String source) =>
      MovieDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
