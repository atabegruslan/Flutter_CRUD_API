class Post {
  final int id;
  final String place;
  final String comments;
  final String img_url;

  Post({
    this.id,
    this.place,
    this.comments,
    this.img_url,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      place: json['place'],
      comments: json['comments'],
      img_url: json['img_url'],
    );
  }
}