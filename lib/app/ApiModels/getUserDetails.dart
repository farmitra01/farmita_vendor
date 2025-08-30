class UserDetailsResponse {
  final bool status;
  final String message;
  final UserData? data;

  UserDetailsResponse({required this.status, required this.message, this.data});

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailsResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"status": status, "message": message, "data": data?.toJson()};
  }
}

class UserData {
  final int? id;
  final int? businessModuleId;
  final int? moduleCategoryId;
  final int? userId;
  final String? storeName;
  final String? vendorName;
  final String? whatsappNo;
  final String? email;
  final String? logo;
  final String? bannerImage;
  final String? createdAt;
  final String? updatedAt;
  final int? status;
  final String? address;
  final String? pincode;
  final String? landmark;
  final String? currentLocation;
  final String? about;
  final String? language;
  final User? user;
  final BusinessModule? businessModule;
  final Category? category;
  final List<SubCategory>? subcategories;
  final List<ImageData>? images;
  final BankAccount? bankAccount;
  final UpiDetail? upiDetail;
  final List<Document>? documents;
  final List<Document>? storeDocuments;

  UserData({
    this.id,
    this.businessModuleId,
    this.moduleCategoryId,
    this.userId,
    this.storeName,
    this.vendorName,
    this.whatsappNo,
    this.email,
    this.logo,
    this.bannerImage,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.address,
    this.pincode,
    this.landmark,
    this.currentLocation,
    this.about,
    this.language,
    this.user,
    this.businessModule,
    this.category,
    this.subcategories,
    this.images,
    this.bankAccount,
    this.upiDetail,
    this.documents,
    this.storeDocuments,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      businessModuleId: json['business_module_id'],
      moduleCategoryId: json['module_category_id'],
      userId: json['user_id'],
      storeName: json['store_name'],
      vendorName: json['vendor_name'],
      whatsappNo: json['whatsapp_no'],
      email: json['email'],
      logo: json['logo'],
      bannerImage: json['banner_image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status'],
      address: json['address'],
      landmark: json['landmark'] is String ? json['landmark'] : null,
      currentLocation:
          json['current_location'] is String ? json['current_location'] : null,
      about: json['about'] is String ? json['about'] : null,
      language:
          json['language'] is String
              ? json['language']
              : (json['language'] is List
                  ? (json['language'] as List).join(', ')
                  : null),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      businessModule:
          json['business_module'] != null
              ? BusinessModule.fromJson(json['business_module'])
              : null,
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      subcategories:
          (json['subcategories'] as List?)
              ?.map((e) => SubCategory.fromJson(e))
              .toList() ??
          [],
      images:
          (json['images'] as List?)
              ?.map((e) => ImageData.fromJson(e))
              .toList() ??
          [],
      bankAccount:
          json['bank_account'] != null
              ? BankAccount.fromJson(json['bank_account'])
              : null,
      upiDetail:
          json['upi_detail'] != null
              ? UpiDetail.fromJson(json['upi_detail'])
              : null,
      documents:
          (json['documents'] as List?)
              ?.map((e) => Document.fromJson(e))
              .toList() ??
          [],
      storeDocuments:
          (json['store_documents'] as List?)
              ?.map((e) => Document.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "business_module_id": businessModuleId,
      "module_category_id": moduleCategoryId,
      "user_id": userId,
      "store_name": storeName,
      "vendor_name": vendorName,
      "whatsapp_no": whatsappNo,
      "email": email,
      "logo": logo,
      "banner_image": bannerImage,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "status": status,
      "address": address,
      "pincode": pincode,
      "landmark": landmark,
      "current_location": currentLocation,
      "about": about,
      "language": language,
      "user": user?.toJson(),
      "business_module": businessModule?.toJson(),
      "category": category?.toJson(),
      "subcategories": subcategories?.map((e) => e.toJson()).toList(),
      "images": images?.map((e) => e.toJson()).toList(),
      "bank_account": bankAccount?.toJson(),
      "upi_detail": upiDetail?.toJson(),
      "documents": documents?.map((e) => e.toJson()).toList(),
      "store_documents": storeDocuments?.map((e) => e.toJson()).toList(),
    };
  }
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? mobile;

  User({this.id, this.name, this.email, this.mobile});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
  };
}

class BusinessModule {
  final int? id;
  final String? name;
  final String? desc;

  BusinessModule({this.id, this.name, this.desc});

  factory BusinessModule.fromJson(Map<String, dynamic> json) {
    return BusinessModule(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "desc": desc};
}

class Category {
  final int? id;
  final String? name;
  final String? description;

  Category({this.id, this.name, this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}

class SubCategory {
  final int? id;
  final String? name;
  final Pivot? pivot;

  SubCategory({this.id, this.name, this.pivot});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  final int? vendorId;
  final int? subcategoryId;

  Pivot({this.vendorId, this.subcategoryId});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      vendorId: json['vendor_id'],
      subcategoryId: json['subcategory_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId,
    "subcategory_id": subcategoryId,
  };
}

class ImageData {
  final int? id;
  final String? url;

  ImageData({this.id, this.url});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(id: json['id'], url: json['url']);
  }

  Map<String, dynamic> toJson() => {"id": id, "url": url};
}

class BankAccount {
  final String? accountNumber;
  final String? ifscCode;
  final String? bankName;
  final String? holderName;

  BankAccount({
    this.accountNumber,
    this.ifscCode,
    this.bankName,
    this.holderName,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      accountNumber: json['account_number'],
      ifscCode: json['ifsc_code'],
      bankName: json['bank_name'],
      holderName: json['holder_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    "account_number": accountNumber,
    "ifsc_code": ifscCode,
    "bank_name": bankName,
    "holder_name": holderName,
  };
}

class UpiDetail {
  final String? upiId;

  UpiDetail({this.upiId});

  factory UpiDetail.fromJson(Map<String, dynamic> json) {
    return UpiDetail(upiId: json['upi_id']);
  }

  Map<String, dynamic> toJson() => {"upi_id": upiId};
}

class Document {
  final int? id;
  final String? name;
  final String? url;

  Document({this.id, this.name, this.url});

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(id: json['id'], name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "url": url};
}
