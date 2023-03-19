import 'package:capco_app/scene/user/data/datasources/user_hive_helper.dart';
import 'package:capco_app/scene/user/data/models/user_model.dart';

import '../../../../base/exceptions/local/local_exceptions.dart';

abstract class UserLocalDatasource {
  Future<List<UserModel>> getUsers();
  saveUsers(List<UserModel> userModels);
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final UserHiveHelper hive;

  UserLocalDatasourceImpl({required this.hive});

  @override
  Future<List<UserModel>> getUsers() async {
    final users = await hive.getUsers();
    if (users.isNotEmpty) {
      return users;
    } else {
      throw const CacheException(message: "Cached User is Empty");
    }
  }

  @override
  saveUsers(List<UserModel> userModels) {
    return hive.saveUsers(userModels);
  }
}