import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String createdAt;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id];
}

void main() {
  final user1 = User(
    id: 1,
    createdAt: 'createdAt',
    name: 'name',
    avatar: 'avatar',
  );
  final user2 = User(
    id: 2,
    createdAt: 'createdAt',
    name: 'name',
    avatar: 'avatar',
  );

  print(user1 == user2);
}
