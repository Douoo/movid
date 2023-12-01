// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'movie_model.dart';

class MovieResponse {
  final List<MovieModel> movieList;

  MovieResponse({required this.movieList});

  factory MovieResponse.fromMap(Map<String, dynamic> map) {
    return MovieResponse(
      movieList: List.from(
        map['results'].map<MovieModel>(
          (x) => MovieModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory MovieResponse.fromJson(String source) =>
      MovieResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
