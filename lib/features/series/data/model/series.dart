import 'package:movid/features/series/domain/entites/series.dart';

class TvSeriesModel extends TvSeries {
  final String? title;
  final String? date;
  final double? rating;
  final String? language;
  final String? description;
  final bool? isAdult;
  final int? id;
  final List<dynamic>? genreIds;
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
    List<dynamic> results = json['results'];
    return TvSeriesModel(
        title: json['results'][0]['name'],
        date: json['results'][0]['first_air_date'],
        rating: json['results'][0]['vote_average'],
        description: json['results'][0]['overview'],
        isAdult: json['results'][0]['adult'],
        id: json['results'][0]['id'],
        language: json['results'][0]['original_language'],
        backdropPath: json['results'][0]['backdrop_path'],
        genreIds: json['results'][0]['genre_ids'],
        poster: json['results'][0]['poster_path']);
  }
}
