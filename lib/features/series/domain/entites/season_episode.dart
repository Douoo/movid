import 'package:equatable/equatable.dart';

class SeasonEpisode extends Equatable {
  final int? id;
  final String? airDate;
  final int? episodeNumber;
  final String? name;
  final String? overview;
  final int? runTime;
  final double? voteAverage;
  final int? voteCount;
  final String? stillPath;
  const SeasonEpisode({
    this.id,
    this.airDate,
    this.overview,
    this.episodeNumber,
    this.name,
    this.runTime,
    this.voteAverage,
    this.voteCount,
    this.stillPath,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        name,
        overview,
        runTime,
        id,
        voteAverage,
        voteCount,
        stillPath
      ];
}
