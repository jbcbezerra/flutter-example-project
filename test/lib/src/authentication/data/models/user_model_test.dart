import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/core/utilities/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';
import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  final tJson = fixtures('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  test('should be a subclass of [User] entity', () {
    //Assert
    expect(tModel, isA<User>());
  });

  group('fromMap', () {
    test("should return a [UserModel] with the right data", () {
      // Act
      final result = UserModel.fromMap(tMap);

      // Assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test("should return a [UserModel] with the right data", () {
      // Act
      final result = UserModel.fromJson(tJson);

      // Assert
      expect(result, tModel);
    });
  });

  group('toMap', () {
    test("should return a [Map] with the right data", () {
      // Act
      final result = tModel.toMap();

      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test("should return a [JSON] String with the right data", () {
      // Act
      final result = tModel.toJson();

      // Assert
      expect(result, equals(normalizeString(tJson)));
    });
  });

  group('copyWith', () {
    test("should return a [UserModel] with different data", () {
      // Act
      final result = tModel.copyWith(name: "Paul");

      // Assert
      expect(result.name, equals("Paul"));
    });
  });
}

String normalizeString(String input) {
  return input.replaceAll(RegExp(r'\s'), '');
}
