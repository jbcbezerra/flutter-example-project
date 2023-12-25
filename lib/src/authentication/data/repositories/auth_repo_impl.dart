import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/core/utilities/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDatasource _remoteDataSource;

  const AuthRepoImpl(this._remoteDataSource);

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getAllUsers() async {
    try {
      final users = await _remoteDataSource.getAllUsers();
      return Right(users);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
