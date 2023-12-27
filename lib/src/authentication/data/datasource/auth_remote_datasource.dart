import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/utilities/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

import '../../../../core/utilities/constants.dart';

abstract class AuthRemoteDatasource {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<List<UserModel>> getAllUsers();
}

const kEndpointPath = '$kEndpointPrefix/$kEndpointVersion/$kEndpointUsers';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client _client;

  const AuthRemoteDatasourceImpl(this._client);

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await _client.post(Uri.https(kBaseUrl, kEndpointPath),
          body: jsonEncode(
              {'createdAt': createdAt, 'name': name, 'avatar': avatar}),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(msg: response.body, statusCode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(msg: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await _client.get(Uri.https(kBaseUrl, kEndpointPath));

      if (response.statusCode != 200) {
        throw ApiException(msg: response.body, statusCode: response.statusCode);
      }

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(msg: e.toString(), statusCode: 505);
    }
  }
}
