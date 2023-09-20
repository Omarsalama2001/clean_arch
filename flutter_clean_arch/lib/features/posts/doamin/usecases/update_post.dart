import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch/core/error/failures.dart';
import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';
import 'package:flutter_clean_arch/features/posts/doamin/repositories/posts_repositories.dart';

class UpdatPostUsecase {
  PostRepository repository;
  UpdatPostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
