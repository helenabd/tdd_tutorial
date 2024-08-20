import '../../../../core/core.dart';
import '../domain.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  // NOTES: Not state the actual failure that you're expecting, because in this way,
  // when we do this, if the type of failure changes, we don't have to go into
  // all of our repositories to change them
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  ResultFuture<List<User>> getUsers();
}
