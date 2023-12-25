import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';

// create mockversion of dependencies
class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository repository;
  late CreateUser usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test("should call the [AuthRepo.createUser]", () async {
    // Arrange
    when(() => repository.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase.call(params);

    // Assert
    expect(result, equals(const Right(null))); // verify return
    verify(() => repository.createUser(
        // verify that function was called once
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar)).called(1);
    verifyNoMoreInteractions(
        repository); // verify no more interaction with repository after previous
  });
}
