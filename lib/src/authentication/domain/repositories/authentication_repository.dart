import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';

import '../entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  Future<Either<Failure, void>> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<Either<Failure, List<User>>> getAllUserss();
}
