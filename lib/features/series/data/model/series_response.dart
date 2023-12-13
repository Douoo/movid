// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:movid/features/series/data/model/tv_series_model.dart';

class TvSeriesResponse {
  final List<TvSeriesModel> tvList;

  TvSeriesResponse({required this.tvList});

  factory TvSeriesResponse.fromMap(Map<String, dynamic> map) {
    return TvSeriesResponse(
      tvList: List.from(
        map['results'].map<TvSeriesModel>(
          (x) => TvSeriesModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory TvSeriesResponse.fromJson(String source) =>
      TvSeriesResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
