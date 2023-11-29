// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:movid/features/series/domain/entites/series.dart';

class TvSeriesModel extends TvSeries {
  const TvSeriesModel({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'date': date,
      'rating': rating,
      'language': language,
      'description': description,
      'isAdult': isAdult,
      'id': id,
      'genreIds': genreIds,
      'backdropPath': backdropPath,
      'poster': poster,
    };
  }

  factory TvSeriesModel.fromMap(Map<String, dynamic> map) {
    return TvSeriesModel(
      title: map['title'] != null ? map['title'] as String : null,
      date: map['first_air_date'] != null
          ? map['first_air_date'] as String
          : null,
      rating:
          map['vote_average'] != null ? map['vote_average'] as double : null,
      language: map['original_language'] != null
          ? map['original_language'] as String
          : null,
      description: map['overview'] != null ? map['overview'] as String : null,
      isAdult: map['isAdult'] != null ? map['isAdult'] as bool : null,
      id: map['id'] != null ? map['id'] as int : null,
      genreIds: map['genreIds'] != null
          ? List<dynamic>.from((map['genreIds'] as List<dynamic>))
          : null,
      backdropPath:
          map['backdropPath'] != null ? map['backdropPath'] as String : null,
      poster: map['poster'] != null ? map['poster'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TvSeriesModel.fromJson(String source) =>
      TvSeriesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
