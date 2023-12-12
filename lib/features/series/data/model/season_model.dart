import 'dart:convert';

import 'package:movid/features/series/domain/entites/season.dart';

class SeasonModel extends Season {
  const SeasonModel({
    super.id,
    super.airDate,
    super.description,
    super.episodeNumber,
    super.name,
    super.runTime,
    super.voteAverage,
    super.voteCount,
    super.still_path,
  });
  factory SeasonModel.fromMap(Map<String, dynamic> map) {
    return SeasonModel(
        id: map['id'],
        still_path: map['still_path'],
        name: map["name"],
        episodeNumber: map['season_number'],
        airDate: map['air_date'],
        runTime: map['runtime'],
        description: map['overview'],
        voteAverage: map['vote_average'],
        voteCount: map['vote_count']);
  }

  factory SeasonModel.fromJson(String source) =>
      SeasonModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
