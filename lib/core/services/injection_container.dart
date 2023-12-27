import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/src/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:tdd_tutorial/src/authentication/data/repositories/auth_repo_impl.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/auth_repo.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/auth_cubit.dart';

import '../../src/authentication/domain/usecases/get_users.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // blocs
  sl.registerFactory(() => AuthCubit(createUser: sl(), getUsers: sl()));

  // usecases
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => GetUsers(sl()));

  // repositories
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));

  // datasource
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(sl()));

  //externals
  sl.registerLazySingleton(http.Client.new);
}
