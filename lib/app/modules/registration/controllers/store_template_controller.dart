import 'dart:convert';
import 'dart:io';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/data/models/store_category_model/store_template_model.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class StoreTemplateController extends GetxController {
  final StoreCategoryController storeCategoryController = Get.put(
    StoreCategoryController(),
  );
  var selectedLogoIndex = 0.obs;
  var selectedBannerIndex = 0.obs;
  var logoImage = Rx<File?>(null);
  var bannerImage = Rx<File?>(null);
  var logos = <StoreTemplateModel>[].obs;
  var banners = <StoreTemplateModel>[].obs;
  final ImagePicker _picker = ImagePicker();
  TextEditingController updateName = TextEditingController();
  var initials = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    print('StoreTemplateController: onInit called');
    updateName.text =
        storeCategoryController.previousPageGridTitle == 'Expert'
            ? 'Farmitra Expert'
            : storeCategoryController.previousPageGridTitle == 'Rental'
                ? 'Farmitra Rental'
                : storeCategoryController.previousPageGridTitle == 'Drone'
                    ? 'Farmitra Drone'
                    : 'Farmitra Mart';
    extractName(updateName.text);
    print('StoreTemplateController: Calling fetchLogos and fetchBanners');
    fetchLogos();
    fetchBanners();
    super.onInit();
  }

  @override
  void onClose() {
    updateName.dispose();
    super.onClose();
  }

  Future<void> fetchLogos() async {
    try {
      print('StoreTemplateController: fetchLogos started');
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(
          '${ApiEndpoints.getFullUrl(ApiEndpoints.fetchRegistrationMedia)}?category=logo',
        ),
        headers: {'Accept': 'application/json'},
      );
      print(
        'StoreTemplateController: fetchLogos response status: ${response.statusCode}',
      );
      print(
        'StoreTemplateController: fetchLogos response body: ${response.body}',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List rawList = data['data'] ?? [];
        print('StoreTemplateController: fetchLogos rawList: $rawList');
        logos.value = rawList
            .where((item) => item['media_url'] != null && item['media_url'].isNotEmpty)
            .map(
              (item) => StoreTemplateModel(
                backgroundColor: Colors.black,
                spanTextColor: Colors.white,
                bannerImage: item['media_url'],
              ),
            )
            .toList();
        print(
          'StoreTemplateController: fetchLogos logos updated: ${logos.length} items',
        );
      } else {
        logos.clear();
        print(
          'StoreTemplateController: fetchLogos failed with status: ${response.statusCode}',
        );
        Get.snackbar('Error', 'Failed to fetch logos');
      }
    } catch (e) {
      logos.clear();
      print('StoreTemplateController: fetchLogos error: $e');
      Get.snackbar('Error', 'Failed to fetch logos: $e');
    } finally {
      isLoading.value = false;
      print(
        'StoreTemplateController: fetchLogos completed, isLoading: ${isLoading.value}',
      );
    }
  }

  Future<void> fetchBanners() async {
    try {
      print('StoreTemplateController: fetchBanners started');
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(
          '${ApiEndpoints.getFullUrl(ApiEndpoints.fetchRegistrationMedia)}?category=banner',
        ),
        headers: {'Accept': 'application/json'},
      );
      print(
        'StoreTemplateController: fetchBanners response status: ${response.statusCode}',
      );
      print(
        'StoreTemplateController: fetchBanners response body: ${response.body}',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List rawList = data['data'] ?? [];
        print('StoreTemplateController: fetchBanners rawList: $rawList');
        banners.value = rawList
            .where((item) => item['media_url'] != null && item['media_url'].isNotEmpty)
            .map(
              (item) => StoreTemplateModel(
                backgroundColor: Colors.black,
                spanTextColor: Colors.white,
                bannerImage: item['media_url'],
              ),
            )
            .toList();
        print(
          'StoreTemplateController: fetchBanners banners updated: ${banners.length} items',
        );
      } else {
        banners.clear();
        print(
          'StoreTemplateController: fetchBanners failed with status: ${response.statusCode}',
        );
        Get.snackbar('Error', 'Failed to fetch banners');
      }
    } catch (e) {
      banners.clear();
      print('StoreTemplateController: fetchBanners error: $e');
      Get.snackbar('Error', 'Failed to fetch banners: $e');
    } finally {
      isLoading.value = false;
      print(
        'StoreTemplateController: fetchBanners completed, isLoading: ${isLoading.value}',
      );
    }
  }

  void extractName(String fullName) {
    final parts = fullName.trim().split(' ');
    firstName.value = parts.isNotEmpty ? parts.first : '';
    lastName.value = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    initials.value =
        (firstName.value.isNotEmpty ? firstName.value[0] : '') +
        (lastName.value.isNotEmpty ? lastName.value[0] : '');
    print(
      'StoreTemplateController: extractName called, firstName: ${firstName.value}, lastName: ${lastName.value}, initials: ${initials.value}',
    );
  }

  Widget getLogoWidget() {
    if (logoImage.value != null) {
      print('StoreTemplateController: getLogoWidget returning FileImage');
      return Image.file(logoImage.value!, fit: BoxFit.cover);
    } else if (logos.isNotEmpty &&
        logos[selectedLogoIndex.value].bannerImage.isNotEmpty) {
      print(
        'StoreTemplateController: getLogoWidget returning NetworkImage: ${logos[selectedLogoIndex.value].bannerImage}',
      );
      return Image.network(
        logos[selectedLogoIndex.value].bannerImage,
        fit: BoxFit.cover,
      );
    } else {
      print('StoreTemplateController: getLogoWidget returning Text("No Logo")');
      return Text("No Logo");
    }
  }

  Widget getBannerWidget() {
    if (bannerImage.value != null) {
      print('StoreTemplateController: getBannerWidget returning FileImage');
      return Image.file(bannerImage.value!, fit: BoxFit.cover);
    } else if (banners.isNotEmpty &&
        banners[selectedBannerIndex.value].bannerImage.isNotEmpty) {
      print(
        'StoreTemplateController: getBannerWidget returning NetworkImage: ${banners[selectedBannerIndex.value].bannerImage}',
      );
      return Image.network(
        banners[selectedBannerIndex.value].bannerImage,
        fit: BoxFit.cover,
      );
    } else {
      print(
        'StoreTemplateController: getBannerWidget returning Text("No Banner")',
      );
      return Text("No Banner");
    }
  }

  Future<void> pickImage(ImageSource source, bool isLogo) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      if (await file.exists()) {
        if (isLogo) {
          logoImage.value = file;
          print('StoreTemplateController: Logo image picked: ${file.path}');
        } else {
          bannerImage.value = file;
          print('StoreTemplateController: Banner image picked: ${file.path}');
        }
      } else {
        print('StoreTemplateController: Picked file does not exist: ${pickedFile.path}');
        Get.snackbar('Error', 'Selected image file is not accessible.');
      }
    }
  }

  void refresh() {
    fetchLogos();
    fetchBanners();
  }
}