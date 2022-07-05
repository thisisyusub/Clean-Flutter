import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/fetch_posts.dart';
import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.fetchPosts) : super(PostsInitial());

  final FetchPosts fetchPosts;

  void getPosts([int? userId]) async {
    emit(PostsInProgress());
    await Future.delayed(const Duration(seconds: 1));

    final result = await fetchPosts(userId);

    result.when(
      error: (failure) => emit(PostsFailure(failure.error)),
      success: (users) {
        emit(PostsSuccess(users));
      },
    );
  }
}
