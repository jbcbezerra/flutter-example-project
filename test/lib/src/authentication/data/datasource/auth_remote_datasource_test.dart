import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/utilities/constants.dart';
import 'package:tdd_tutorial/src/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDatasourceImpl datasourceImpl;

  setUp(() {
    client = MockClient();
    datasourceImpl = AuthRemoteDatasourceImpl(client);
    registerFallbackValue(Uri());
  });

  const tException = ApiException(msg: 'Invalid Email', statusCode: 400);
  const tException2 = ApiException(msg: 'Server down.', statusCode: 500);

  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';

    test('should complete successfully when the status code is 200 or 201',
        () async {
      // arrange
      when(() => client.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer(
              (_) async => http.Response('User created successfully', 201));

      // act
      final methodCall = datasourceImpl.createUser;

      // assert
      expect(methodCall(createdAt: createdAt, name: name, avatar: avatar),
          completes);
      verify(() => client.post(Uri.https(kBaseUrl, kEndpointPath),
          body: jsonEncode(
              {'createdAt': createdAt, 'name': name, 'avatar': avatar}),
          headers: {'Content-Type': 'application/json'})).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 200 or 201',
        () async {
      // arrange
      when(() =>
          client.post(any(),
              body: any(named: 'body'),
              headers: any(named: 'headers'))).thenAnswer(
          (_) async => http.Response(tException.msg, tException.statusCode));

      // act
      final methodCall = datasourceImpl.createUser;

      // assert
      expect(
          () => methodCall(createdAt: createdAt, name: name, avatar: avatar),
          throwsA(ApiException(
              msg: tException.msg, statusCode: tException.statusCode)));
      verify(() => client.post(Uri.https(kBaseUrl, kEndpointPath),
          body: jsonEncode(
              {'createdAt': createdAt, 'name': name, 'avatar': avatar}),
          headers: {'Content-Type': 'application/json'})).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('getAllUsers', () {
    final tModel = const UserModel.empty();
    final tUsers = [tModel];

    test('should return [List<User>] when the status code is 200', () async {
      // arrange
      when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200));

      // act
      final result = await datasourceImpl.getAllUsers();

      // assert
      expect(result, equals(tUsers));
      verify(() => client.get(Uri.https(kBaseUrl, kEndpointPath))).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw [ApiException] when the status code is not 200',
        () async {
      // arrange
      when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(tException2.msg, tException2.statusCode));

      // act
      final methodCall = datasourceImpl.getAllUsers;

      // assert
      expect(
          () => methodCall(),
          throwsA(ApiException(
              msg: tException2.msg, statusCode: tException2.statusCode)));
      verify(() => client.get(Uri.https(kBaseUrl, kEndpointPath))).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
