import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arch/core/error/failures.dart';
import 'package:flutter_clean_arch/core/strings/faliures.dart';
import 'package:flutter_clean_arch/core/strings/messages.dart';
import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';
import 'package:flutter_clean_arch/features/posts/doamin/usecases/add_post.dart';
import 'package:flutter_clean_arch/features/posts/doamin/usecases/delete_post.dart';
import 'package:flutter_clean_arch/features/posts/doamin/usecases/update_post.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  AddPostUsecase addPost; // this bloc is injected with those classes , and it cant complete its work without them (Dependency) so, here we talking about DI
  DeletePostUsecase deletePost;
  UpdatPostUsecase updatePost;

  AddUpdateDeletePostBloc({required this.addPost, required this.deletePost, required this.updatePost}) : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddUpdateDeletePostState());
        final failureOrUnit = await addPost(event.post);
        emit(_mapFailureOrUnitToState(failureOrUnit, ADD_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddUpdateDeletePostState());
        final failureOrUnit = await deletePost(event.postId);
        emit(_mapFailureOrUnitToState(failureOrUnit, DELETE_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        final failureOrUnit = await updatePost(event.post);
        emit(_mapFailureOrUnitToState(failureOrUnit, UPDATE_SUCCESS_MESSAGE));
      }
    });
  }
  AddUpdateDeletePostState _mapFailureOrUnitToState(Either<Failure, Unit> either, String message) {
    return either.fold((failure) => ErrorAddUpdateDeletePostState(message: _mapfailureToMessage(failure)), (r) => SuccessAddUpdateDeletePostState(message: message));
  }

  String _mapfailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FALIURE_MESSAGE;
      case OfflineFaliure:
        return OFFLINE_FALIURE_MESSAGE;
      default:
        return UN_EXCPECTED_ERROR_MESSAGE;
    }
  }
}
