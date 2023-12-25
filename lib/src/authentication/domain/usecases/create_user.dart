import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/utilities/typedef.dart';

class CreateUser {
  final AuthenticationRepository _repository;

  const CreateUser(this._repository);

  ResultVoid createUser(
          {required String createdAt,
          required String name,
          required String avatar}) async =>
      _repository.createUser(createdAt: createdAt, name: name, avatar: avatar);
}
