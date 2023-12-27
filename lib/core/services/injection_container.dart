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
  sl
    ..registerFactory(() => AuthCubit(createUser: sl(), getUsers: sl()))

    // usecases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // repositories
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))

    // datasource
    ..registerLazySingleton<AuthRemoteDatasource>(
        () => AuthRemoteDatasourceImpl(sl()))

    //externals
    ..registerLazySingleton(http.Client.new);
}
