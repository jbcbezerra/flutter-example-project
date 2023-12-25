import 'package:tdd_tutorial/core/utilities/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/datasource/authentication_remote_datasource.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDatasource _remoteDataSource;

  const AuthenticationRepositoryImpl(this._remoteDataSource);

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {}

  @override
  ResultFuture<List<User>> getAllUsers() async {}
}
