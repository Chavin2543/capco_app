import 'package:capco_app/scene/user/domain/entities/user/user.dart';
import 'package:capco_app/scene/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../base/models/failure.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers({required this.repository});

  Future<Either<Failure, List<User>>> execute() async {
    return repository.getUsers();
  }
}
