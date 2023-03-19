import 'package:capco_app/scene/user/data/models/user_address/geo_model.dart';
import 'package:capco_app/scene/user/domain/entities/user/address/address.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(includeIfNull: true)
@HiveType(typeId: 1)
class AddressModel extends Equatable {
  @HiveField(0)
  final String street;

  @HiveField(1)
  final String suite;

  @HiveField(2)
  final String city;

  @HiveField(3)
  final String zipcode;

  @HiveField(4)
  final GeoModel geo;

  const AddressModel({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @override
  List<Object?> get props => [
        street,
        suite,
        city,
        zipcode,
        geo,
      ];
}

extension AddressModelExtension on AddressModel {
  Address toAddress() => Address(
        street: street,
        suite: suite,
        city: city,
        zipcode: zipcode,
        geo: geo.toGeo(),
      );
}
