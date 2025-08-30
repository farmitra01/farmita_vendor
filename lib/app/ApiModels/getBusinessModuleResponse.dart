class BusinessModulesResponse {
  final bool status;
  final String? message;
  final List<BusinessModule> data;

  BusinessModulesResponse({
    required this.status,
    this.message,
    required this.data,
  });

  factory BusinessModulesResponse.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON data field: ${json['data']}'); // Debug: Log raw data
    return BusinessModulesResponse(
      status: json['status'] == true || json['status'] == 'true' || json['status'] == 1,
      message: json['message']?.toString(),
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => BusinessModule.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class BusinessModule {
  final int id;
  final String? name;
  final String? desc;
  final bool status;
  final DateTime createdAt;
  final DateTime updatedAt;

  BusinessModule({
    required this.id,
    this.name,
    this.desc,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BusinessModule.fromJson(Map<String, dynamic> json) {
    print('Parsing BusinessModule: $json'); // Debug: Log each item
    return BusinessModule(
      id: (json['id'] is int) ? json['id'] as int : int.parse(json['id'].toString()), // Handle int or String
      name: json['name']?.toString(),
      desc: json['desc']?.toString(),
      status: json['status'] == true || json['status'] == 'true' || json['status'] == 1 || json['status'] == '1',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '1970-01-01T00:00:00Z') ?? DateTime(1970),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '1970-01-01T00:00:00Z') ?? DateTime(1970),
    );
  }
}