import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/posts/data/data_sources/remote/post_remote_data_source.dart';
import 'features/posts/data/repositories/post_repository.dart';
import 'features/posts/domain/repositories/post_repository.dart';
import 'features/posts/domain/use_cases/fetch_posts.dart';
import 'features/posts/presentation/blocs/posts/posts_cubit.dart';
import 'features/users/data/data_sources/remote/user_remote_data_source.dart';
import 'features/users/data/repositories/user_repository_impl.dart';
import 'features/users/domain/repositories/user_repository.dart';
import 'features/users/domain/use_cases/fetch_users.dart';
import 'features/users/presentation/blocs/users/users_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  /// externals
  getIt.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com/',
      ),
  );

  /// data sources
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(getIt()),
  );

  /// repositories
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(getIt()),
  );

  /// use cases
  getIt.registerLazySingleton(() => FetchUsers(getIt()));
  getIt.registerLazySingleton(() => FetchPosts(getIt()));

  /// blocs
  getIt.registerFactory(() => UsersCubit(getIt()));
  getIt.registerFactory(() => PostsCubit(getIt()));
}
