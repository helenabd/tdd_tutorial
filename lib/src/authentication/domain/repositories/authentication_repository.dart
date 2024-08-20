import 'package:dartz/dartz.dart';

import '../domain.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  Future<Either<Exception, void>> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<(Exception, List<User>)> getUsers();
}
