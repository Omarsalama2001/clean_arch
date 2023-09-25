import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';

class PostModel extends Post {
  const PostModel({int? id, required String body, required String title}) : super(id: id, body: body, title: title);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // this is to make it readalbe and to use the pram one in
    return PostModel(id: json['id'], body: json['body'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'body': body, 'title': title};
  }
}
