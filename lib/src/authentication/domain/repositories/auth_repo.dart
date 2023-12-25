import 'package:tdd_tutorial/core/utilities/typedef.dart';

import '../entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  ResultFuture<List<User>> getAllUsers();
}
