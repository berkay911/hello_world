import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hello_world/database.dart';

class Post {
  String body;
  String author;
  Set<String> usersLiked;
  late DatabaseReference _id;

  Post(this.body, this.author, {Set<String>? usersLiked})
    : usersLiked = usersLiked ?? {};

  void likePost(User user) {
    if (usersLiked.contains(user.uid)) {
      usersLiked.remove(user.uid);
    } else {
      usersLiked.add(user.uid);
    }
    update();
  }

  void update() {
    updatePost(this, _id);
  }

  void setId(DatabaseReference id) {
    _id = id;
  }

  Map<String, dynamic> toJson() {
    return {'author': author, 'usersLiked': usersLiked.toList(), 'body': body};
  }
}

Post createPost(dynamic record) {
  final Map<String, dynamic> attributes = {
    'author': '',
    'usersLiked': <String>[],
    'body': '',
  };

  if (record is Map) {
    record.forEach((key, value) {
      attributes[key] = value;
    });
  }

  final post = Post(
    attributes['body'],
    attributes['author'],
    usersLiked: Set<String>.from(attributes['usersLiked'] ?? []),
  );

  return post;
}
