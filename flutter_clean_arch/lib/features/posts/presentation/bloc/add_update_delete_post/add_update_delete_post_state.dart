part of 'add_update_delete_post_bloc.dart';

sealed class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

final class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class LoadingAddUpdateDeletePostState extends AddUpdateDeletePostState {}

class ErrorAddUpdateDeletePostState extends AddUpdateDeletePostState {
  final String message;
  const ErrorAddUpdateDeletePostState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class SuccessAddUpdateDeletePostState extends AddUpdateDeletePostState {
  final String message;
  const SuccessAddUpdateDeletePostState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
