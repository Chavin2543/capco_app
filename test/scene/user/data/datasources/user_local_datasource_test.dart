import 'dart:convert';

import 'package:capco_app/base/exceptions/local/local_exceptions.dart';
import 'package:capco_app/scene/user/data/datasources/user_hive_helper.dart';
import 'package:capco_app/scene/user/data/datasources/users_local_data_source.dart';
import 'package:capco_app/scene/user/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../fixtures/fixture_reader.dart';

class MockUserHiveHelper extends Mock implements UserHiveHelper {}

void main() {
  late UserLocalDatasourceImpl localDataSourceImpl;
  late MockUserHiveHelper hive;

  setUp(() {
    hive = MockUserHiveHelper();
    localDataSourceImpl = UserLocalDatasourceImpl(hive: hive);
  });

  final expectedResult = (json.decode(fixture('cache_users.json')) as List)
      .map((e) => UserModel.fromJson(e))
      .toList();

  group('Get Users', () {
    test('Should return a list of users from cache when there is data in cache',
        () async {
      // Arrange
      when(() => hive.getUsers())
          .thenAnswer((invocation) => Future.value(expectedResult));
      // Act
      final users = await localDataSourceImpl.getUsers();
      // Assert
      expect(users, expectedResult);
    });

    test('Should throw a cache exception cache when there is no data in cache',
        () async {
      // Arrange
      when(() => hive.getUsers())
          .thenAnswer((invocation) => Future.value(List.empty()));
      // Act
      // Assert
      expect(() async => localDataSourceImpl.getUsers(),
          throwsA(predicate((e) => e is CacheException)));
    });
  });

  group('Save Users', () {
    test('Should call Hive to cache data', () async {
      // Arrange
      when(() => hive.saveUsers(any()))
          .thenAnswer((invocation) => Future.value(true));
      // Act
      await localDataSourceImpl.saveUsers(expectedResult);
      // Assert
      verify(() => hive.saveUsers(expectedResult)).called(1);
      verifyNoMoreInteractions(hive);
    });
  });
}
