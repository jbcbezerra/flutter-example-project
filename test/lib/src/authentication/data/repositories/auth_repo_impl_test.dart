import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/data/repositories/auth_repo_impl.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

void main() {
  late AuthRemoteDatasource remoteDatasource;
  late AuthRepoImpl repoImpl;

  setUp(() {
    remoteDatasource = MockAuthRemoteDatasource();
    repoImpl = AuthRepoImpl(remoteDatasource);
  });

  const tException = ApiException(msg: 'Unkown Error Occured', statusCode: 500);

  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';

    test(
        'should call the [RemoteDataSource.createUser] and complete'
        'successfully when the call to the remote source is successful',
        () async {
      // Arrange
      when(() => remoteDatasource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenAnswer((_) async => Future.value());

      // act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // assert
      expect(result, equals(const Right(null)));
      verify(() => remoteDatasource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });

    test(
        'should return a [ServerFailure] when the call to the source is unsuccessful',
        () async {
      // arrange
      when(() => remoteDatasource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'))).thenThrow(tException);

      // act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // assert
      expect(
          result,
          equals(Left(ApiFailure(
              msg: tException.msg, statusCode: tException.statusCode))));
      verify(() => remoteDatasource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });
  });

  group('getAllUsers', () {
    const tResponse = [UserModel.empty()];

    test(
        'should call the [RemoteDataSource.getAllUsers] and return'
        '[List<UserModel] when the call to the remote source is successful',
        () async {
      // Arrange
      when(() => remoteDatasource.getAllUsers())
          .thenAnswer((_) async => Future.value(tResponse));

      // act
      final result = await repoImpl.getAllUsers();

      // assert
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDatasource.getAllUsers()).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });

    test(
        'should return a [ServerFailure] when the call to the source is unsuccessful',
        () async {
      // arrange
      when(() => remoteDatasource.getAllUsers()).thenThrow(tException);

      // act
      final result = await repoImpl.getAllUsers();

      // assert
      expect(
          result,
          equals(Left(ApiFailure(
              msg: tException.msg, statusCode: tException.statusCode))));
      verify(() => remoteDatasource.getAllUsers()).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });
  });
}
