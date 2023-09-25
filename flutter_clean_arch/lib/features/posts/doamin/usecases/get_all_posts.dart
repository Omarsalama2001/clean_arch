import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch/core/error/failures.dart';
import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';
import 'package:flutter_clean_arch/features/posts/doamin/repositories/posts_repositories.dart';

class GetAllPostsUsecase {
  final PostRepository repository;

  GetAllPostsUsecase({required this.repository});
  Future<Either<Failure, List<Post>>> call() async {
    // this override for the call function to access it with the name of the class directly (make it callable class)
    return await repository.getAllPosts();
  }
}
