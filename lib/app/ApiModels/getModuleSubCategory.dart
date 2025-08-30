class ModuleSubCategoryResponse {
  bool status;
  String message;
  List<ModuleSubCategory> data;

  ModuleSubCategoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ModuleSubCategoryResponse.fromJson(Map<String, dynamic> json) {
    return ModuleSubCategoryResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List)
              .map((item) => ModuleSubCategory.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class ModuleSubCategory {
  final int id;
  final String? name;
  final int business_module_id;
  final int moduleCategoryId; // Required
  final String description; // Required
  final String status; // Required
  final String createdAt; // Required
  final String updatedAt; // Required
  final String? image; // Optional

  ModuleSubCategory({
    required this.id,
    this.name,
    required this.business_module_id,
    required this.moduleCategoryId,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });

  factory ModuleSubCategory.fromJson(Map<String, dynamic> json) {
    return ModuleSubCategory(
      id: json['id'] ?? 0,
      name: json['name']?.toString(),
      business_module_id: json['business_module_id'] ?? 0,
      moduleCategoryId: json['module_category_id'] ?? 0,
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? 'active',
      createdAt:
          json['created_at']?.toString() ?? DateTime.now().toIso8601String(),
      updatedAt:
          json['updated_at']?.toString() ?? DateTime.now().toIso8601String(),
      image: json['image']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'module_category_id': moduleCategoryId,
      'description': description,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image': image,
    };
  }
}
