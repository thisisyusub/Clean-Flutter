import 'package:dio/dio.dart';

import '../../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> fetchPosts([int? userId]);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  const PostRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<PostModel>> fetchPosts([int? userId]) async {
    final result = await dio.get(
      '/posts',
      queryParameters: {
        if (userId != null) 'userId': userId,
      },
    );

    return (result.data as List<dynamic>)
        .map((user) => PostModel.fromJson(user))
        .toList();
  }
}
