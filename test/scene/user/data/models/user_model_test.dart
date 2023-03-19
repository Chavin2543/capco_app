import 'dart:convert';

import 'package:capco_app/scene/user/data/models/user_address/address_model.dart';
import 'package:capco_app/scene/user/data/models/user_address/geo_model.dart';
import 'package:capco_app/scene/user/data/models/user_company/company_model.dart';
import 'package:capco_app/scene/user/data/models/user_model.dart';
import 'package:capco_app/scene/user/domain/entities/user/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const model = UserModel(
    10,
    "Clementina DuBuque",
    "Moriah.Stanton",
    "Rey.Padberg@karina.biz",
    AddressModel(
        street: "Kattie Turnpike",
        suite: "Suite 198",
        city: "Lebsackbury",
        zipcode: "31428-2261",
        geo: GeoModel(lng: "57.2232", lat: "-38.2386")),
    "024-648-3804",
    "ambrose.net",
    CompanyModel(
      name: 'Hoeger LLC',
      catchPhrase: 'Centralized empowering task-force',
      bs: 'target end-to-end models',
    ),
  );

  group('Model matches JSON', () {
    test('should successfully convert to a User entity', () {
      // Assert
      expect(model.toUser(), isA<User>());
    });

    test('Should deserialize model from JSON', () {
      // Arrange
      final jsonMap = json.decode(fixture('user_model.json'));
      // Act
      final user = UserModel.fromJson(jsonMap);
      // Assert
      expect(user, equals(model));
      expect(user.id, model.id);
      expect(user.name, model.name);
      expect(user.username, model.username);
      expect(user.address, model.address);
      expect(user.phone, model.phone);
      expect(user.email, model.email);
      expect(user.company, model.company);
    });
  });
}
