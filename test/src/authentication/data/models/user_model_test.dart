// What does the class depend on?
// Answer -- AuthenticationRepository
// How can we create a fake version of the dependency?
// Answer -- use Mocktail
// How do we control what our dependencies do?
// Answer -- using the Mocktail's APIs

// thenReturn -- works when your function is asynchronous
// thenAnswer -- works when your function is synchronous, when you have a Future

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/core/core.dart';

import 'package:tdd_tutorial/src/authentication/authentication.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test('should be a subclass of User entity', () {
    //Assert - Compare the actual result and expected result
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a UserModel with the right data', () {
      //Act - Call the function that is to be tested
      final results = UserModel.fromMap(tMap);

      //Assert - Compare the actual result and expected result
      expect(results, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a UserModel with the right data', () {
      //Act - Call the function that is to be tested
      final results = UserModel.fromJson(tJson);

      //Assert - Compare the actual result and expected result
      expect(results, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a Map with the right data', () {
      //Act - Call the function that is to be tested
      final result = tModel.toMap();
      //Assert - Compare the actual result and expected result
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a JSON with the right data', () {
      //Act - Call the function that is to be tested
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "createdAt": "_empty.createdAt",
        "avatar": "_empty.avatar",
        "name": "_empty.name"
      });
      //Assert - Compare the actual result and expected result
      expect(result, tJson);
    });
  });

  group('copyWith', () {
    test('should return a UserModel with different data', () {
      //Act - Call the function that is to be tested
      final result = tModel.copyWith(name: 'Paul');

      //Assert - Compare the actual result and expected result
      expect(result.name, equals('Paul'));
    });
  });
}
