part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

class LoadignPostsState extends PostsState {}

// ignore: must_be_immutable
class LoadedPostsState extends PostsState {
  List<Post> posts;
  LoadedPostsState({
    required this.posts,
  });
  @override
  List<Object> get props => [posts];
}

// ignore: must_be_immutable
class ErrorPostsState extends PostsState {
  String message;
  ErrorPostsState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
