import 'package:capco_app/scene/user/data/models/user_address/address_model.dart';
import 'package:capco_app/scene/user/data/models/user_company/company_model.dart';
import 'package:capco_app/scene/user/domain/entities/user/user.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(includeIfNull: true)
@HiveType(typeId: 0)
class UserModel extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final AddressModel address;

  @HiveField(5)
  final String phone;

  @HiveField(6)
  final String website;

  @HiveField(7)
  final CompanyModel company;

  const UserModel(
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        address,
        phone,
        website,
        company,
      ];
}

extension UserModelExtension on UserModel {
  User toUser() {
    return User(
      id: id,
      name: name,
      username: username,
      email: email,
      address: address.toAddress(),
      phone: phone,
      website: website,
      company: company.toCompany(),
    );
  }
}
