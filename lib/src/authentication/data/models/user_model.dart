import 'dart:convert';

import 'package:tdd_tutorial/src/authentication/domain/entities/user.dart';

import '../../../../core/utilities/typedef.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.createdAt,
      required super.name,
      required super.avatar});

  factory UserModel.fromJson(String source) =>
      UserModel.fromJson(jsonDecode(source) as String);

  UserModel.fromMap(DataMap map)
      : this(
            id: map['id'] as String,
            createdAt: map['createdAt'] as String,
            name: map['name'] as String,
            avatar: map['avatar'] as String);

  DataMap toMap() =>
      {'id': id, 'createdAt': createdAt, 'name': name, 'avatar': avatar};

  String toJson() => jsonEncode(toMap());

  UserModel copyWith(
      {String? id, String? createdAt, String? name, String? avatar}) {
    return UserModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.avatar,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar);
  }
}
