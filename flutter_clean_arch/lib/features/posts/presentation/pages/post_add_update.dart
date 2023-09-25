import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/core/widgets/loading_widget.dart';
import 'package:flutter_clean_arch/core/widgets/snack_bar.dart';

import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';
import 'package:flutter_clean_arch/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:flutter_clean_arch/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter_clean_arch/features/posts/presentation/widgets/post_add_update_widgets/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdate;

  const PostAddUpdatePage({
    Key? key,
    this.post,
    required this.isUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(title: Text(isUpdate ? "Update Post" : "Add Post"));

  Widget _buildBody() {
    return BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(listener: (context, state) {
      if (state is SuccessAddUpdateDeletePostState) {
        SnackBarMessage.showSnackBar(SnackBarTypes.SUCCESS, state.message, context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PostsPage()));
      } else if (state is ErrorAddUpdateDeletePostState) {
        SnackBarMessage.showSnackBar(SnackBarTypes.ERORR, state.message, context);
      }
    }, builder: (context, state) {
      if (state is LoadingAddUpdateDeletePostState) {
        return const LoadingWidget();
      }
      return FormWidget(
        post: isUpdate ? post : null,
        isUpdate: isUpdate,
      );
    });
  }
}
