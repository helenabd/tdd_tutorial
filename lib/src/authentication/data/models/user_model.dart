import 'dart:convert';

import 'package:tdd_tutorial/core/core.dart';

import '../../authentication.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  const UserModel.empty()
      : this(
          id: "1",
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.avatar',
        );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          avatar: map['avatar'] as String,
          name: map['name'] as String,
          createdAt: map['createdAt'] as String,
          id: map['id'] as String,
        );

  UserModel copyWith({
    String? avatar,
    String? name,
    String? createdAt,
    String? id,
  }) {
    return UserModel(
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  DataMap toMap() => {
        'id': id,
        'createdAt': createdAt,
        'avatar': avatar,
        'name': name,
      };

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [id, name, avatar];
}
