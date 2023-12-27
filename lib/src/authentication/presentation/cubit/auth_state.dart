part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

class CreatingUser extends AuthState {
  const CreatingUser();
}

class GettingUsers extends AuthState {
  const GettingUsers();
}

class UserCreated extends AuthState {
  const UserCreated();
}

class UsersLoaded extends AuthState {
  final List<User> users;

  const UsersLoaded(this.users);

  @override
  List<Object> get props => users.map((u) => u.id).toList();
}

class AuthError extends AuthState {
  final String msg;

  const AuthError(this.msg);

  @override
  List<Object> get props => [msg];
}
