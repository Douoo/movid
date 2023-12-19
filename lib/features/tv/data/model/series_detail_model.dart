import 'dart:convert';

import '../../data/model/genre_model.dart';
import '../../domain/entites/series_detail.dart';

class TvDetailModel extends TvDetail {
  const TvDetailModel({
    required super.backdropPath,
    required super.genres,
    required super.language,
    required super.id,
    required super.posterPath,
    required super.releaseDate,
    required super.title,
    required super.voteAverage,
    required super.voteCount,
    required super.numberOfEpisodes,
    required super.numberOfSeasons,
    required super.overView,
  });

  factory TvDetailModel.fromMap(Map<String, dynamic> map) {
    return TvDetailModel(
        overView: map['overview'],
        backdropPath: map['backdrop_path'] as String?,
        language: map['languages'] as List<dynamic>,
        genres: List.from(
            (map['genres']).map((genre) => GenreModel.fromMap(genre))),
        id: map['id'] as int,
        posterPath: map['poster_path'] as String?,
        releaseDate: map['first_air_date'] as String,
        title: map['name'] as String,
        voteAverage: map['vote_average'] as double,
        voteCount: map['vote_count'] as int,
        numberOfEpisodes: map['number_of_episodes'],
        numberOfSeasons: map['number_of_seasons']);
  }

  factory TvDetailModel.fromJson(String source) =>
      TvDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
