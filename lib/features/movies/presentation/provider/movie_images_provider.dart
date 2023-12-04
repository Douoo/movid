import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/domain/usecases/get_movie_images.dart';

import '../../domain/entities/media_image.dart';

class MovieImagesProvider extends ChangeNotifier {
  final GetMovieImages getMovieImages;

  MovieImagesProvider({required this.getMovieImages});

  late MediaImage _mediaImages;
  MediaImage get mediaImages => _mediaImages;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieImages(int movieId) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getMovieImages(movieId);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
    }, (mediaImage) {
      _mediaImages = mediaImage;
      _state = RequestState.loaded;
    });
    notifyListeners();
  }
}
