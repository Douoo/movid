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
  });
  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
        id: json['id'],
        name: json["name"],
        episodeNumber: json['season_number'],
        airDate: json['episodes'][0]['air_date'],
        runTime: json['episodes'][0]['runtime'],
        description: json['overview'],
        voteAverage: json['vote_average'],
        voteCount: json['episodes'][0]['vote_count']);
  }
}
