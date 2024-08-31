import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/src/authentication/authentication.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App Logic
    ..registerFactory(() => AuthenticationCubit(
        createUser: sl(), getUsers: sl())) //Presentation layer

    // Use cases
    ..registerLazySingleton(() => CreateUser(sl())) //Domain layer
    ..registerLazySingleton(() => GetUsers(sl())) //Domain layer

    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl())) //Data layer

    // Data Sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImpl(sl())) //Data layer

    // External dependencies
    ..registerLazySingleton(http.Client.new);
}
