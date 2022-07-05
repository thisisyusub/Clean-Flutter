import 'package:dio/dio.dart';

import '../../../../../shared/data/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> fetchUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<UserModel>> fetchUsers() async {
    final result = await dio.get('/users');

    return (result.data as List<dynamic>)
        .map((user) => UserModel.fromJson(user))
        .toList();
  }
}
