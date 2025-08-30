class CommentResponse {
  final bool success;
  final String message;
  final String comment;

  CommentResponse({
    required this.success,
    required this.message,
    required this.comment,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      comment: json['comment'] ?? '',
    );
  }
}
