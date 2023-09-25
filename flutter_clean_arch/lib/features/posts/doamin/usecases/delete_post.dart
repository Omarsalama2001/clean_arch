import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch/core/error/failures.dart';
import 'package:flutter_clean_arch/features/posts/doamin/repositories/posts_repositories.dart';

class DeletePostUsecase {
  PostRepository repository;

  DeletePostUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
