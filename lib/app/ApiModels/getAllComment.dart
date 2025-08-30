class AllComment {
  final bool success;
  final String message;
  final int totalComments;
  final List<CommentModel> data;

  AllComment({
    required this.success,
    required this.message,
    required this.totalComments,
    required this.data,
  });

  factory AllComment.fromJson(Map<String, dynamic> json) {
    return AllComment(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      totalComments: json['total_comments'] ?? 0,
      data: (json['data'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CommentModel {
  final int id;
  final int postId;
  final int postedBy;
  final String comment;
  final String createdAt;
  final CommentedBy commentedBy;

  CommentModel({
    required this.id,
    required this.postId,
    required this.postedBy,
    required this.comment,
    required this.createdAt,
    required this.commentedBy,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      postId: json['post_id'],
      postedBy: json['posted_by'],
      comment: json['comment'],
      createdAt: json['created_at'],
      commentedBy: CommentedBy.fromJson(json['commented_by']),
    );
  }
}

class CommentedBy {
  final int id;
  final String name;
  final String? profilePicture;

  CommentedBy({
    required this.id,
    required this.name,
    this.profilePicture,
  });

  factory CommentedBy.fromJson(Map<String, dynamic> json) {
    return CommentedBy(
      id: json['id'],
      name: json['name'],
      profilePicture: json['profile_picture'],
    );
  }
}
