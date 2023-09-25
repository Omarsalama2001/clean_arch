import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';
import 'package:flutter_clean_arch/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter_clean_arch/features/posts/presentation/pages/post_details.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostsListWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
      },
      child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PostDetailsPage(
                                post: posts[index],
                              )));
                },
                leading: Text(posts[index].id.toString()),
                title: Text(posts[index].title),
                subtitle: Text(
                  posts[index].body,
                ));
          },
          separatorBuilder: (context, index) => const Divider(
                thickness: 1,
              ),
          itemCount: posts.length),
    );
  }
}
