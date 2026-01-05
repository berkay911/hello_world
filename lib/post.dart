class Post {
  String body;
  String author;
  int likes;
  bool userLiked = false;

  Post(this.body, this.author, {this.likes = 0});

  void likePost() {
    this.userLiked = !this.userLiked;
    if (this.userLiked) {
      this.likes += 1;
    } else {
      this.likes -= 1;
    }
  }
}
