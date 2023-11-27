import 'package:movid/features/series/domain/entites/series.dart';

class TvSeriesModel extends TvSeries {
  final String? title;
  final String? date;
  final double? rating;
  final String? language;
  final String? description;
  final bool? isAdult;
  final int? id;
  final List<int>? genreIds;
  final String? backdropPath;
  final String? poster;
  const TvSeriesModel({
    this.title,
    this.date,
    this.rating,
    this.language,
    this.description,
    this.isAdult,
    this.id,
    this.backdropPath,
    this.genreIds,
    this.poster,
  }) : super(
          rating: rating,
          title: title,
          date: date,
          language: language,
          description: description,
          isAdult: isAdult,
          id: id,
          backdropPath: backdropPath,
          genreIds: genreIds,
          poster: poster,
        );
  factory TvSeriesModel.fromJson(Map<String, dynamic> json) {
    return TvSeriesModel(
        title: json['name'],
        date: json['release_date'],
        rating: json['vote_average'],
        description: json['overview'],
        isAdult: json['adult'],
        id: json['id'],
        language: json['original_language'],
        backdropPath: json['backdrop_path'],
        genreIds: json['genre_ids'],
        poster: json['poster_path']);
  }
}
