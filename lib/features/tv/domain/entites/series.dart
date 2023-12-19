import 'package:equatable/equatable.dart';

class Tv extends Equatable {
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

  const Tv(
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
  List<Object?> get props => [
        title,
        date,
        rating,
        backdropPath,
        language,
        description,
        isAdult,
        id,
      ];
}
