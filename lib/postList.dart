import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'post.dart';

class PostList extends StatefulWidget {
  final List<Post> listItems;
  final User user;

  const PostList(this.listItems, this.user, {super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(VoidCallback callBack) {
    setState(() {
      callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listItems.length,
      itemBuilder: (context, index) {
        final post = widget.listItems[index];

        return Card(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(post.body),
                  subtitle: Text(post.author),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      post.usersLiked.length.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.thumb_up),
                    onPressed: () => like(() => post.likePost(widget.user)),
                    color: post.usersLiked.contains(widget.user.uid)
                        ? Colors.green
                        : Colors.black,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
