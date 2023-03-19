import 'package:capco_app/scene/user/data/datasources/users_local_data_source.dart';
import 'package:capco_app/scene/user/data/models/user_model.dart';
import 'package:hive/hive.dart';

class UserHiveHelper implements UserLocalDatasource {
  @override
  Future<List<UserModel>> getUsers() async {
    final box = await Hive.openBox<UserModel>('user');
    final users = box.values.toList().cast<UserModel>();
    return users;
  }

  @override
  saveUsers(List<UserModel> userModels) async {
    final box = await Hive.openBox<UserModel>('user');
    box.clear();
    for (var user in userModels) {
      box.add(user);
    }
  }
}