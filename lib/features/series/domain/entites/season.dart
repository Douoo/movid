import 'package:equatable/equatable.dart';

class SeasonEpisode extends Equatable {
  final int? id;
  final String? airDate;
  final int? episodeNumber;
  final String? name;
  final String? description;
  final int? runTime;
  final double? voteAverage;
  final int? voteCount;
  final String? still_path;
  const SeasonEpisode({
    this.id,
    this.airDate,
    this.description,
    this.episodeNumber,
    this.name,
    this.runTime,
    this.voteAverage,
    this.voteCount,
    this.still_path,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        name,
        description,
        runTime,
        id,
        voteAverage,
        voteCount,
        still_path
      ];
}
