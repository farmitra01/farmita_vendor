class BlogPost {
  final int id; // ✅ Add this line
  final String title;
  final String? content;
  final String banner;
  final User user;
  final String createdAt;

  BlogPost({
    required this.id, // ✅ Include in constructor
    required this.title,
    this.content,
    required this.banner,
    required this.user,
    required this.createdAt,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'] ?? 0, // ✅ Parse ID from API response
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString(),
      banner: json['banner']?.toString() ?? '',
      user: User.fromJson(json['user'] is Map ? json['user'] : {}),
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}

class User {
  final String name;

  User({required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name']?.toString() ?? 'Unknown');
  }
}

class RelatedPost {
  final String title;
  final String banner;
  final String content;

  RelatedPost({
    required this.title,
    required this.banner,
    required this.content,
  });

  factory RelatedPost.fromJson(Map<String, dynamic> json) {
    return RelatedPost(
      title: json['title']?.toString() ?? '',
      banner: json['banner']?.toString() ?? '',
      content: json['content']?.toString() ??
          json['description']?.toString() ??
          '',
    );
  }

  @override
  String toString() => content;
}