class Post {
  final String place;
  final String comments;

  Post({
    this.place,
    this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      place: json['place'],
      comments: json['comments'],
    );
  }
}