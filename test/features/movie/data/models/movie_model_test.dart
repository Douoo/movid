import 'package:flutter_test/flutter_test.dart';
import 'package:movid/features/movies/data/models/movie_model.dart';
import 'package:movid/features/movies/domain/entities/movie.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/movie/dummy_objects.dart';

void main() {
  test('should be a subclass of Movie entity', () {
    expect(testMovieModel, isA<Movie>());
  });
  group('fromJSON', () {
    test('should convert json string to a movie object', () {
      //arrange
      final jsonData =
          jsonReader('test/helpers/movie/dummy_response/movie_model.json');
      //act
      final result = MovieModel.fromJson(jsonData);
      //assert
      expect(result, testMovieModel);
    });
  });
}
