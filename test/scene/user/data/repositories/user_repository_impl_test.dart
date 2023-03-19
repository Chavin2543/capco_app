import 'dart:convert';
import 'package:capco_app/base/exceptions/local/local_exceptions.dart';
import 'package:capco_app/base/exceptions/network/network_exceptions.dart';
import 'package:capco_app/base/models/failure.dart';
import 'package:capco_app/scene/user/data/datasources/users_local_data_source.dart';
import 'package:capco_app/scene/user/data/datasources/users_remote_data_source.dart';
import 'package:capco_app/scene/user/data/models/user_model.dart';
import 'package:capco_app/scene/user/data/repositories/user_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockUserLocalDataSource extends Mock implements UserLocalDatasource {}

void main() {
  late UserRepositoryImpl repositoryImpl;
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockUserLocalDataSource mockUserLocalDataSource;

  final cachedUserModels = (json.decode(fixture('cache_users.json')) as List)
      .map((e) => UserModel.fromJson(e))
      .toList();
  final userModels = (json.decode(fixture('users.json')) as List)
      .map((e) => UserModel.fromJson(e))
      .toList();
  final userEntitiesFromRemote = userModels.map((e) => e.toUser()).toList();
  final userEntitiesFromLocal =
      cachedUserModels.map((e) => e.toUser()).toList();

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockUserLocalDataSource = MockUserLocalDataSource();
    repositoryImpl = UserRepositoryImpl(
        localDataSource: mockUserLocalDataSource,
        remoteDataSource: mockUserRemoteDataSource);
  });

  group('Get Users', () {
    test(
        'Should return remote data when call to remote data source is successful',
        () async {
      // Arrange
      when(() => mockUserRemoteDataSource.getUsers())
          .thenAnswer((invocation) async => userModels);
      // Act
      final result = await repositoryImpl.getUsers();
      final resultFolded =
          result.fold((l) => ServerFailure(message: l.toString()), (r) => r);
      // Assert
      verify(() => mockUserRemoteDataSource.getUsers());
      expect(result.isRight(), true);
      expect(resultFolded, userEntitiesFromRemote);
      expect(resultFolded, equals(userEntitiesFromRemote));
    });

    test('Users are saved to cache when retrieved from remote data source',
        () async {
      // Arrange
      when(() => mockUserRemoteDataSource.getUsers())
          .thenAnswer((invocation) async => userModels);
      // Act
      await repositoryImpl.getUsers();
      // Assert
      verify(() => mockUserRemoteDataSource.getUsers());
      verify(() => mockUserLocalDataSource.saveUsers(userModels));
    });

    test(
        'Should return failure when remote data source and local data source fail',
        () async {
      // Arrange
      when(() => mockUserRemoteDataSource.getUsers())
          .thenThrow(const NetworkException(message: 'Error'));
      when(() => mockUserLocalDataSource.getUsers())
          .thenThrow(const CacheException(message: "Cached User is Empty"));
      // Act
      final result = await repositoryImpl.getUsers();
      final resultFolded =
          result.fold((l) => ServerFailure(message: l.toString()), (r) => r);
      // Assert
      verify(() => mockUserRemoteDataSource.getUsers());
      verify(() => mockUserLocalDataSource.getUsers());
      expect(result.isLeft(), true);
      expect(resultFolded, ServerFailure(message: 'Error'));
    });

    test('Users are retrieved from cache when call to remote data source fails',
        () async {
      // Arrange
      when(() => mockUserRemoteDataSource.getUsers())
          .thenThrow(const NetworkException(message: 'Error'));
      when(() => mockUserLocalDataSource.getUsers())
          .thenAnswer((invocation) async => cachedUserModels);
      // Act
      final result = await repositoryImpl.getUsers();
      final resultFolded =
          result.fold((l) => ServerFailure(message: l.toString()), (r) => r);
      // Assert
      verify(() => mockUserRemoteDataSource.getUsers());
      verify(() => mockUserLocalDataSource.getUsers());
      expect(result.isRight(), true);
      expect(resultFolded, userEntitiesFromLocal);
      expect(resultFolded, equals(userEntitiesFromLocal));
    });
  });
}
