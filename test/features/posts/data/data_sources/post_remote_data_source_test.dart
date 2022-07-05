import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_clean_tutorial/features/posts/data/data_sources/remote/post_remote_data_source.dart';
import 'package:flutter_clean_tutorial/features/posts/data/models/post_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../utils/dio_response_stub.dart';

import '../../../../fixtures/fixture.dart';
import '../../../../mocks/generated.mocks.dart';

void main() {
  group(
    'PostRemoteDataSource',
    () {
      late final MockHttpClientAdapter adapter;
      late final PostRemoteDataSource dataSource;

      setUpAll(
        () {
          adapter = MockHttpClientAdapter();
          dataSource = PostRemoteDataSourceImpl(
            Dio()..httpClientAdapter = adapter,
          );
        },
      );

      test(
        'fetching data successfully',
        () async {
          final postList = jsonDecode(fixture('posts.json')) as List<dynamic>;
          final posts = postList.map((e) => PostModel.fromJson(e)).toList();

          adapter.createMockResponseStub(json.encode(postList), 200);

          final result = await dataSource.fetchPosts();

          expect(result, posts);
          verify(adapter.fetch(any, any, any));
          verifyNoMoreInteractions(adapter);
        },
      );

      test(
        'fetching data unsuccessfully',
        () async {
          adapter.createMockResponseStub('Error happened', 404);

          final call = dataSource.fetchPosts;

          expect(call, throwsA(const TypeMatcher<DioError>()));
          verifyNoMoreInteractions(adapter);
        },
      );
    },
  );
}
