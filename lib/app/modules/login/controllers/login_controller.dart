import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginController extends GetxController {
  /// ✅ Proper initialization of controller
  final TextEditingController mobileNumber = TextEditingController();

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  RxBool isInternetConnected = true.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      isInternetConnected.value = !results.contains(ConnectivityResult.none);
      if (!isInternetConnected.value) {
        showInternetErrorDialog();
      } else if (Get.isDialogOpen!) {
        Get.back();
        ();
      }
    });

    checkInternetConnectivity();
  }

  Future<void> checkInternetConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    isInternetConnected.value = !result.contains(ConnectivityResult.none);
  }

  void showInternetErrorDialog() {
    if (!Get.isDialogOpen!) {
      Get.dialog(buildNetworkError(), barrierDismissible: false);
    }
  }

  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter 10 digit mobile number';
    }
    if (value.length != 10) {
      return 'Enter valid 10 digit mobile number';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Only digits allowed';
    }
    return null;
  }

  /// 🔁 Old login function (commented)
  /*
  Future<void> login() async {
    final request = PostLoginRequest(
      email: 'sattababakingup@gmail.com',
      password: 'uPYwDOUz',
    );

    final response = await _apiService.callApi(
      endpoint: ApiEndpoints.login,
      method: 'POST',
      body: request.toJson(),
    );

    if (response['success']) {
      final token = response['data']['token'] ?? response['data']['data']?['token'];
      if (token != null) {
        await GetStorage().write('user_token', token);
        print("Token stored: ${GetStorage().read('user_token')}");
        Get.snackbar("Success", "Logged in successfully");
      } else {
        print("Token not found in response");
        Get.snackbar("Error", "Token not found");
      }
    } else {
      Get.snackbar("Error", response['data']['message'] ?? 'Login failed');
    }
  }
  */

  /// ✅ New login with OTP
  Future<void> loginWithOtp() async {
    final mobile = mobileNumber.text.trim();
    print('login with otp function start');

    final validationMessage = validateMobileNumber(mobile);
    if (validationMessage != null) {
      Get.snackbar(
        "Invalid",
        validationMessage,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final body = {"mobile": mobile, "app_type": " "};

    try {
      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.userLoginWithOtp,
        method: 'POST',
        body: body,
      );
      print('Response ${response}');

      if (response['success'] == true) {
        // print('');
        // Get.snackbar(
        //   "Success",
        //   "OTP sent to $mobile",
        //   backgroundColor: AppColors.primaryGradinatMixColor,
        //   colorText: AppColors.white,
        //   snackPosition: SnackPosition.TOP,
        //   duration: const Duration(seconds: 2),
        // );

        await Future.delayed(const Duration(seconds: 2));
        Get.toNamed("/otp", arguments: mobile);
      } else {
        Get.snackbar(
          "Failed",
          response['message'] ?? "Something went wrong",
          backgroundColor: AppColors.error,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Server Error: ${e.toString()}",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void printStoredToken() {
    final token = GetStorage().read('user_token');
    if (token != null) {
      // debugPrint('Retrieved Token: $token');
      Get.snackbar(
        'Token',
        token,
        backgroundColor: AppColors.primaryGradinatMixColor,
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
      );
    } else {
      debugPrint('No token found in GetStorage');
      Get.snackbar(
        'Error',
        'No token found',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  void onClose() {
    mobileNumber.dispose(); // ✅ dispose controller
    _connectivitySubscription?.cancel();
    super.onClose();
  }

  // void clearController() {
  //   mobileNumber.clear();
  // }

  Widget buildNetworkError() {
    return AlertDialog(
      title: Column(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(Icons.error_outline, size: 50, color: AppColors.error),
          ),
          const SizedBox(height: 10),
          Text(
            'Please Check your Internet Connection',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await checkInternetConnectivity();
            if (isInternetConnected.value) {
              Get.closeAllSnackbars();
              Get.back(closeOverlays: true);
              ();
            } else {
              Get.snackbar(
                'No Internet',
                'Please enable internet and try again',
                backgroundColor: AppColors.error,
                colorText: AppColors.white,
                duration: const Duration(seconds: 3),
              );
            }
          },
          child: Text(
            'Retry',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryGradinatMixColor,
            ),
          ),
        ),
      ],
    );
  }
}
