import 'dart:convert';

import '../../domain/entites/season_episode.dart';

class SeasonEpisodeModel extends SeasonEpisode {
  const SeasonEpisodeModel({
    super.id,
    super.airDate,
    super.overview,
    super.episodeNumber,
    super.name,
    super.runTime,
    super.voteAverage,
    super.voteCount,
    super.stillPath,
  });
  factory SeasonEpisodeModel.fromMap(Map<String, dynamic> map) {
    return SeasonEpisodeModel(
        id: map['id'],
        stillPath: map['still_path'],
        name: map["name"],
        episodeNumber: map['season_number'],
        airDate: map['air_date'],
        runTime: map['runtime'],
        overview: map['overview'],
        voteAverage: map['vote_average'],
        voteCount: map['vote_count']);
  }

  factory SeasonEpisodeModel.fromJson(String source) =>
      SeasonEpisodeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
