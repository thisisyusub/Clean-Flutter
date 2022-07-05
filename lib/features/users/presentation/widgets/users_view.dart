import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/index_to_color_ext.dart';
import '../../../../shared/domain/user.dart';
import '../blocs/users/users_cubit.dart';
import '../blocs/users/users_state.dart';

part './user_item.dart';

typedef OnUserPressed = void Function(int userId);

class UsersView extends StatefulWidget {
  const UsersView({
    Key? key,
    this.onUserPressed,
  }) : super(key: key);

  final OnUserPressed? onUserPressed;

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        if (state is UsersInProgress) {
          return const LinearProgressIndicator();
        }

        if (state is UsersSuccess) {
          final users = state.users;

          return SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final user = users[index];

                return UserItem(
                  user: user,
                  onUserPressed: widget.onUserPressed,
                );
              },
              itemCount: users.length,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
