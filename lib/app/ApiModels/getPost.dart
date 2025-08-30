import 'dart:convert';

class PostResponse {
  final bool success;
  final String? message;
  final List<Post> data;

  PostResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    print('JSON Response: $json'); // Debug: Log full JSON
    List<dynamic> postList = [];
    if (json['data'] != null) {
      if (json['data'] is List<dynamic>) {
        postList = json['data'];
        print('Data is a List: $postList'); // Debug
      } else if (json['data'] is Map<String, dynamic>) {
        final dataMap = json['data'] as Map<String, dynamic>;
        print('Data is a Map with keys: ${dataMap.keys}'); // Debug: Log keys
        for (var key in ['posts', 'results', 'items', 'data', 'records']) {
          if (dataMap[key] != null && dataMap[key] is List<dynamic>) {
            postList = dataMap[key];
            print('Found post list under key "$key": $postList'); // Debug
            break;
          }
        }
        if (postList.isEmpty) {
          print('No valid post list found in data map'); // Debug
        }
      } else {
        print('Data field is neither List nor Map: ${json['data']}'); // Debug
      }
    } else {
      print('Data field is null'); // Debug
    }

    return PostResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? 'No message provided',
      data: postList.map((item) {
        print('Parsing post: $item'); // Debug
        try {
          return Post.fromJson(item as Map<String, dynamic>);
        } catch (e) {
          print('Error parsing post: $e'); // Debug
          return null;
        }
      }).where((post) => post != null).cast<Post>().toList(),
    );
  }
}

class Post {
  final int id;
  final int postId; // ✅ Added explicitly
  final int userId; // ✅ Added explicitly
  final String content;
  final PostedBy postedBy;
  final List<PostImage> postImages;
  final List<String> tags;
  final String location;
  final String createdAt;
  final int totalLikes;
  final int totalComments;

  Post({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.postedBy,
    required this.postImages,
    required this.tags,
    required this.location,
    required this.createdAt,
    required this.totalLikes,
    required this.totalComments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    print('Post JSON: $json'); // Debug: Log post JSON
    print('tags raw: ${json['tags']}'); // Debug
    print('postImages raw: ${json['post_images']}'); // Debug

    // Handle tags
    List<String> tags = [];
    if (json['tags'] != null) {
      try {
        if (json['tags'] is String) {
          final tagsData = json['tags'] as String;
          if (tagsData.startsWith('[')) {
            tags = (jsonDecode(tagsData) as List<dynamic>).cast<String>();
          } else {
            tags = tagsData.split(',').map((tag) => tag.trim()).toList();
          }
        } else if (json['tags'] is List<dynamic>) {
          tags = (json['tags'] as List<dynamic>).cast<String>();
        }
      } catch (e) {
        print('Error parsing tags: $e'); // Debug
      }
    }

    // Handle post_images
    List<PostImage> postImages = [];
    if (json['post_images'] != null && json['post_images'] is List<dynamic>) {
      try {
        postImages = (json['post_images'] as List<dynamic>)
            .map((item) => PostImage.fromJson(item as Map<String, dynamic>))
            .toList();
      } catch (e) {
        print('Error parsing post_images: $e'); // Debug
      }
    }

    return Post(
      id: json['id'] ?? 0,
      postId: json['post_id'] ?? json['id'] ?? 0, // fallback if post_id missing
      userId: json['posted_by_id'] ?? 0,
      content: json['content'] ?? '',
      postedBy: PostedBy.fromJson(json['posted_by'] ?? {}),
      postImages: postImages,
      tags: tags,
      location: json['location'] ?? '',
      createdAt: json['created_at'] ?? '',
      totalLikes: json['total_likes'] ?? 0,
      totalComments: json['total_comments'] ?? 0,
    );
  }
}

class PostedBy {
  final String name;
  final String? profilePicture;

  PostedBy({
    required this.name,
    this.profilePicture,
  });

  factory PostedBy.fromJson(Map<String, dynamic> json) {
    return PostedBy(
      name: json['name'] ?? 'Unknown',
      profilePicture: json['profile_picture'],
    );
  }
}

class PostImage {
  final String image;

  PostImage({required this.image});

  factory PostImage.fromJson(Map<String, dynamic> json) {
    return PostImage(image: json['image'] ?? '');
  }
}
