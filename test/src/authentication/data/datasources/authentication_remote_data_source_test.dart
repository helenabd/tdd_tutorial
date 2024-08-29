import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/core.dart';

import 'package:tdd_tutorial/src/authentication/data/data.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully when the status code is 200 or 201',
        () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(
        () => client.post(any(), body: any(named: 'body')),
      ).thenAnswer(
        (_) async => http.Response('User created successfully', 201),
      );

      //Act - Call the function that is to be tested
      final methodCall = remoteDataSource.createUser;

      //Assert - Compare the actual result and expected result
      expect(
          methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          completes);

      verify(
        () => client.post(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200 or 201',
        () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(
        () => client.post(any(), body: any(named: 'body')),
      ).thenAnswer(
        (_) async => http.Response('Invalid email address', 400),
      );

      //Act - Call the function that is to be tested
      final methodCall = remoteDataSource.createUser;

      //Assert - Compare the actual result and expected result
      expect(
          () async => methodCall(
                createdAt: 'createdAt',
                name: 'name',
                avatar: 'avatar',
              ),
          throwsA(const APIException(
              message: 'Invalid email address', statusCode: 400)));

      verify(
        () => client.post(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers', () {
    final tUsers = [const UserModel.empty()];
    test('should return a [List<User>] when the status code is 200', () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(
        () => client.get(any()),
      ).thenAnswer(
        (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
      );

      //Act - Call the function that is to be tested
      final result = await remoteDataSource.getUsers();

      //Assert - Compare the actual result and expected result
      expect(result, equals(tUsers));

      verify(
        () => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200',
        () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(
        () => client.get(any()),
      ).thenAnswer(
        (_) async => http.Response(
          'Server down, Server down,'
          'I repeat Server down',
          500,
        ),
      );

      //Act - Call the function that is to be tested
      final methodCall = remoteDataSource.getUsers;

      //Assert - Compare the actual result and expected result
      expect(
        methodCall(),
        throwsA(
          const APIException(
            message: 'Server down, Server down,'
                'I repeat Server down',
            statusCode: 500,
          ),
        ),
      );

      verify(
        () => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
