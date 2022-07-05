import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/posts/index.dart';
import '../../features/users/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I.get<UsersCubit>()..getUsers(),
        ),
        BlocProvider(
          create: (_) => GetIt.I.get<PostsCubit>()..getPosts(),
        ),
      ],
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return SafeArea(
              child: Column(
                children: [
                  UsersView(
                    onUserPressed: (userId) {
                      context.read<PostsCubit>().getPosts(userId);
                    },
                  ),
                  const SizedBox(height: 15),
                  const Expanded(child: PostsView()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
