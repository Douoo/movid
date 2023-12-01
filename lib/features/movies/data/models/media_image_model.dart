// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:movid/features/movies/domain/entities/media_image.dart';

class MediaImageModel extends MediaImage {
  //TODO: Revise this model - only one field enough
  const MediaImageModel({
    required super.id,
    required super.backdropPaths,
    required super.logoPaths,
    required super.posterPaths,
  });

  factory MediaImageModel.fromMap(Map<String, dynamic> map) {
    return MediaImageModel(
      id: map['id'] as int,
      backdropPaths: List<String>.from(
        map['backdrops'].map((x) => x['file_path']),
      ),
      logoPaths: List<String>.from(
        map['logos'].map((x) => x['file_path']),
      ),
      posterPaths: List<String>.from(
        map['posters'].map((x) => x['file_path']),
      ),
    );
  }

  factory MediaImageModel.fromJson(String source) =>
      MediaImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
