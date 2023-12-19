import 'dart:convert';

import '../../data/model/season_model.dart';
import '../../domain/entites/season_episode.dart';

class SeasonResponse {
  final List<SeasonEpisode> seasonList;

  SeasonResponse({required this.seasonList});

  factory SeasonResponse.fromMap(Map<String, dynamic> map) {
    return SeasonResponse(
      seasonList: List.from(
        map['episodes'].map<SeasonEpisode>(
          (y) => SeasonEpisodeModel.fromMap(y as Map<String, dynamic>),
        ),
      ),
    );
  }
  factory SeasonResponse.fromJson(String source) =>
      SeasonResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
