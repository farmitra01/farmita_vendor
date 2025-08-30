class GrievancesCategoryModel {
  final int id;
  final String name;

  GrievancesCategoryModel({required this.id, required this.name});

  factory GrievancesCategoryModel.fromJson(Map<String, dynamic> json) {
    return GrievancesCategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  String toString() => 'GrievancesCategoryModel(id: $id, name: $name)';

  /// Helper method to convert a list of dynamic maps to a list of models
  static List<GrievancesCategoryModel> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => GrievancesCategoryModel.fromJson(json))
        .toList();
  }
}
