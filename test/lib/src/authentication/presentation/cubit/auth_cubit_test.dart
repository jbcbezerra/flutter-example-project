import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/auth_cubit.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsersUsecase;
  late CreateUser createUserUsecase;
  late AuthCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tApiFailure = ApiFailure(msg: 'message', statusCode: 400);

  setUp(() {
    getUsersUsecase = MockGetUsers();
    createUserUsecase = MockCreateUser();
    cubit = AuthCubit(createUser: createUserUsecase, getUsers: getUsersUsecase);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());

  test('initial state should be [AuthInitial]', () async {
    expect(cubit.state, const AuthInitial());
  });

  group('creatingUser', () {
    blocTest('should emit [CreatingUser, UserCreated] when successful',
        build: () {
          when(() => createUserUsecase(any()))
              .thenAnswer((_) async => const Right(null));
          return cubit;
        },
        act: (cubit) => cubit.createUserHandler(
            createdAt: tCreateUserParams.createdAt,
            name: tCreateUserParams.name,
            avatar: tCreateUserParams.avatar),
        expect: () => const [CreatingUser(), UserCreated()],
        verify: (_) {
          verify(() => createUserUsecase(tCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUserUsecase);
        });

    blocTest('should emit [CreatingUser, AuthError] when unsuccessful',
        build: () {
          when(() => createUserUsecase(any()))
              .thenAnswer((_) async => const Left(tApiFailure));
          return cubit;
        },
        act: (cubit) => cubit.createUserHandler(
            createdAt: tCreateUserParams.createdAt,
            name: tCreateUserParams.name,
            avatar: tCreateUserParams.avatar),
        expect: () =>
            [const CreatingUser(), AuthError(tApiFailure.errorMessage)],
        verify: (_) {
          verify(() => createUserUsecase(tCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUserUsecase);
        });
  });

  group('gettingUsers', () {
    List<User> users = [const User.empty()];

    blocTest('should emit [GettingUsers, UsersLoaded] when successful',
        build: () {
          when(() => getUsersUsecase()).thenAnswer((_) async => Right(users));
          return cubit;
        },
        act: (cubit) => cubit.getUsersHandler(),
        expect: () => [const GettingUsers(), UsersLoaded(users)],
        verify: (_) {
          verify(() => getUsersUsecase()).called(1);
          verifyNoMoreInteractions(getUsersUsecase);
        });

    blocTest('should emit [GettingUsers, AuthError] when unsuccessful',
        build: () {
          when(() => getUsersUsecase())
              .thenAnswer((_) async => const Left(tApiFailure));
          return cubit;
        },
        act: (cubit) => cubit.getUsersHandler(),
        expect: () =>
            [const GettingUsers(), AuthError(tApiFailure.errorMessage)],
        verify: (_) {
          verify(() => getUsersUsecase()).called(1);
          verifyNoMoreInteractions(getUsersUsecase);
        });
  });
}
