import 'package:dio/dio.dart';
import 'package:flutter_clean_tutorial/core/either.dart';
import 'package:flutter_clean_tutorial/core/error/failure.dart';
import 'package:flutter_clean_tutorial/features/users/data/repositories/user_repository_impl.dart';
import 'package:flutter_clean_tutorial/features/users/domain/repositories/user_repository.dart';
import 'package:flutter_clean_tutorial/shared/domain/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/generated.mocks.dart';
import '../../../../mocks/mock_data.dart';

void main() {
  group(
    'UserRepository',
    () {
      late final MockUserRemoteDataSource dataSource;
      late final UserRepository repository;

      setUpAll(() {
        dataSource = MockUserRemoteDataSource();
        repository = UserRepositoryImpl(dataSource);
      });

      test(
        'fetching user data successfully',
        () async {
          const List<User> users = mockUsers;
          when(dataSource.fetchUsers()).thenAnswer((_) async => mockUsers);

          final result = await repository.getUsers();

          expect(result, const Success(users));
          verify(dataSource.fetchUsers());
          verifyNoMoreInteractions(dataSource);
        },
      );

      test(
        'fetching process gets DioError',
        () async {
          const errorMessage = 'Error happened';

          when(dataSource.fetchUsers()).thenThrow(
            DioError(
              requestOptions: RequestOptions(path: ''),
              error: errorMessage,
            ),
          );

          final result = await repository.getUsers();

          expect(result, const Error(Failure.network(errorMessage)));
          verify(dataSource.fetchUsers());
          verifyNoMoreInteractions(dataSource);
        },
      );

      test(
        'fetching process gets Exception',
        () async {
          when(dataSource.fetchUsers()).thenThrow(Exception());

          final result = await repository.getUsers();

          expect(result, const Error(Failure<String>.other()));
        },
      );
    },
  );
}
