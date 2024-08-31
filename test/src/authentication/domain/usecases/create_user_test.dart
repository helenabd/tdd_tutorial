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

import 'authentication_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test('should call the create user ', () async {
    //Arrange - Setup facts, Put Expected outputs or Initilize
    when(
      () => repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null));

    //Act - Call the function that is to be tested
    final result = await usecase.call(params);

    //Assert - Compare the actual result and expected result
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
