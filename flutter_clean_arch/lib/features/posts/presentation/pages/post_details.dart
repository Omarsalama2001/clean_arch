import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';
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
