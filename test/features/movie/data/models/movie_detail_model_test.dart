import 'package:flutter_test/flutter_test.dart';
import 'package:movid/features/movies/data/models/movie_detail_model.dart';
import 'package:movid/features/movies/domain/entities/movie_detail.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/movie/dummy_objects.dart';

void main() {
  test('should be a subclass of MovieDetail entity', () {
    expect(testMovieDetailModel, isA<MovieDetail>());
  });
  group('fromJSON', () {
    test('should convert json string to a movie detail object', () {
      //arrange
      final jsonData =
          jsonReader('test/helpers/movie/dummy_response/movie_detail.json');
      //act
      final result = MovieDetailModel.fromJson(jsonData);
      //assert
      expect(result, testMovieDetailModel);
    });
  });
}
