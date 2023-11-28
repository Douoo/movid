import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movid/features/series/data/model/series.dart';
import 'package:movid/features/series/domain/entites/series.dart';

import '../../../../../helpers/json_reader.dart';

void main() {
  const testSeriesModel = TvSeriesModel(
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

  test('should be a subclass of series entity', () async {
    //assert
    expect(testSeriesModel, isA<TvSeries>());
  });
  test('should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_series_json_response.json'),
    );
    //act

    final result = TvSeriesModel.fromJson(jsonMap);

    //assert
    expect(result, equals(testSeriesModel));
  });
}
