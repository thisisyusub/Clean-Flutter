import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_clean_tutorial/core/use_cases/use_case.dart';
import 'package:flutter_clean_tutorial/features/users/presentation/blocs/users/users_cubit.dart';
import 'package:flutter_clean_tutorial/features/users/presentation/blocs/users/users_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_tutorial/core/error/failure.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_clean_tutorial/core/either.dart';

import '../../../../mocks/generated.mocks.dart';
import '../../../../mocks/mock_data.dart';

void main() {
  group(
    'UserCubit',
    () {
      late final MockFetchUsers fetchUsers;

      setUpAll(
        () {
          fetchUsers = MockFetchUsers();
        },
      );

      blocTest<UsersCubit, UsersState>(
        'should emit empty if nothing happened',
        build: () => UsersCubit(fetchUsers),
        expect: () => [],
      );

      blocTest<UsersCubit, UsersState>(
        'should emit [Failure] if something went wrong',
        build: () => UsersCubit(fetchUsers),
        setUp: () {
          when(fetchUsers(any)).thenAnswer(
            (_) async => const Error(
              Failure.network('error!'),
            ),
          );
        },
        act: (cubit) => cubit.getUsers(),
        expect: () => [
          UsersInProgress(),
          const UsersFailure('error!'),
        ],
        verify: (_) {
          verify(fetchUsers(NoParams()));
          verifyNoMoreInteractions(fetchUsers);
        },
      );

      blocTest<UsersCubit, UsersState>(
        'should emit [Success] if it is okay',
        build: () => UsersCubit(fetchUsers),
        setUp: () {
          when(fetchUsers(any)).thenAnswer(
            (_) async => const Success(mockUsers),
          );
        },
        act: (cubit) => cubit.getUsers(),
        expect: () => [
          UsersInProgress(),
          const UsersSuccess(mockUsers),
        ],
        verify: (_) {
          verify(fetchUsers(NoParams()));
          verifyNoMoreInteractions(fetchUsers);
        },
      );
    },
  );
}
