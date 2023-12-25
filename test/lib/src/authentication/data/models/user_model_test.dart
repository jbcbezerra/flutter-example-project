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
      expect(result, equals(tModel));
    });
  });
}
