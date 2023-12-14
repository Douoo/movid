import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movid/features/series/data/model/tv_series_model.dart';
import 'package:movid/features/series/domain/entites/series.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  final testTvModel = TvModel(
    title: "Tagesschau",
    date: "1952-12-26",
    description:
        "German daily news program, the oldest still existing program on German television.",
    rating: 7.093,
    language: "de",
    isAdult: false,
    id: 94722,
    genreIds: [10763],
    backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
    poster: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  );

  test('should be a subclass of tv entity', () async {
    //assert
    expect(testTvModel, isA<Tv>());
  });
  test('should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_tv_json_response.json'),
    );
    //act

    final result = TvModel.fromMap(jsonMap);

    //assert
    expect(result, equals(testTvModel));
  });
}
