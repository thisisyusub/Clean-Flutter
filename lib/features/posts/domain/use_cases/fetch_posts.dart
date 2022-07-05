import '../../../../core/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class FetchPosts extends Usecase<String, List<Post>, int?> {
  FetchPosts(this.postRepository);

  final PostRepository postRepository;

  @override
  Future<Either<Failure<String>, List<Post>>> call([int? params]) {
    return postRepository.getPosts(params);
  }
}
