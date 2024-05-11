import 'package:json_annotation/json_annotation.dart';

part 'collection_server.g.dart';

@JsonSerializable()
class CollectionServer {
  final int? idCollectionServer;
  final String collectionServerName;
  final String collectionServerType;
  final String collectionServerMultiplicity;
  @JsonKey(toJson: _boolToInt)
  final bool availabilityBasicEquipment;
  final int genderId;
  @JsonKey(toJson: _boolToInt)
  final bool? isDeleted;

  CollectionServer(
      {this.idCollectionServer,
      required this.collectionServerName,
      required this.collectionServerType,
      required this.collectionServerMultiplicity,
      required this.availabilityBasicEquipment,
      required this.genderId,
      this.isDeleted});

  /// Connect the generated [_$CollectionServerFromJson] function to the `fromJson`
  /// factory.
  factory CollectionServer.fromJson(Map<String, dynamic> json) =>
      _$CollectionServerFromJson(json);

  /// Connect the generated [_$CollectionServerToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CollectionServerToJson(this);

  static int _boolToInt(bool? value) {
    if (value == null) {
      return 0;
    } else {
      return value ? 1 : 0;
    }
  }
}
