import 'package:farmitra/app/ApiModels/getUserDetails.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/registration/controllers/store_location_controller.dart';
import 'package:farmitra/app/modules/storeProfile/controllers/store_profile_controller.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

final StoreProfileController storeProfileController = Get.find();

class StoresTabProfileController extends GetxController {
  //TODO: Implement ProfileController
  final StoreLocationController storeLocationController = Get.put(
    StoreLocationController(),
  );

  var userRole = ''.obs;
  final count = 0.obs;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();

    userRole.value = box.read('user_role') ?? '';
    // fetchUserDetails();
    final storedStoreName =
        storeProfileController.userDetails.value?.data?.storeName ?? "N/A";
    storeName.text = storedStoreName;
  }

  @override
  void onReady() {
    // setDetailsFromApi();
    super.onReady();
  }

  // @override
  // void onClose() {
  //   storeProfileController.userDetails.value = null;
  //   super.onClose();
  // }

  void increment() => count.value++;

  final TextEditingController storeName = TextEditingController();
  final TextEditingController whatsAppNo = TextEditingController();
  // final TextEditingController email = TextEditingController();
  final TextEditingController completeAddress = TextEditingController();
  // final TextEditingController floor = TextEditingController();
  final TextEditingController pinCode = TextEditingController();
  final TextEditingController webSiteLInk = TextEditingController();
  final TextEditingController redius = TextEditingController();
  final TextEditingController minOrderValue = TextEditingController();
  final TextEditingController giftWrapAmmount = TextEditingController();
  final TextEditingController startTime = TextEditingController();
  final TextEditingController endTime = TextEditingController();

  var name = TextEditingController();
  var number = TextEditingController();
  // var altNumber = TextEditingController();
  var email = TextEditingController();
  // var location = TextEditingController();
  var address = TextEditingController();
  var landmark = TextEditingController();
  var pincode = TextEditingController();
  var About = TextEditingController();

  RxBool isAddtionalCharges = false.obs;

  final List<String> bannerImage = [
    'assets/svgs/storeProfile/storeBg1.svg',
    'assets/svgs/storeProfile/storeBg2.svg',
  ];

  // final List<String> gridImage = [
  //   'assets/images/storeProfile/bannerImage-1.jpg',
  //   'assets/images/storeProfile/bannerImage-2.jpg',
  //   'assets/images/storeProfile/bannerImage-3.jpg',
  //   'assets/images/storeProfile/bannerImage-4.jpg',
  //   'assets/images/storeProfile/bannerImage-5.jpg',
  // ];
  // Reactive variables for storing image paths
  var selectedLogoPath = RxString('');
  var selectedBannerPath = RxString('');
  var inside = RxString('');
  var outside = RxString('');
  // Initialize ImagePicker
  final ImagePicker _picker = ImagePicker();

  // Validation flags for logo and banner
  var isLogoValid = true.obs;
  var isBannerValid = true.obs;
  var isInsideValid = true.obs;
  var isOutsideValid = true.obs;

  // Function to pick an image
  Future<void> pickImage(String imageType) async {
    final ImageSource? source = await Get.dialog<ImageSource>(
      AlertDialog(
        title: Text(
          'Select Image',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryGradinatMixColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: ImageSource.camera),
            child: Text(
              'Camera',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGradinatMixColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: ImageSource.gallery),
            child: Text(
              'Gallery',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGradinatMixColor,
              ),
            ),
          ),
        ],
      ),
    );

    if (source == null) return; // User dismissed the dialog

    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (imageType == 'logo') {
      if (pickedFile != null) {
        selectedLogoPath.value = pickedFile.path;
        isLogoValid.value = true;
      } else {
        isLogoValid.value = false;
      }
    } else if (imageType == 'banner') {
      if (pickedFile != null) {
        selectedBannerPath.value = pickedFile.path;
        isBannerValid.value = true;
      } else {
        isBannerValid.value = false;
      }
    } else if (imageType == 'inside') {
      if (pickedFile != null) {
        inside.value = pickedFile.path;
        isInsideValid.value = true;
      } else {
        isInsideValid.value = false;
      }
    } else if (imageType == 'outside') {
      if (pickedFile != null) {
        outside.value = pickedFile.path;
        isOutsideValid.value = true;
      } else {
        isOutsideValid.value = false;
      }
    }
  }

  var selectedGender = 'Male'.obs; // Default selection

  void changeGender(String value) {
    selectedGender.value = value;
  }

  RxList<int> selectedIndexes = <int>[].obs;

  void toggleSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
  }

  bool isSelected(int index) => selectedIndexes.contains(index);
  List<String> languages = [
    'Hindi',
    'English',
    'Gujrati',
    'Marathi',
    'Telagu',
    'Bengali',
    'Kannada',
    'Hariyanvi',
    'Panjabi',
    'Hydrabadi',
  ];

  var isLoading = false.obs;

  List<Map<String, dynamic>> detailsList =
      [
        {
          "details": "Name",
          "data":
              storeProfileController.userDetails.value?.data?.vendorName ??
              "N/A",
        },
        {
          "details": "WhatsApp",
          "data":
              storeProfileController.userDetails.value?.data?.whatsappNo ??
              "N/A",
        },
        {
          "details": "Email",
          "data":
              storeProfileController.userDetails.value?.data?.email ?? "N/A",
        },

        {
          "details": "Address",
          "data":
              storeProfileController.userDetails.value?.data?.address ?? "N/A",
        },
      ].obs;
  // final box = GetStorage();

  List<Map<String, dynamic>> moduleDetailsList =
      [
        {
          'color': 0xffFFE7E7,
          'icon': Icons.diamond_outlined,
          'title':
              storeProfileController
                  .userDetails
                  .value
                  ?.data
                  ?.businessModule
                  ?.name,

          //     ?.map((e) => e.name)
          //     .join(", ") ??
          // "N/A",
          'subtitle': 'Nature',
        },
        {
          'color': 0xffE8F4FF,
          'icon': Icons.store_outlined,
          'title':
              storeProfileController.userDetails.value?.data?.category?.name,
          //     ?.map((e) => e.name)
          //     .join(", ") ??
          // "N/A",
          'subtitle': 'Module',
        },
        {
          'color': 0xffFDF8DD,
          'icon': Icons.add_business_outlined,
          'title':
              storeProfileController.userDetails.value?.data?.subcategories
                  ?.map((e) => e.name)
                  .join(", ") ??
              "N/A",
          'subtitle': 'Category',
        },
      ].obs;

  List<Map<String, dynamic>> documentlist = [
    {
      'file_name': 'Shoplicense.pdf',
      'id_number': '201 103 XXX X',
      'uploaded_on': 'Uploaded on: 2024, March 24',
    },
  ];
}
