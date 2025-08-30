class GetFarmerQueryByStatusAccepted {
  bool success;
  bool successStatus;
  String message;
  List<Datum> data;

  GetFarmerQueryByStatusAccepted({
    required this.success,
    required this.successStatus,
    required this.message,
    required this.data,
  });

  factory GetFarmerQueryByStatusAccepted.fromJson(Map<String, dynamic> json) {
    return GetFarmerQueryByStatusAccepted(
      success: json['success'],
      successStatus: json['successStatus'],
      message: json['message'],
      data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
    );
  }
}
class Datum {
  int id;
  int farmerId;
  int cropCategoryId;
  int cropId;
  int expertId;
  String query;
  String queryStatus;
  String queryType;
  DateTime appointmentDate;
  String appointmentTime;
  String appointmentType;
  dynamic expertResponse;
  DateTime createdAt;
  DateTime updatedAt;
  FarmerDetails farmerDetails;
  CropDetails cropDetails;
  List<dynamic> queryImages;

  Datum({
    required this.id,
    required this.farmerId,
    required this.cropCategoryId,
    required this.cropId,
    required this.expertId,
    required this.query,
    required this.queryStatus,
    required this.queryType,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentType,
    required this.expertResponse,
    required this.createdAt,
    required this.updatedAt,
    required this.farmerDetails,
    required this.cropDetails,
    required this.queryImages,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'],
      farmerId: json['farmer_id'],
      cropCategoryId: json['crop_category_id'],
      cropId: json['crop_id'],
      expertId: json['expert_id'],
      query: json['query'],
      queryStatus: json['query_status'],
      queryType: json['query_type'],
      appointmentDate: DateTime.parse(json['appointment_date']),
      appointmentTime: json['appointment_time'],
      appointmentType: json['appointment_type'],
      expertResponse: json['expert_response'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      farmerDetails: FarmerDetails.fromJson(json['farmer_details']),
      cropDetails: CropDetails.fromJson(json['crop_details']),
      queryImages: List<dynamic>.from(json['query_images'] ?? []),
    );
  }
}
class FarmerDetails {
  int id;
  String name;
  String? email;
  String mobile;

  FarmerDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
  });

  factory FarmerDetails.fromJson(Map<String, dynamic> json) {
    return FarmerDetails(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
    );
  }
}
class CropDetails {
  int id;
  String name;

  CropDetails({
    required this.id,
    required this.name,
  });

  factory CropDetails.fromJson(Map<String, dynamic> json) {
    return CropDetails(
      id: json['id'],
      name: json['name'],
    );
  }
}
