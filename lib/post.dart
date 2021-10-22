class Post {
  final String place;
  final String comments;
  final String img_url;

  Post({
    this.place,
    this.comments,
    this.img_url,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      place: json['place'],
      comments: json['comments'],
      img_url: json['img_url'],
    );
  }
}