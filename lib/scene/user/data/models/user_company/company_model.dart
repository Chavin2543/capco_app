import 'package:capco_app/scene/user/domain/entities/user/company/company.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_model.g.dart';

@JsonSerializable(includeIfNull: true)
@HiveType(typeId: 3)
class CompanyModel extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String catchPhrase;

  @HiveField(2)
  final String bs;

  const CompanyModel({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        catchPhrase,
        bs,
      ];
}

extension CompanyModelExtension on CompanyModel {
  Company toCompany() => Company(
        name: name,
        catchPhrase: catchPhrase,
        bs: bs,
      );
}
