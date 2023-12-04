// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:movid/features/series/data/model/tv_series_model.dart';
import 'package:movid/features/series/domain/entites/series.dart';

class TvSeriesResponse {
  final List<TvSeries> tvList;

  TvSeriesResponse({required this.tvList});

  factory TvSeriesResponse.fromMap(Map<String, dynamic> map) {
    return TvSeriesResponse(
      tvList: List.from(
        map['results'].map<TvSeries>(
          (x) => TvSeriesModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory TvSeriesResponse.fromJson(String source) =>
      TvSeriesResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
