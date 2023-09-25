import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter_clean_arch/core/widgets/loading_widget.dart';
import 'package:flutter_clean_arch/features/posts/presentation/pages/post_add_update.dart';
import 'package:flutter_clean_arch/features/posts/presentation/widgets/posts_page_widgets/message_widget.dart';
import 'package:flutter_clean_arch/features/posts/presentation/widgets/posts_page_widgets/posts_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _floatingActionButton(context),
    );
  }
}

AppBar _buildAppBar() => AppBar(title: const Text("Posts"));

Widget _buildBody() => BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
      if (state is LoadignPostsState) {
        return const LoadingWidget();
      } else if (state is LoadedPostsState) {
        return PostsListWidget(
          posts: state.posts,
        );
      } else if (state is ErrorPostsState) {
        return MessageWidget(message: state.message);
      } else {
        return const LoadingWidget();
      }
    });
FloatingActionButton _floatingActionButton(BuildContext context) => FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const PostAddUpdatePage(
                      isUpdate: false,
                    )));
      },
      child: const Icon(Icons.add, size: 30),
    );
