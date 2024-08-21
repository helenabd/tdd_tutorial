// What does the class depend on?
// Answer -- AuthenticationRepository
// How can we create a fake version of the dependency?
// Answer -- use Mocktail
// How do we control what our dependencies do?
// Answer -- using the Mocktail's APIs

// thenReturn -- works when your function is asynchronous
// thenAnswer -- works when your function is synchronous, when you have a Future

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tdd_tutorial/src/authentication/authentication.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/get_users.dart';

import 'domain/usecases/authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late GetUsers usecase;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = GetUsers(repository);
  });

  const tResponse = [User.empty()];

  test('should call get users and return a list of users', () async {
    //Arrange - Setup facts, Put Expected outputs or Initilize
    when(
      () => repository.getUsers(),
    ).thenAnswer((_) async => const Right(tResponse));

    //Act - Call the function that is to be tested
    final result = await usecase.call();

    //Assert - Compare the actual result and expected result
    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
    verify(
      () => repository.getUsers(),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
