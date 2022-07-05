import 'package:dio/dio.dart';

import '../../../../core/either.dart';
import '../../../../core/error/failure.dart';
import '../../../../shared/domain/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/remote/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this.dataSource);

  final UserRemoteDataSource dataSource;

  @override
  Future<Either<Failure<String>, List<User>>> getUsers() async {
    try {
      final result = await dataSource.fetchUsers();
      return Success(result);
    } on DioError catch (e) {
      return Error(Failure.network(e.message));
    } catch (_) {
      return const Error(Failure.other());
    }
  }
}
