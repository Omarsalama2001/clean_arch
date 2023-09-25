import 'package:dio/dio.dart';
import 'package:flutter_clean_arch/core/network/network_info.dart';
import 'package:flutter_clean_arch/features/posts/data/datasources/post_local_data_source.dart';
import 'package:flutter_clean_arch/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:flutter_clean_arch/features/posts/data/repositories/post_reopsitory_impl.dart';
import 'package:flutter_clean_arch/features/posts/doamin/repositories/posts_repositories.dart';
import 'package:flutter_clean_arch/features/posts/doamin/usecases/add_post.dart';
import 'package:flutter_clean_arch/features/posts/doamin/usecases/delete_post.dart';
import 'package:flutter_clean_arch/features/posts/doamin/usecases/get_all_posts.dart';
import 'package:flutter_clean_arch/features/posts/doamin/usecases/update_post.dart';
import 'package:flutter_clean_arch/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:flutter_clean_arch/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
//!Features -posts

//Bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl())); // this factory because it will be used more than one time
  sl.registerFactory(() => AddUpdateDeletePostBloc(addPost: sl(), deletePost: sl(), updatePost: sl()));

//Usecases
  sl.registerLazySingleton(() => GetAllPostsUsecase(repository: sl())); // if you need only one instance in whole app (and will create when you need it )
  sl.registerLazySingleton(() => AddPostUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdatPostUsecase(repository: sl()));
//Repository
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(localDateSource: sl(), networkInfo: sl(), remoteDateSource: sl()));

//Datasources
  sl.registerLazySingleton<PostLocalDateSource>(() => PostLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<PostRemoteDateSource>(() => PostRemoteDataSourceImpl(dio: sl()));
  //!Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  const String baseUrl = "https://jsonplaceholder.typicode.com";
  BaseOptions options = BaseOptions(
    baseUrl: baseUrl,
    contentType: 'application/json',
    receiveDataWhenStatusError: true,
  );
  sl.registerLazySingleton(() => Dio(options));

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
