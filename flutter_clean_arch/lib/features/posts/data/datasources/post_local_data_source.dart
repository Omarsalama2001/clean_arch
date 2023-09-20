import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch/core/error/exceptions.dart';
import 'package:flutter_clean_arch/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDateSource {
  // this is and optional abs class because you may need to do the calling API in diff ways (dio ,http ,.........)
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

// ignore: constant_identifier_names
const CACHED_POSTS = "CACHED_POSTS"; //global

class PostLocalDataSourceImpl implements PostLocalDateSource {
  final SharedPreferences sharedPreferences;
  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List<Map<String, dynamic>> postModelToJson = postModels.map<Map<String, dynamic>>((postModel) => postModel.toJson()).toList();
    sharedPreferences.setString(CACHED_POSTS, jsonEncode(postModelToJson)); // this to convert our map into a json "String" to make it easier for store as String in SP
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = jsonDecode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData.map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
