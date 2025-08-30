class GetFarmerQueryByStatusPending {
    bool success;
    bool successStatus;
    String message;
    List<Datum> data;

    GetFarmerQueryByStatusPending({
        required this.success,
        required this.successStatus,
        required this.message,
        required this.data,
    });

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

}

class CropDetails {
    int id;
    String name;

    CropDetails({
        required this.id,
        required this.name,
    });

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

}
