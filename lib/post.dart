class Post {
  final String name;
  final String color;

  Post({
    this.name,
    this.color,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'],
      color: json['color'],
    );
  }
}