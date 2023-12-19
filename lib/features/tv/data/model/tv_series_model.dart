// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../domain/entites/series.dart';
import 'series_data.dart';

class TvModel extends Tv {
  const TvModel({
    super.title,
    super.date,
    super.backdropPath,
    super.rating,
    super.language,
    super.description,
    super.isAdult,
    super.id,
    super.genreIds,
    super.poster,
  });

  TvModel.copy(TvData tv)
      : this(
          title: tv.title,
          id: tv.id,
          date: tv.date,
          backdropPath: tv.backdropPath,
          description: tv.overView,
          rating: tv.voteAverage,
        );

  factory TvModel.fromMap(Map<String, dynamic> map) {
    return TvModel(
      title: map['name'] != null ? map['name'] as String : null,
      date: map['first_air_date'] != null
          ? map['first_air_date'] as String
          : null,
      rating:
          map['vote_average'] != null ? map['vote_average'] as double : null,
      language: map['original_language'] != null
          ? map['original_language'] as String
          : null,
      description: map['overview'] != null ? map['overview'] as String : null,
      isAdult: map['adult'] != null ? map['adult'] as bool : null,
      id: map['id'] != null ? map['id'] as int : null,
      genreIds: map['genreIds'] != null
          ? List<dynamic>.from((map['genreIds'] as List<dynamic>))
          : null,
      backdropPath: map['backdrop_path'] as String?,
      poster: map['poster_path'] != null ? map['poster_path'] as String : null,
    );
  }

  factory TvModel.fromJson(String source) =>
      TvModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
