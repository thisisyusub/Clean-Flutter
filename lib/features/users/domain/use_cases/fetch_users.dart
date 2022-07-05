import '../../../../core/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../../../shared/domain/user.dart';
import '../repositories/user_repository.dart';

class FetchUsers extends Usecase<String, List<User>, NoParams> {
  FetchUsers(this.userRepository);

  final UserRepository userRepository;

  @override
  Future<Either<Failure<String>, List<User>>> call(NoParams params) {
    return userRepository.getUsers();
  }
}
