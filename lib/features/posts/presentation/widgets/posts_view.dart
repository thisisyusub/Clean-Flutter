import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/index_to_color_ext.dart';
import '../blocs/posts/posts_cubit.dart';
import '../blocs/posts/posts_state.dart';

class PostsView extends StatelessWidget {
  const PostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PostsSuccess) {
          final posts = state.posts;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            itemBuilder: (context, index) {
              final post = posts[index];

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: post.userId.convertToColor,
                  ),
                  title: Text(post.title),
                  subtitle: Text(post.body),
                ),
              );
            },
            itemCount: posts.length,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
