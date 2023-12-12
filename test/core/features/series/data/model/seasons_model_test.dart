import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movid/features/series/data/model/season_model.dart';
import 'package:movid/features/series/domain/entites/season.dart';
import '../../../../../helpers/json_reader.dart';

void main() {
  const testSeasonModel = SeasonModel(
    id: 170277,
    airDate: "1953-01-01",
    episodeNumber: 2,
    name: "Season 1953",
    description: "",
    runTime: 15,
    voteAverage: 0.0,
    voteCount: 0,
  );

  test('should be a subclass of season entity', () async {
    //assert
    expect(testSeasonModel, isA<Season>());
  });

  test('should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_seasons_json_response.json'),
    );

    //act
    final result = SeasonModel.fromMap(jsonMap);
    //expect

    expect(result, equals(testSeasonModel));
  });
}
