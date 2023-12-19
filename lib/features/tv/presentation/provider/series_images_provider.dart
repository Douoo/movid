import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';

import '../../domain/entites/media_image.dart';
import '../../domain/usecases/series/get_series_images.dart';

class TvImagesProvider extends ChangeNotifier {
  final GetTvImages getTvImages;
  TvImagesProvider({required this.getTvImages});

  late MediaImage _mediaImages;
  MediaImage get mediaImages => _mediaImages;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchtvImages(int movieId) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvImages(movieId);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
    }, (tvMediaImage) {
      _mediaImages = tvMediaImage;
      _state = RequestState.loaded;
    });
    notifyListeners();
  }
}
