import 'package:flutter_test/flutter_test.dart';
import 'package:movid/features/tv/data/model/series_detail_model.dart';
import 'package:movid/features/tv/domain/entites/series_detail.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/series/dummy_objects.dart';

void main() {
  test('should be a subclass of tv Detail entity', () {
    expect(testDetailTvModel, isA<TvDetail>());
  });
  group('fromJSON', () {
    test('should convert json string to a tv tv object', () {
      //arrange
      final jsonData = jsonReader('test/helpers/tv/dummy_data/tv_detail.json');
      //act
      final result = TvDetailModel.fromJson(jsonData);
      //assert
      expect(result, testDetailTvModel);
    });
  });
}
