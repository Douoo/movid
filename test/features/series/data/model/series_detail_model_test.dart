import 'package:flutter_test/flutter_test.dart';
import 'package:movid/features/series/data/model/series_detail_model.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/series/dummy_objects.dart';

void main() {
  test('should be a subclass of Series Detail entity', () {
    expect(testDetailTvSeriesModel, isA<SeriesDetail>());
  });
  group('fromJSON', () {
    test('should convert json string to a series series object', () {
      //arrange
      final jsonData =
          jsonReader('test/helpers/series/dummy_data/series_detail.json');
      //act
      final result = SeriesDetailModel.fromJson(jsonData);
      //assert
      expect(result, testDetailTvSeriesModel);
    });
  });
}
