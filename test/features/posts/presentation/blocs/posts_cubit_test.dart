import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_clean_tutorial/features/posts/presentation/blocs/posts/posts_cubit.dart';
import 'package:flutter_clean_tutorial/features/posts/presentation/blocs/posts/posts_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_tutorial/core/error/failure.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_clean_tutorial/core/either.dart';

import '../../../../mocks/generated.mocks.dart';
import '../../../../mocks/mock_data.dart';

void main() {
  group(
    'PostsCubit',
    () {
      late final MockFetchPosts fetchPosts;

      setUpAll(
        () {
          fetchPosts = MockFetchPosts();
        },
      );

      blocTest<PostsCubit, PostsState>(
        'should emit empty if nothing happened',
        build: () => PostsCubit(fetchPosts),
        expect: () => [],
      );

      blocTest<PostsCubit, PostsState>(
        'should emit [Failure] if something went wrong',
        build: () => PostsCubit(fetchPosts),
        setUp: () {
          when(fetchPosts(any)).thenAnswer(
            (_) async => const Error(
              Failure.network('error!'),
            ),
          );
        },
        act: (cubit) => cubit.getPosts(1),
        expect: () => [
          PostsInProgress(),
          const PostsFailure('error!'),
        ],
        verify: (_) {
          verify(fetchPosts(1));
          verifyNoMoreInteractions(fetchPosts);
        },
      );

      blocTest<PostsCubit, PostsState>(
        'should emit [Success] if it is okay',
        build: () => PostsCubit(fetchPosts),
        setUp: () {
          when(fetchPosts(any)).thenAnswer(
            (_) async => const Success(mockPosts),
          );
        },
        act: (cubit) => cubit.getPosts(1),
        expect: () => [
          PostsInProgress(),
          const PostsSuccess(mockPosts),
        ],
        verify: (_) {
          verify(fetchPosts(1));
          verifyNoMoreInteractions(fetchPosts);
        },
      );
    },
  );
}
