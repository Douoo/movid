import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/domain/entites/media_image.dart';
import 'package:movid/features/series/domain/usecases/series/get_series_images.dart';

class TvSeriesImagesProvider extends ChangeNotifier {
  final GetSeriesImages getSeriesImages;
  TvSeriesImagesProvider({required this.getSeriesImages});

  late MediaImage _mediaImages;
  MediaImage get mediaImages => _mediaImages;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeriesImages(int movieId) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getSeriesImages(movieId);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      print("failures");
    }, (tvMediaImage) {
      print("success");
      _mediaImages = tvMediaImage;
      _state = RequestState.loaded;
    });
    notifyListeners();
  }
}
