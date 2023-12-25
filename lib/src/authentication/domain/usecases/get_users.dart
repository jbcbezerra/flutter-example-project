import 'package:tdd_tutorial/core/usecase/usecase.dart';
import 'package:tdd_tutorial/core/utilities/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/auth_repo.dart';

class GetUsers extends UsecaseWithoutParameters<List<User>> {
  final AuthRepo _repository;

  const GetUsers(this._repository);

  @override
  ResultFuture<List<User>> call() {
    return _repository.getAllUsers();
  }
}
