class RegistrationMediaModel {
  bool success;
  String message;
  List<MediaData> data;

  RegistrationMediaModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RegistrationMediaModel.fromJson(Map<String, dynamic> json) {
    return RegistrationMediaModel(
      success: json['success'],
      message: json['message'],
      data: List<MediaData>.from(
        json['data'].map((x) => MediaData.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class MediaData {
  int id;
  String? mediaUrl;
  String? videoLink;
  String pdfTitle;
  String pdfLink;
  String category;

  MediaData({
    required this.id,
    this.mediaUrl,
    this.videoLink,
    required this.pdfTitle,
    required this.pdfLink,
    required this.category,
  });

  factory MediaData.fromJson(Map<String, dynamic> json) {
    return MediaData(
      id: json['id'],
      mediaUrl: json['media_url'],
      videoLink: json['video_link'],
      pdfTitle: json['pdf_title'] ?? '',
      pdfLink: json['pdf_link'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'media_url': mediaUrl,
    'video_link': videoLink,
    'pdf_title': pdfTitle,
    'pdf_link': pdfLink,
    'category': category,
  };
}
