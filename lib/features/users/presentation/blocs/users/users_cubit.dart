import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/use_cases/use_case.dart';
import '../../../domain/use_cases/fetch_users.dart';
import 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this.fetchUsers) : super(UsersInitial());

  final FetchUsers fetchUsers;

  void getUsers() async {
    emit(UsersInProgress());
    await Future.delayed(const Duration(seconds: 2));

    final result = await fetchUsers(NoParams());

    result.when(
      error: (failure) => emit(UsersFailure(failure.error)),
      success: (users) {
        emit(UsersSuccess(users));
      },
    );
  }
}
