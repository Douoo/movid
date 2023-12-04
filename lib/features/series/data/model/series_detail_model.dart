import 'dart:convert';

import 'package:movid/features/series/data/model/genre_model.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';

class SeriesDetailModel extends SeriesDetail {
  const SeriesDetailModel({
    required super.backdropPath,
    required super.genres,
    required super.id,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
    required super.runtime,
    required super.title,
    required super.voteAverage,
    required super.voteCount,
  });

  factory SeriesDetailModel.fromMap(Map<String, dynamic> map) {
    return SeriesDetailModel(
      backdropPath: map['backdrop_path'] as String?,
      genres:
          List.from((map['genres']).map((genre) => GenreModel.fromMap(genre))),
      id: map['id'] as int,
      overview: map['overview'] as String,
      posterPath: map['poster_path'] as String?,
      releaseDate: map['release_date'] as String,
      runtime: map['runtime'] as int,
      title: map['title'] as String,
      voteAverage: map['vote_average'] as double,
      voteCount: map['vote_count'] as int,
    );
  }

  factory SeriesDetailModel.fromJson(String source) =>
      SeriesDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
