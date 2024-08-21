import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/core.dart';
import 'package:tdd_tutorial/src/authentication/domain/domain.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(
    this._repository,
  );

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams(
      {required this.createdAt, required this.name, required this.avatar});

  const CreateUserParams.empty()
      : this(
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.avatar',
        );

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
