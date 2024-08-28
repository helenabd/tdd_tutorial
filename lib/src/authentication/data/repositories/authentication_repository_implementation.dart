import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/core.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';

import '../../authentication.dart';

// Dependency inversion is simply what we do when we take the dependency
// in the constructor. It simply means that we're creating a space for injection
// to occur.
// If we wanted to inject something into this class and there's no space for
// us to inject something into it, then there's no way for that injection to
// happen. But if we want it to create a space for injection, we do that through
// the constructor.
// Instead of creating that multiple times, we simply inject it into the class.
// This make our code testable

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;

  AuthenticationRepositoryImplementation(this._remoteDataSource);

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    // Test-Driven Development
    // call the remote data source
    // check if the method returns the proper data
    // // check if when the remoteDataSource throws an exception, we return a
    // failure and if it doesn't throw and exception, we return the actual
    // expected data
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
