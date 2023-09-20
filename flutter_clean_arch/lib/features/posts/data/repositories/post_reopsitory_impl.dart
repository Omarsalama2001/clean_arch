import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch/core/error/exceptions.dart';
import 'package:flutter_clean_arch/core/error/failures.dart';
import 'package:flutter_clean_arch/core/network/network_info.dart';
import 'package:flutter_clean_arch/features/posts/data/datasources/post_local_data_source.dart';
import 'package:flutter_clean_arch/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:flutter_clean_arch/features/posts/data/models/post_model.dart';
import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';
import 'package:flutter_clean_arch/features/posts/doamin/repositories/posts_repositories.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function(); // to make an alies for a specific function " just more Clean :) "

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDateSource remoteDateSource;
  final PostLocalDateSource localDateSource;
  final NetworkInfoImpl networkInfo;

  PostRepositoryImpl({required this.remoteDateSource, required this.localDateSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final List<PostModel> remotePosts = await remoteDateSource.getAllPosts();
        localDateSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<PostModel> localPosts = await localDateSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCashFaliure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    // this from entity so, we need to replace it to PostModel
    final PostModel postModel = PostModel(id: post.id, body: post.body, title: post.title);

    return _getMessage(() => remoteDateSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return _getMessage(() => remoteDateSource.deletePost(postId));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    // this from entity so, we need to replace it to PostModel
    final PostModel postModel = PostModel(id: post.id, body: post.body, title: post.title);
    return _getMessage(() => remoteDateSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(deleteOrUpdateOrAddPost) async {
    // this function for more clean code because its common
    if (await networkInfo.isConnected) {
      try {
        return Right(await deleteOrUpdateOrAddPost()); //hbd
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFaliure());
    }
  }
}
