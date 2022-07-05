import 'package:flutter_clean_tutorial/features/posts/data/models/post_model.dart';
import 'package:flutter_clean_tutorial/shared/data/user_model.dart';

const mockUser = UserModel(
  id: 1,
  name: 'Leanne Graham',
  username: 'Bret',
  email: 'Sincere@april.biz',
);

const mockUsers = [
  UserModel(
    id: 1,
    name: 'Leanne Graham',
    username: 'Bret',
    email: 'Sincere@april.biz',
  ),
  UserModel(
    id: 2,
    name: 'Leanne Graham',
    username: 'Bret',
    email: 'Sincere@april.biz',
  )
];

const mockPost = PostModel(
  id: 1,
  userId: 1,
  title: 'Title',
  body: 'Body',
);

const mockPosts = [
  PostModel(
    id: 1,
    userId: 1,
    title: 'Title',
    body: 'Body',
  ),
  PostModel(
    id: 2,
    userId: 2,
    title: 'Title',
    body: 'Body',
  )
];
