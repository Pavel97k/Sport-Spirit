// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionServer _$CollectionServerFromJson(Map<String, dynamic> json) =>
    CollectionServer(
      idCollectionServer: (json['idCollectionServer'] as num?)?.toInt(),
      collectionServerName: json['collectionServerName'] as String,
      collectionServerType: json['collectionServerType'] as String,
      collectionServerMultiplicity:
          json['collectionServerMultiplicity'] as String,
      availabilityBasicEquipment: json['availabilityBasicEquipment'] as bool,
      genderId: (json['genderId'] as num).toInt(),
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$CollectionServerToJson(CollectionServer instance) =>
    <String, dynamic>{
      'idCollectionServer': instance.idCollectionServer,
      'collectionServerName': instance.collectionServerName,
      'collectionServerType': instance.collectionServerType,
      'collectionServerMultiplicity': instance.collectionServerMultiplicity,
      'availabilityBasicEquipment':
          CollectionServer._boolToInt(instance.availabilityBasicEquipment),
      'genderId': instance.genderId,
      'isDeleted': CollectionServer._boolToInt(instance.isDeleted),
    };
