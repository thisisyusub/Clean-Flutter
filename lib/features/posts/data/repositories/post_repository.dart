import 'package:dio/dio.dart';

import '../../../../core/either.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/remote/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  const PostRepositoryImpl(this.dataSource);

  final PostRemoteDataSource dataSource;

  @override
  Future<Either<Failure<String>, List<Post>>> getPosts([int? userId]) async {
    try {
      final result = await dataSource.fetchPosts(userId);

      return Success(result);
    } on DioError catch (e) {
      return Error(Failure.network(e.message));
    } catch (_) {
      return const Error(Failure.other());
    }
  }
}
