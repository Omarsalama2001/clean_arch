import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arch/core/error/failures.dart';
import 'package:flutter_clean_arch/core/strings/faliures.dart';
import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';
import 'package:flutter_clean_arch/features/posts/doamin/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPosts;

  PostsBloc(this.getAllPosts) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadignPostsState());
        final posts = await getAllPosts();
        emit(_mapFailureOrPostsToState(posts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadignPostsState());
        final posts = await getAllPosts();
        emit(_mapFailureOrPostsToState(posts));
      }
    });
  }
  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold((failure) => ErrorPostsState(message: _mapFaliureToMessage(failure)), (posts) => LoadedPostsState(posts: posts));
  }

  String _mapFaliureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      // this to get the extended types while run time :)
      case ServerFailure:
        return SERVER_FALIURE_MESSAGE;

      case OfflineFaliure:
        return OFFLINE_FALIURE_MESSAGE;

      case EmptyCashFaliure:
        return EMPTY_CACHE_FALIURE_MESSAGE;

      default:
        return UN_EXCPECTED_ERROR_MESSAGE;
    }
  }
}
