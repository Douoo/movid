// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeriesDataAdapter extends TypeAdapter<SeriesData> {
  @override
  final int typeId = 1;

  @override
  SeriesData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeriesData(
      backdropPath: fields[0] as String?,
      id: fields[1] as int,
      numberOfEpisodes: fields[7] as int,
      numberOfSeasons: fields[8] as int,
      overView: fields[3] as String,
      posterPath: fields[2] as String?,
      title: fields[4] as String,
      voteAverage: fields[5] as double,
      voteCount: fields[6] as int,
      date: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SeriesData obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.backdropPath)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.posterPath)
      ..writeByte(3)
      ..write(obj.overView)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.voteAverage)
      ..writeByte(6)
      ..write(obj.voteCount)
      ..writeByte(7)
      ..write(obj.numberOfEpisodes)
      ..writeByte(8)
      ..write(obj.numberOfSeasons)
      ..writeByte(9)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeriesDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
