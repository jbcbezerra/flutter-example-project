import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/usecase/usecase.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/auth_repo.dart';

import '../../../../core/utilities/typedef.dart';

class CreateUser extends UsecaseWithParameters<void, CreateUserParams> {
  final AuthRepo _repository;

  const CreateUser(this._repository);

  @override
  ResultVoid call(CreateUserParams params) async {
    return _repository.createUser(
        createdAt: params.createdAt, name: params.name, avatar: params.avatar);
  }
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams.empty()
      : this(
            createdAt: '_empty.string',
            name: '_empty.string',
            avatar: '_empty.string');

  const CreateUserParams(
      {required this.createdAt, required this.name, required this.avatar});

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
