import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'post.dart';

// 🔥 DOĞRU DATABASE REFERANSI (URL'li)
final DatabaseReference databaseReference = FirebaseDatabase.instanceFor(
  app: Firebase.app(),
  databaseURL:
      "https://messageapp-c321d-default-rtdb.europe-west1.firebasedatabase.app",
).ref();

Future<DatabaseReference> savePost(Post post) async {
  final ref = databaseReference.child('posts').push();
  print("🔥 Firebase path: ${ref.path}");
  await ref.set(post.toJson());
  print("✅ Firebase write OK");
  return ref;
}

Future<void> updatePost(Post post, DatabaseReference id) async {
  await id.update(post.toJson());
}

Future<List<Post>> getAllPosts() async {
  final snapshot = await databaseReference.child('posts').get();

  List<Post> posts = [];

  if (snapshot.exists && snapshot.value != null) {
    final data = snapshot.value as Map;

    data.forEach((key, value) {
      final post = createPost(value);
      post.setId(databaseReference.child('posts/$key'));
      posts.add(post);
    });
  }

  return posts;
}
