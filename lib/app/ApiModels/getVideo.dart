import 'dart:convert';

class VideoPostResponse {
  final bool success;
  final String? message;
  final List<VideoPost> data;

  VideoPostResponse({
    required this.success,
    this.message,
    required this.data,
  });

  factory VideoPostResponse.fromJson(Map<String, dynamic> json) {
    // Access the nested 'videos' list inside 'data'
    final dataMap = json['data'] as Map<String, dynamic>? ?? {};
    final dataList = dataMap['videos'] as List<dynamic>? ?? [];

    return VideoPostResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
      data: dataList
          .map((item) => VideoPost.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class VideoPost {
  final int id;
  final int userId;
  final String location;
  final String tags; // Stored as a JSON string, e.g., "['Weather','Paddy']"
  final String thumbnail;
  final String videoLink;
  final String content;
  final int status;
  final String createdAt;
  final String updatedAt;
  final User user;

  VideoPost({
    required this.id,
    required this.userId,
    required this.location,
    required this.tags,
    required this.thumbnail,
    required this.videoLink,
    required this.content,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory VideoPost.fromJson(Map<String, dynamic> json) {
    return VideoPost(
      id: json['id'] as int? ?? 0,
      userId: json['user_id'] as int? ?? 0,
      location: json['location'] as String? ?? '',
      tags: json['tags'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      videoLink: json['video_link'] as String? ?? '',
      content: json['content'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      user: User.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }

  // Helper method to parse tags string into a List<String>
  List<String> get parsedTags {
    try {
      final decoded = jsonDecode(tags.replaceAll('\\"', '"'));
      return List<String>.from(decoded);
    } catch (e) {
      return [];
    }
  }
}

class User {
  final int id;
  final String name;
  final String mobile;
  final String profilePicture;

  User({
    required this.id,
    required this.name,
    required this.mobile,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      mobile: json['mobile'] as String? ?? '',
      profilePicture: json['profile_picture'] as String? ?? '',
    );
  }
}