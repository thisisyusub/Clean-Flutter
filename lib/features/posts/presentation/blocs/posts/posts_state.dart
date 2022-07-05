import 'package:equatable/equatable.dart';

import '../../../domain/entities/post.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  List<Object?> get props => [];
}

class PostsInProgress extends PostsState {
  @override
  List<Object?> get props => [];
}

class PostsFailure extends PostsState {
  const PostsFailure(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}

class PostsSuccess extends PostsState {
  const PostsSuccess(this.posts);

  final List<Post> posts;

  @override
  List<Object?> get props => [posts];
}
