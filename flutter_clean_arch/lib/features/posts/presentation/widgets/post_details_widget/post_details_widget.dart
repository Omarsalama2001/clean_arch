import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/core/widgets/loading_widget.dart';
import 'package:flutter_clean_arch/core/widgets/snack_bar.dart';

import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';
import 'package:flutter_clean_arch/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:flutter_clean_arch/features/posts/presentation/pages/post_add_update.dart';
import 'package:flutter_clean_arch/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter_clean_arch/features/posts/presentation/widgets/post_details_widget/delete_dialog_widget.dart';

class PostDetailsWidget extends StatelessWidget {
  final Post post;
  const PostDetailsWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text(post.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            subtitle: Text(post.body,
                style: const TextStyle(
                  fontSize: 15,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PostAddUpdatePage(
                                isUpdate: true,
                                post: post,
                              )));
                },
                icon: const Icon(Icons.edit),
                label: const Text("Update"),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showAltretDialog(context);
                },
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void showAltretDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
              listener: (context, state) {
                if (state is ErrorAddUpdateDeletePostState) {
                  Navigator.pop(context);
                  SnackBarMessage.showSnackBar(SnackBarTypes.ERORR, state.message, context);
                } else if (state is SuccessAddUpdateDeletePostState) {
                  SnackBarMessage.showSnackBar(SnackBarTypes.SUCCESS, state.message, context);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const PostsPage()), (route) => false);
                }
              },
              builder: (context, state) {
                if (state is LoadingAddUpdateDeletePostState) {
                  return const AlertDialog(
                    title: LoadingWidget(),
                  );
                }
                return DeleteDialogWidget(
                  post: post,
                );
              },
            ));
  }
}
