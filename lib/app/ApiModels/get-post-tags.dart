class GetPostTags {
  bool? status;
  String? message;
  List<TagData>? data;

  GetPostTags({
    this.status,
    this.message,
    this.data,
  });

  factory GetPostTags.fromJson(Map<String, dynamic> json) {
    return GetPostTags(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TagData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class TagData {
  int? id;
  String? name;

  TagData({
    this.id,
    this.name,
  });

  factory TagData.fromJson(Map<String, dynamic> json) {
    return TagData(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => name ?? '';
}
