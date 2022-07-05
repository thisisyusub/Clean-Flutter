import 'package:flutter_clean_tutorial/core/either.dart';
import 'package:flutter_clean_tutorial/core/error/failure.dart';
import 'package:flutter_clean_tutorial/core/use_cases/use_case.dart';
import 'package:flutter_clean_tutorial/features/users/domain/use_cases/fetch_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/generated.mocks.dart';
import '../../../../mocks/mock_data.dart';

void main() {
  group(
    'FetchUsers',
    () {
      late final MockUserRepository repository;
      late final FetchUsers fetchUsers;

      setUpAll(() {
        repository = MockUserRepository();
        fetchUsers = FetchUsers(repository);
      });

      test('gets users successfully', () async {
        when(repository.getUsers()).thenAnswer(
          (_) async => const Success(mockUsers),
        );

        final result = await fetchUsers(NoParams());

        expect(result, equals(const Success(mockUsers)));
      });

      test('gets users failed', () async {
        const error = 'Error happened';

        when(repository.getUsers()).thenAnswer(
          (_) async => const Error(Failure.network(error)),
        );

        final result = await fetchUsers(NoParams());

        expect(result, equals(const Error(Failure.network(error))));
      });
    },
  );
}
