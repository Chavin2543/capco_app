import 'package:capco_app/scene/user/domain/entities/user/address/geo.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geo_model.g.dart';

@JsonSerializable(includeIfNull: true)
@HiveType(typeId: 2)
class GeoModel extends Equatable {
  @HiveField(0)
  final String lat;

  @HiveField(1)
  final String lng;

  const GeoModel({
    required this.lat,
    required this.lng,
  });

  factory GeoModel.fromJson(Map<String, dynamic> json) =>
      _$GeoModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeoModelToJson(this);

  @override
  List<Object?> get props => [
        lat,
        lng,
      ];
}

extension GeoModelExtension on GeoModel {
  Geo toGeo() => Geo(
        lat: lat,
        lng: lng,
      );
}
