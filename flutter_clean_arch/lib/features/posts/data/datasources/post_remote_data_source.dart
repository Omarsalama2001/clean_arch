import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_arch/core/error/exceptions.dart';
import 'package:flutter_clean_arch/features/posts/data/models/post_model.dart';

abstract class PostRemoteDateSource {
  // this is and optional abs class because you may need to do the calling API in diff ways (dio ,http ,.........)
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

class PostRemoteDataSourceImpl implements PostRemoteDateSource {
  Dio dio;
  PostRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final Response response = await dio.get("/posts");
    if (response.statusCode == 200) {
      final List decodedJson = response.data as List; // here you dont have to decode this data (its list it self)
      final List<PostModel> postModels = decodedJson.map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
      return Future.value(postModels);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {"title": postModel.title, "body": postModel.body};
    final Response response = await dio.post("/posts", data: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final Response response = await dio.delete("/posts/${postId.toString()}");
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final body = {"title": postModel.title, "body": postModel.body};
    final Response response = await dio.put("/posts/${postModel.id.toString()}", data: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
