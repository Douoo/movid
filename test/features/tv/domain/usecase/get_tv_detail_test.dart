import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movid/features/tv/domain/usecases/series/get_tv_detail.dart';

import '../../../../helpers/global_test_helpers.mocks.dart';
import '../../../../helpers/series/dummy_objects.dart';

void main() {
  late GetDetailTvsUseCase getDetailTvsUseCase;
  late MockTvRepository mockTvRepository;
  setUp(() {
    mockTvRepository = MockTvRepository();
    getDetailTvsUseCase = GetDetailTvsUseCase(tv: mockTvRepository);
  });

  test('should get Detail tv tv from repository', () async {
    //arrange
    when(mockTvRepository.getDetailTv(testTvId))
        .thenAnswer((_) async => const Right(testDetailTv));
    //act
    final result = await getDetailTvsUseCase.call(testTvId);

    // assert
    expect(result, const Right(testDetailTv));
  });
}
