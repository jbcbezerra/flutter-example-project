import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:tdd_tutorial/src/authentication/data/repositories/auth_repo_impl.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

void main() {
  late AuthRemoteDatasource remoteDatasource;
  late AuthRepoImpl repoImpl;

  setUp(() {
    remoteDatasource = MockAuthRemoteDatasource();
    repoImpl = AuthRepoImpl(remoteDatasource);
  });

  group('createUser', () {
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

      const createdAt = 'whatever.createdAt';
      const name = 'whatever.name';
      const avatar = 'whatever.avatar';

      // act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // assert
      expect(result, equals(const Right(null)));
      verify(() => remoteDatasource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });
  });
}
