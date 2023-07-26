// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blob_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlobMetadataRecordAdapter extends TypeAdapter<BlobMetadataRecord> {
  @override
  final int typeId = 0;

  @override
  BlobMetadataRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BlobMetadataRecord()
      ..accessKey = fields[0] as int
      ..lastAccess = fields[1] as DateTime
      ..accessCount = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, BlobMetadataRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.accessKey)
      ..writeByte(1)
      ..write(obj.lastAccess)
      ..writeByte(2)
      ..write(obj.accessCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlobMetadataRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
