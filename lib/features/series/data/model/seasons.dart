import 'package:movid/features/series/domain/entites/season.dart';

class SeasonModel extends Season {
  final int? id;
  final String? airDate;
  final int? episodeNumber;
  final String? name;
  final String? description;
  final String? runTime;
  final double? voteAverage;
  final double? voteCount;
  const SeasonModel({
    this.id,
    this.airDate,
    this.description,
    this.episodeNumber,
    this.name,
    this.runTime,
    this.voteAverage,
    this.voteCount,
  }) : super(
          id: id,
          airDate: airDate,
          episodeNumber: episodeNumber,
          name: name,
          description: description,
          runTime: runTime,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );
  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
        id: json['id'],
        name: json["name"],
        episodeNumber: json['episode_number'],
        airDate: json['air_date'],
        runTime: json['runtime'],
        description: json['overview'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count']);
  }
}
