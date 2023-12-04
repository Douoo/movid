// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

import 'movie_model.dart';

part 'movie_table.g.dart';

@HiveType(typeId: 0)
class MovieData extends HiveObject {
  @HiveField(0)
  final String? releaseDate;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String? posterPath;
  @HiveField(4)
  final String? overview;
  @HiveField(5)
  final double? voteAverage;

  MovieData({
    required this.releaseDate,
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.voteAverage,
  });

  MovieData.copy(MovieModel movie)
      : this(
          releaseDate: movie.releaseDate,
          id: movie.id,
          title: movie.title,
          posterPath: movie.posterPath,
          overview: movie.overview,
          voteAverage: movie.voteAverage,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'release_date': releaseDate,
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
      'vote_average': voteAverage,
    };
  }

  factory MovieData.fromMap(Map<String, dynamic> map) {
    return MovieData(
      releaseDate: map['release_date'] as String?,
      id: map['id'] as int,
      title: map['title'] as String,
      posterPath: map['poster_path'] as String?,
      overview: map['overview'] as String?,
      voteAverage: map['vote_average'] as double?,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieData.fromJson(String source) =>
      MovieData.fromMap(json.decode(source) as Map<String, dynamic>);
}
