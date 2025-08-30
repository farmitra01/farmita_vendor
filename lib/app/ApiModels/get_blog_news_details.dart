class BlogResponse {
  final bool status;
  final String message;
  final BlogPost data;
  final List<RelatedPost> related;

  BlogResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.related,
  });

  factory BlogResponse.fromJson(Map<String, dynamic> json) {
    return BlogResponse(
      status: json['status'],
      message: json['message'],
      data: BlogPost.fromJson(json['data']),
      related: (json['related'] as List)
          .map((e) => RelatedPost.fromJson(e))
          .toList(),
    );
  }
}

class BlogPost {
  final int id;
  final int userId;
  final int blogCategoryId;
  final String title;
  final String slug;
  final String banner;
  final String content;
  final String? videoLink;
  final String createdAt;
  final String updatedAt;
  final User user;

  BlogPost({
    required this.id,
    required this.userId,
    required this.blogCategoryId,
    required this.title,
    required this.slug,
    required this.banner,
    required this.content,
    this.videoLink,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'],
      userId: json['user_id'],
      blogCategoryId: json['blog_category_id'],
      title: json['title'],
      slug: json['slug'],
      banner: json['banner'],
      content: json['content'],
      videoLink: json['video_link'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String profilePicture;

  User({
    required this.id,
    required this.name,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      profilePicture: json['profile_picture'],
    );
  }
}

class RelatedPost {
  final int id;
  final String title;
  final String banner;

  RelatedPost({
    required this.id,
    required this.title,
    required this.banner,
  });

  factory RelatedPost.fromJson(Map<String, dynamic> json) {
    return RelatedPost(
      id: json['id'],
      title: json['title'],
      banner: json['banner'],
    );
  }
}
