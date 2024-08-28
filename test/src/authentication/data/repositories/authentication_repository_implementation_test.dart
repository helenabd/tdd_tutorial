import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tdd_tutorial/core/core.dart';
import 'package:tdd_tutorial/core/errors/errors.dart';
import 'package:tdd_tutorial/src/authentication/authentication.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException = APIException(
    message: 'Unknown Error Occured',
    statusCode: 500,
  );

  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';

    test(
        'should call the [RemoteDataSource.createUser] and complete '
        'successfully when the call to the remote source is successful',
        () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
        // So whenever you're returning void, you should use Future.value() instead.
      ).thenAnswer((_) async => Future.value());

      //Act - Call the function that is to be tested
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      //Assert - Compare the actual result and expected result
      expect(result, equals(const Right(null)));
      verify(
        () => remoteDataSource.createUser(
            createdAt: createdAt, name: name, avatar: avatar),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [ServerFailure] when the call to the remote'
        'source is unsuccessfull', () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
        // So whenever you're returning void, you should use Future.value() instead.
      ).thenThrow(tException);

      //Act - Call the function that is to be tested
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      //Assert - Compare the actual result and expected result
      expect(
        result,
        equals(
          Left(
            APIFailure(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          ),
        ),
      );
      verify(
        () => remoteDataSource.createUser(
            createdAt: createdAt, name: name, avatar: avatar),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
