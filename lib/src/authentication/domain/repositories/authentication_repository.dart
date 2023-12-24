import 'package:dartz/dartz.dart';

import '../entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  Future<Either<Exception,void>> createUser({required String createdAt, required String name, required String avatar});
  Future<Either<Exception,List<User>>> getAllUsers();
}
