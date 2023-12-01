import 'package:flutter_test/flutter_test.dart';
import 'package:movid/features/movies/data/models/media_image_model.dart';
import 'package:movid/features/movies/domain/entities/media_image.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/movie/dummy_objects.dart';

void main() {
  test('should be a subclass of MediaImage entity', () {
    expect(testImage, isA<MediaImage>());
  });
  group('fromJSON', () {
    test('should convert json string to a MediaImage object', () {
      //arrange
      final jsonData =
          jsonReader('test/helpers/movie/dummy_response/images.json');
      //act
      final result = MediaImageModel.fromJson(jsonData);
      //assert
      expect(result, testImageModel);
    });
  });
}
