import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/get_users.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final CreateUser _createUser;
  final GetUsers _getUsers;

  AuthCubit({required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthInitial());

  Future<void> createUserHandler(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    emit(const CreatingUser());

    final result = await _createUser(
        CreateUserParams(createdAt: createdAt, name: name, avatar: avatar));

    result.fold((failure) => emit(AuthError(failure.errorMessage)),
        (_) => emit(const UserCreated()));
  }

  Future<void> getUsersHandler() async {
    emit(const GettingUsers());

    final result = await _getUsers();

    result.fold((failure) => emit(AuthError(failure.errorMessage)),
        (users) => emit(UsersLoaded(users)));
  }
}
