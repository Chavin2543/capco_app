import 'package:capco_app/base/exceptions/local/local_exceptions.dart';
import 'package:capco_app/base/exceptions/network/network_exceptions.dart';
import 'package:capco_app/scene/user/data/datasources/users_local_data_source.dart';
import 'package:capco_app/scene/user/data/datasources/users_remote_data_source.dart';
import 'package:capco_app/scene/user/data/models/user_model.dart';
import 'package:capco_app/scene/user/domain/entities/user/user.dart';
import 'package:capco_app/scene/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../base/models/failure.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDatasource localDataSource;

  UserRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final userModels = await remoteDataSource.getUsers();
      await localDataSource.saveUsers(userModels);
      final users = userModels
          .map(
            (e) => e.toUser(),
          )
          .toList();
      return Right(users);
    } on NetworkException catch (error) {
      try {
        final userModels = await localDataSource.getUsers();
        final users = userModels
            .map(
              (e) => e.toUser(),
            )
            .toList();
        return Right(users);
      } on CacheException {
        return Left(
          ServerFailure(message: error.message),
        );
      }
    } catch (error) {
      return Left(
        ServerFailure(
          message: error.toString(),
        ),
      );
    }
  }
}
