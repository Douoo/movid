// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:movid/features/series/data/model/tv_series_model.dart';

class TvResponse {
  final List<TvModel> tvList;

  TvResponse({required this.tvList});

  factory TvResponse.fromMap(Map<String, dynamic> map) {
    return TvResponse(
      tvList: List.from(
        map['results'].map<TvModel>(
          (x) => TvModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory TvResponse.fromJson(String source) =>
      TvResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
