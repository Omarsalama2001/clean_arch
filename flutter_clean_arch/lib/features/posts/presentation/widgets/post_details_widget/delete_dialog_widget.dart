import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';
import 'package:flutter_clean_arch/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final Post post;
  const DeleteDialogWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text("are you sure , Delete this Post ?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("NO")),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<AddUpdateDeletePostBloc>(context).add(DeletePostEvent(postId: post.id!));
            },
            child: const Text("YES")),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
