class ReportPostResponse {
  final bool success;
  final String message;

  ReportPostResponse({required this.success, required this.message});

  factory ReportPostResponse.fromJson(Map<String, dynamic> json) {
    return ReportPostResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message};
  }
}
