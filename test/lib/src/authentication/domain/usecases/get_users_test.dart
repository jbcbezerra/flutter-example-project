import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';

import 'authentication_repository_mock.dart';

void main() {
  late AuthenticationRepository repository;
  late GetUsers usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  const tResponse = [User.empty()];
  test("should call the [AuthRepo.getAllUsers]", () async {
    // Arrange
    when(() => repository.getAllUsers())
        .thenAnswer((_) async => const Right(tResponse));

    // Act
    final result = await usecase.call();

    // Assert
    expect(result, equals(const Right(tResponse)));
    verify(() => repository.getAllUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
