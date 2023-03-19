import 'package:capco_app/scene/user/data/datasources/user_hive_helper.dart';
import 'package:capco_app/scene/user/data/datasources/users_local_data_source.dart';
import 'package:capco_app/scene/user/data/datasources/users_remote_data_source.dart';
import 'package:capco_app/scene/user/data/repositories/user_repository_impl.dart';
import 'package:capco_app/scene/user/domain/repositories/user_repository.dart';
import 'package:capco_app/scene/user/domain/usecases/get_users.dart';
import 'package:capco_app/scene/user/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final injector = GetIt.asNewInstance();

Future<void> inject() async {
  // DataSources
  injector.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: injector()));
  injector.registerLazySingleton<UserLocalDatasource>(
      () => UserLocalDatasourceImpl(hive: injector()));

  // Repositories
  injector.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      remoteDataSource: injector(), localDataSource: injector()));

  // Use cases
  injector.registerLazySingleton(() => GetUsers(repository: injector()));

  // BLoC
  injector.registerFactory(() => UserBloc(getUsersUseCase: injector()));

  // Misc
  injector.registerLazySingleton(() => http.Client());
  injector.registerLazySingleton(() => UserHiveHelper());
}
