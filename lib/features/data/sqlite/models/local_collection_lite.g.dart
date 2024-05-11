// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_collection_lite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionLite _$CollectionLiteFromJson(Map<String, dynamic> json) =>
    CollectionLite(
      id: (json['id'] as num?)?.toInt(),
      collectionName: json['collectionName'] as String,
      collectionType: json['collectionType'] as String,
      collectionMultiplicity: json['collectionMultiplicity'] as String,
      availabilityBasicEquipment: CollectionLite._intToBool(
          (json['availabilityBasicEquipment'] as num).toInt()),
      genderName: json['genderName'] as String,
    );

Map<String, dynamic> _$CollectionLiteToJson(CollectionLite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collectionName': instance.collectionName,
      'collectionType': instance.collectionType,
      'collectionMultiplicity': instance.collectionMultiplicity,
      'availabilityBasicEquipment':
          CollectionLite._boolToInt(instance.availabilityBasicEquipment),
      'genderName': instance.genderName,
    };
