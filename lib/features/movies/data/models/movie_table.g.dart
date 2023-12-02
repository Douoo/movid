// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDataAdapter extends TypeAdapter<MovieData> {
  @override
  final int typeId = 0;

  @override
  MovieData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieData(
      releaseDate: fields[0] as String?,
      id: fields[1] as int,
      title: fields[2] as String,
      posterPath: fields[3] as String?,
      overview: fields[4] as String?,
      voteAverage: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.releaseDate)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.posterPath)
      ..writeByte(4)
      ..write(obj.overview)
      ..writeByte(5)
      ..write(obj.voteAverage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
