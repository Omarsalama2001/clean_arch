import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  const Post({required this.id, required this.body, required this.title});

  @override
  List<Object?> get props => [id, title, body]; // and we will use the normal fun (=) to compare obj based on the impl of this abs function
}
