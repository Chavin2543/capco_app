import 'package:capco_app/base/models/failure.dart';
import 'package:capco_app/scene/user/domain/entities/user/address/address.dart';
import 'package:capco_app/scene/user/domain/entities/user/address/geo.dart';
import 'package:capco_app/scene/user/domain/entities/user/company/company.dart';
import 'package:capco_app/scene/user/domain/entities/user/user.dart';
import 'package:capco_app/scene/user/domain/repositories/user_repository.dart';
import 'package:capco_app/scene/user/domain/usecases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

main() {
  late GetUsers usecase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetUsers(repository: mockUserRepository);
  });

  final users = [
    const User(
      id: 10,
      name: "Clementina DuBuque",
      username: "Moriah.Stanton",
      email: "Rey.Padberg@karina.biz",
      address: Address(
          street: "Kattie Turnpike",
          suite: "Suite 198",
          city: "Lebsackbury",
          zipcode: "31428-2261",
          geo: Geo(lng: "57.2232", lat: "-38.2386")),
      phone: "024-648-3804",
      website: "ambrose.net",
      company: Company(
        name: 'Hoeger LLC',
        catchPhrase: 'Centralized empowering task-force',
        bs: 'target end-to-end models',
      ),
    )
  ];

  group('Retrieve users from repository', () {
    test('Should return entity from repository when call is successfull',
        () async {
      // Arrange
      when(() => mockUserRepository.getUsers())
          .thenAnswer((invocation) async => Right(users));
      // Act
      final result = await usecase.execute();
      // Assert
      expect(result, Right(users));
      verify(() => mockUserRepository.getUsers());
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('Should return failure from repository when call is unsuccessfull',
        () async {
      // Arrange
      final errorMessage = ServerFailure(message: "Internal Server Error");
      when(() => mockUserRepository.getUsers())
          .thenAnswer((invocation) async => Left(errorMessage));
      // Act
      final result = await usecase.execute();
      // Assert
      expect(result, Left(errorMessage));
      verify(() => mockUserRepository.getUsers());
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
