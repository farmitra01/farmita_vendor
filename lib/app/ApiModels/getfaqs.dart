class FaqResponse {
  final bool success;
  final String message;
  final Map<String, List<FaqModel>> data;

  FaqResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FaqResponse.fromJson(Map<String, dynamic> json) {
    final parsedData = <String, List<FaqModel>>{};

    final dataField = json['data'];
    if (dataField is Map<String, dynamic>) {
      dataField.forEach((key, value) {
        if (value is List) {
          parsedData[key] = value
              .whereType<Map<String, dynamic>>() // ✅ Safe casting
              .map((item) => FaqModel.fromJson(item))
              .toList();
        }
      });
    }

    return FaqResponse(
      success: json['success'] == true,
      message: json['message'] ?? '',
      data: parsedData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((key, value) => MapEntry(
          key, value.map((faq) => faq.toJson()).toList())),
    };
  }
}

class FaqModel {
  final int id;
  final String question;
  final String answer;

  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      question: json['question']?.toString() ?? '',
      answer: json['answer']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }
}
