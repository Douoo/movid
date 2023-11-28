import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
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

  const TvSeries(
      {this.title,
      this.backdropPath,
      this.genreIds,
      this.poster,
      this.date,
      required this.rating,
      this.language,
      this.description,
      this.isAdult,
      this.id});

  @override
  List<Object?> get props =>
      [title, date, rating, language, description, isAdult, id];
}
