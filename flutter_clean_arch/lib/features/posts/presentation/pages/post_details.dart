import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/core/widgets/loading_widget.dart';
import 'package:flutter_clean_arch/core/widgets/snack_bar.dart';

import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';
import 'package:flutter_clean_arch/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:flutter_clean_arch/features/posts/presentation/pages/post_add_update.dart';
import 'package:flutter_clean_arch/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter_clean_arch/features/posts/presentation/widgets/post_add_update_widgets/form_submit_btn.dart';
import 'package:flutter_clean_arch/features/posts/presentation/widgets/post_add_update_widgets/form_widget.dart';
import 'package:flutter_clean_arch/features/posts/presentation/widgets/post_details_widget/post_details_widget.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  const PostDetailsPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody(context));
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text("Post Details"),
      );

  Widget _buildBody(BuildContext context) {
    return PostDetailsWidget(post: post);
  }
}
