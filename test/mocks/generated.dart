import 'package:dio/dio.dart';
import 'package:flutter_clean_tutorial/features/posts/data/data_sources/remote/post_remote_data_source.dart';
import 'package:flutter_clean_tutorial/features/posts/domain/repositories/post_repository.dart';
import 'package:flutter_clean_tutorial/features/posts/domain/use_cases/fetch_posts.dart';
import 'package:flutter_clean_tutorial/features/users/data/data_sources/remote/user_remote_data_source.dart';
import 'package:flutter_clean_tutorial/features/users/domain/repositories/user_repository.dart';
import 'package:flutter_clean_tutorial/features/users/domain/use_cases/fetch_users.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  HttpClientAdapter,
  UserRemoteDataSource,
  UserRepository,
  FetchUsers,
  PostRemoteDataSource,
  PostRepository,
  FetchPosts,
])
void generate() {}
