import 'package:bloc_test/bloc_test.dart';
import 'package:capco_app/base/models/failure.dart';
import 'package:capco_app/scene/user/domain/entities/user/address/address.dart';
import 'package:capco_app/scene/user/domain/entities/user/address/geo.dart';
import 'package:capco_app/scene/user/domain/entities/user/company/company.dart';
import 'package:capco_app/scene/user/domain/entities/user/user.dart';
import 'package:capco_app/scene/user/domain/usecases/get_users.dart';
import 'package:capco_app/scene/user/presentation/bloc/user_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

void main() {
  late MockGetUsers mockGetUsersUsecase;
  late UserBloc userBloc;

  final List<User> users = [
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
    ),
    const User(
      id: 11,
      name: "Clementina DuBuque 2",
      username: "Moriah.Stanton 2",
      email: "Rey.Padberg@karina.biz 2",
      address: Address(
          street: "Kattie Turnpike 2",
          suite: "Suite 198 2",
          city: "Lebsackbury 2",
          zipcode: "31428-2261 2",
          geo: Geo(lng: "57.2232 2", lat: "-38.2386 2")),
      phone: "024-648-3804 2",
      website: "ambrose.net 2",
      company: Company(
        name: 'Hoeger LLC 2',
        catchPhrase: 'Centralized empowering task-force 2',
        bs: 'target end-to-end models 2',
      ),
    )
  ];

  setUp(() {
    mockGetUsersUsecase = MockGetUsers();
    userBloc = UserBloc(getUsersUseCase: mockGetUsersUsecase);
  });

  group('GET Users Usecase', () {
    test('Inital bloc state should be UsersInitial', () {
      expect(userBloc.state, equals(UserInitial()));
    });

    test('Bloc calls GetUsers usecase', () async {
      // Arrange
      when(() => mockGetUsersUsecase.execute())
          .thenAnswer((invocation) async => Right(users));
      // Act
      userBloc.add(GetUsersEvent());
      await untilCalled(
              () => mockGetUsersUsecase.execute());
      // Assert
      verify(() => mockGetUsersUsecase.execute());
    });

    blocTest(
      'Should emit correct order or states when GetUsers is called with success',
      build: () {
        when(() => mockGetUsersUsecase.execute())
            .thenAnswer((invocation) async => Right(users));
        return userBloc;
      },
      act: (_) {
        return userBloc.add(GetUsersEvent());
      },
      expect: () {
        return [UsersLoading(), UsersLoadedWithSuccess(users: users)];
      },
    );

    blocTest(
      'Should emit correct order or states when GetUsers is called with error',
      build: () {
        when(() => mockGetUsersUsecase.execute())
            .thenAnswer(
                (invocation) async => Left(ServerFailure(message: 'Error')));
        return userBloc;
      },
      act: (_) {
        return userBloc.add(GetUsersEvent());
      },
      expect: () {
        return [UsersLoading(), UsersLoadedWithError(message: 'Error')];
      },
    );

    blocTest(
      'Should emit correct order or states when GetUsers is called with local error',
      build: () {
        when(() => mockGetUsersUsecase.execute())
            .thenAnswer(
                (invocation) async => Left(CacheFailure(message: 'Error')));
        return userBloc;
      },
      act: (_) {
        return userBloc.add(GetUsersEvent());
      },
      expect: () {
        return [UsersLoading(), UsersLoadedWithError(message: 'Error')];
      },
    );
  });
}