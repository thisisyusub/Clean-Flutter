import 'package:equatable/equatable.dart';

import '../../../../../shared/domain/user.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersInitial extends UsersState {
  @override
  List<Object?> get props => [];
}

class UsersInProgress extends UsersState {
  @override
  List<Object?> get props => [];
}

class UsersFailure extends UsersState {
  const UsersFailure(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}

class UsersSuccess extends UsersState {
  const UsersSuccess(this.users);

  final List<User> users;

  @override
  List<Object?> get props => [users];
}
