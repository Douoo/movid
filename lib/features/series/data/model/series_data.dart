import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';

part 'series_data.g.dart';

@HiveType(typeId: 1)
class TvData extends HiveObject {
  @HiveField(0)
  final String? backdropPath;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String? posterPath;
  @HiveField(3)
  final String overView;
  @HiveField(4)
  final String title;
  @HiveField(5)
  final double voteAverage;
  @HiveField(6)
  final int voteCount;
  @HiveField(7)
  final int numberOfEpisodes;
  @HiveField(8)
  final int numberOfSeasons;
  @HiveField(9)
  final String date;

  TvData(
      {required this.backdropPath,
      required this.id,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      required this.overView,
      required this.posterPath,
      required this.title,
      required this.voteAverage,
      required this.voteCount,
      required this.date});
  TvData.copy(TvDetail tvDetail)
      : this(
          backdropPath: tvDetail.backdropPath,
          id: tvDetail.id,
          numberOfEpisodes: tvDetail.numberOfEpisodes,
          numberOfSeasons: tvDetail.numberOfSeasons,
          overView: tvDetail.overView,
          voteAverage: tvDetail.voteAverage,
          voteCount: tvDetail.voteCount,
          posterPath: tvDetail.posterPath,
          title: tvDetail.title,
          date: tvDetail.releaseDate,
        );
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'backdropPath': backdropPath,
      'numberOfEpisodes': numberOfEpisodes,
      'numberOfSeasons': numberOfSeasons,
      'overView': overView,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
      'posterPath': posterPath,
      'title': title,
      "date": date,
    };
  }

  factory TvData.fromMap(Map<String, dynamic> map) {
    return TvData(
        backdropPath: map['backdropPath'],
        id: map['id'],
        date: map['date'],
        numberOfEpisodes: map['numberOfEpisodes'],
        numberOfSeasons: map['numberOfSeasons'],
        overView: map['overView'],
        posterPath: map['posterPath'],
        title: map['title'],
        voteAverage: map['voteAverage'],
        voteCount: map['voteCount']);
  }

  String toJson() => json.encode(toMap());

  factory TvData.fromJson(String source) =>
      TvData.fromMap(json.decode(source) as Map<String, dynamic>);
}
