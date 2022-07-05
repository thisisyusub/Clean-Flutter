import '../../../../core/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../shared/domain/user.dart';

abstract class UserRepository {
  Future<Either<Failure<String>, List<User>>> getUsers();
}
