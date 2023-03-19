import 'dart:convert';
import 'dart:io';

import 'package:capco_app/scene/user/data/models/user_model.dart';

String fixture(String name) =>
    File('test/scene/user/fixtures/$name').readAsStringSync();

List<UserModel> getMockUsers() {
  return (json.decode(fixture('users.json')) as List)
      .map((e) => UserModel.fromJson(e))
      .toList();
}