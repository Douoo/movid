import 'package:equatable/equatable.dart';

abstract class Content extends Equatable {
  final String? title;
  final String? posterPath;
  final String? language;
  final String? releaseDate;
  final double? voteAverage;
  final String? overview;
  Content({
    required this.title,
    required this.posterPath,
    required this.language,
    required this.releaseDate,
    required this.voteAverage,
    required this.overview,
  });

  @override
  List<Object?> get props =>
      [title, posterPath, language, releaseDate, voteAverage, overview];
}
