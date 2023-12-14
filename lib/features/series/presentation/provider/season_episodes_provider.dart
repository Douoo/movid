import 'package:flutter/foundation.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/domain/entites/season_episode.dart';

import 'package:movid/features/series/domain/usecases/series/get_tv_season_episodes.dart';

class SeasonEpisodesProvider extends ChangeNotifier {
  final GetTvSeasonEpisodes getTvSeasonEpisodes;

  SeasonEpisodesProvider({required this.getTvSeasonEpisodes,});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<SeasonEpisode> _tvSeasonEpisodes = [];
  List<SeasonEpisode> get seasonEpisodes => _tvSeasonEpisodes;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeasonEpisodes(int id, int seasonNumber) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvSeasonEpisodes(id, seasonNumber);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (tvSeasonEpisodes) {
        _tvSeasonEpisodes = tvSeasonEpisodes;
        _state = RequestState.loaded;
      },
    );
    notifyListeners();
  }
}
