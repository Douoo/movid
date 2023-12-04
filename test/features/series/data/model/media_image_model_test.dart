import 'package:flutter_test/flutter_test.dart';
import 'package:movid/features/movies/domain/entities/media_image.dart';
import 'package:movid/features/series/data/model/media_image_model.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/movie/dummy_objects.dart';

void main() {
  test('should be a sub class of Series MediaImage entity',
      () => {expect(testImage, isA<MediaImage>())});

  group("fromJson", () {
    test("should convert json string to a Series Media Image object", () {
      //arrange
      final jsonData = jsonReader('test/helpers/series/dummy_data/images.json');
      //act
      final result = MediaImageModel.fromJson(jsonData);
      //assert
      expect(result, equals(result));
    });
  });
}
