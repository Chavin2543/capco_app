import 'dart:io';
import 'package:capco_app/base/exceptions/network/network_exceptions.dart';
import 'package:capco_app/scene/user/data/datasources/users_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late UserRemoteDataSourceImpl remoteDataSourceImpl;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    remoteDataSourceImpl = UserRemoteDataSourceImpl(client: mockClient);
    registerFallbackValue(Uri());
  });

  void setUpMockHttpClient(String fixtureName, int statusCode) {
    when(() => mockClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((invocation) async => http.Response(
              fixture(fixtureName),
              statusCode,
              headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              },
            ));
  }

  group('GET User', () {
    test(
        'Should return a list of User models when a status code of 200 is received',
        () async {
      // Arrange
      setUpMockHttpClient('users.json', 200);
      // Act
      final users = await remoteDataSourceImpl.getUsers();
      // Assert
      expect(users.length, equals(10));
    });

    test('should throw an exception when a status code of 400 is received',
        () async {
      // Arrange
      setUpMockHttpClient('users.json', 400);
      // Act
      // Assert
      expect(
          () => remoteDataSourceImpl.getUsers(),
          throwsA(predicate(
              (e) => e is NetworkException && e.message == 'Bad Request')));
    });

    test('should throw an exception when a status code of 401 is received',
        () async {
      // Arrange
      setUpMockHttpClient('users.json', 401);
      // Act
      // Assert
      expect(
          () => remoteDataSourceImpl.getUsers(),
          throwsA(predicate(
              (e) => e is NetworkException && e.message == 'Unauthorized')));
    });

    test('should throw an exception when a status code of 500 is received',
        () async {
      // Arrange
      setUpMockHttpClient('users.json', 500);
      // Act
      // Assert
      expect(
          () => remoteDataSourceImpl.getUsers(),
          throwsA(predicate((e) =>
              e is NetworkException && e.message == 'Internal Server Error')));
    });

    test(
        'should throw an exception of Unknown Error when a non recognised status code is received',
        () async {
      // Arrange
      setUpMockHttpClient('users.json', 300);
      // Act
      // Assert
      expect(
          () => remoteDataSourceImpl.getUsers(),
          throwsA(predicate(
              (e) => e is NetworkException && e.message == 'Unknown Error')));
    });

    test('should throw when http library fail', () async {
      // Arrange
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenThrow(const NetworkException(message: "Other Exception to string"));
      // Act
      expect(
              () => remoteDataSourceImpl.getUsers(),
          throwsA(predicate(
                  (e) => e is NetworkException && e.message == 'Other Exception to string')));
      // Assert

    });
  });
}
