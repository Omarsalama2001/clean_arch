import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/bloc_observer.dart';
import 'package:flutter_clean_arch/core/app_theme.dart';
import 'package:flutter_clean_arch/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:flutter_clean_arch/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter_clean_arch/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter_clean_arch/injectionContainer.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent()), // .. is a cascade operator , you can use it to call multiple functions or doing actions after create an object like this here
        ),
        BlocProvider(create: (context) => di.sl<AddUpdateDeletePostBloc>())
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, title: 'posts App', theme: appTheme, home: const PostsPage()),
    );
  }
}
