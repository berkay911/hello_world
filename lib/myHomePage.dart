import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/database.dart';
import 'post.dart';
import 'postList.dart';
import 'textInputWidget.dart';

class MyHomePage extends StatefulWidget {
  final User user;

  const MyHomePage(this.user, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  Future<void> newPost(String text) async {
    final post = Post(text, widget.user.displayName ?? "Anonymous");

    final postRef = await savePost(post);
    post.setId(postRef);

    setState(() {
      posts.add(post);
    });
  }

  void updatePosts() async {
    final loadedPosts = await getAllPosts();
    setState(() {
      posts = loadedPosts;
    });
  }

  @override
  void initState() {
    super.initState();
    updatePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello World!')),
      body: Column(
        children: <Widget>[
          Expanded(child: PostList(posts, widget.user)),
          TextInputWidget(newPost),
        ],
      ),
    );
  }
}
