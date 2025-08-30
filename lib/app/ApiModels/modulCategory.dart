class ModuleCategoryModel {
  final int? id;
  final int? businessModuleId;
  final String name;
  final String image;
  final String description;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ModuleCategoryModel({
    this.id,
    this.businessModuleId,
    this.name = '',
    this.image = '',
    this.description = '',
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ModuleCategoryModel.fromJson(Map<String, dynamic> json) {
    return ModuleCategoryModel(
      id: _parseInt(json['id']),
      businessModuleId: _parseInt(json['business_module_id']),
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      status: _parseInt(json['status']),
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_module_id': businessModuleId,
      'name': name,
      'image': image,
      'description': description,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Helper method to safely parse int
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  // Helper method to safely parse DateTime
  static DateTime? _parseDateTime(dynamic value) {
    if (value == null || value.toString().isEmpty) return null;
    try {
      return DateTime.parse(value.toString());
    } catch (e) {
      return null;
    }
  }
}
