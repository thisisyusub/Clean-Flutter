import '../../../../core/either.dart';
import '../../../../core/error/failure.dart';
import '../entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure<String>, List<Post>>> getPosts([int? userId]);
}
