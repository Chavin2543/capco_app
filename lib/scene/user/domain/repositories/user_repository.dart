import 'package:capco_app/scene/user/domain/entities/user/user.dart';
import 'package:dartz/dartz.dart';
import '../../../../base/models/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
}
