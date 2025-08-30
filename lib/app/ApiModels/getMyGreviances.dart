class GrievanceCategory {
  final int id;
  final String name;

  GrievanceCategory({
    required this.id,
    required this.name,
  });

  factory GrievanceCategory.fromJson(Map<String, dynamic> json) {
    return GrievanceCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class GrievanceModel {
  final int id;
  final int categoryId;
  final String description; // renamed from 'query'
  final String image;
  final String status;
  final String? adminRemark;
  final DateTime createdAt;
  final GrievanceCategory category;

  GrievanceModel({
    required this.id,
    required this.categoryId,
    required this.description,
    required this.image,
    required this.status,
    this.adminRemark,
    required this.createdAt,
    required this.category,
  });

  factory GrievanceModel.fromJson(Map<String, dynamic> json) {
    return GrievanceModel(
      id: json['id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      description: json['query'] ?? '', // still mapping from 'query'
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      adminRemark: json['admin_remark'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      category: GrievanceCategory.fromJson(json['category'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'query': description, // match backend key
      'image': image,
      'status': status,
      'admin_remark': adminRemark,
      'created_at': createdAt.toIso8601String(),
      'category': category.toJson(),
    };
  }

  static List<GrievanceModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => GrievanceModel.fromJson(json)).toList();
  }
}
