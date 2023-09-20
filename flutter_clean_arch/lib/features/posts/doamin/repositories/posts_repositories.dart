import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch/core/error/failures.dart';
import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int postId); // return bool here is not effcient <we need to return <data or failure"if there is a data to be">>
  Future<Either<Failure, Unit>> updatePost(Post post); // Unit refers that we return nothing or there is no Failure
  Future<Either<Failure, Unit>> addPost(Post post);
}
