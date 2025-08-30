import 'dart:async';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/modules/home/views/home_bottom_bar_view.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OtpController extends GetxController {
  var otpErrorMessage = ''.obs;
  final box = GetStorage();

  final List<TextEditingController> OTPcontrollers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  final ApiService _apiService = ApiService();

  late String mobile;
  final String app_type = "vendor";
  final String deviceToken = "abc123xyz";

  @override
  void onInit() {
    super.onInit();
    mobile = box.read('login_mobileNumber');
    startTimer();
    print('Stored Vendor Details on OTP page ${box.read('user_details')} ');
    print('Stored Vendor Role on OTP Page ${box.read('user_role')}');
  }

  void onOTPChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    checkOtpFilled();
  }

  void OTPValidation() {
    Get.snackbar(
      'Notice',
      'Please enter a valid 4-digit OTP',
      backgroundColor: AppColors.primaryGradinatMixColor,
      colorText: AppColors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  RxInt remainingSeconds = 120.obs;
  RxBool isButtonEnabled = false.obs;
  var isLoading = false.obs;
  Timer? _timer;

  RxBool isOtpFilled = false.obs;

  void checkOtpFilled() {
    isOtpFilled.value = OTPcontrollers.every(
      (controller) => controller.text.trim().isNotEmpty,
    );
  }

  void startTimer() {
    _timer?.cancel(); // cancel existing timer if any
    remainingSeconds.value = 120;
    isButtonEnabled.value = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        isButtonEnabled.value = true;
      }
    });
  }

  String get formattedTime {
    int minutes = remainingSeconds.value ~/ 60;
    int seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool isOtpComplete() {
    return OTPcontrollers.every(
      (controller) => controller.text.trim().isNotEmpty,
    );
  }

  void showOtpError(String message) {
    otpErrorMessage.value = message;
  }

  Future<void> submitOtp() async {
    final otp = OTPcontrollers.map((c) => c.text).join();

    // Step 1: Local OTP validation
    if (otp.length != 4 || !RegExp(r'^\d{4}$').hasMatch(otp)) {
      OTPValidation();
      return;
    }

    final body = {
      "mobile": mobile,
      "otp": otp,
      "device_token": deviceToken,
      "app_type": app_type,
    };

    try {
      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.verifyOtp,
        method: 'POST',
        body: body,
      );

      final statusCode = response['statusCode'];
      final responseData = response['data'] ?? {};

      if (statusCode == 401) {
        showOtpError("Incorrect OTP Entered");
        return;
      }

      if (statusCode == 417) {
        // Get.snackbar(
        //   "Registration Required",
        //   "Please complete your registration",
        //   backgroundColor: AppColors.error,
        //   colorText: AppColors.white,
        //   snackPosition: SnackPosition.TOP,
        // );
        // showOtpError("Vendor Not Found,Please Complete your Registra ");
        final token = responseData['errors']?['token'];
        if (token != null) {
          box.write('user_token', token);
          print('Stored registration token: $token');

          Future.delayed(const Duration(seconds: 1), () {
            Get.offAllNamed('/registration');
          });
        } else {
          print('Notice : Registration token not found');
        }
        return;
      }

      if (statusCode == 200) {
        // print('response data'+responseData.toString());
        final token = responseData['data']['token'];
        final user = responseData['data']['vendor'] ?? {};
        final roleList = responseData['data']['roles'] ?? [];
        final role = roleList.isNotEmpty ? roleList[0] : null;
        final userId = user['id'];
        // final appType = responseData['data']['app_type'];

        box.write('user_data', response);
        if (token != null) box.write('user_token', token);
        if (user != null) box.write('user_details', user);
        if (role != null) box.write('user_role', role);
        // if (appType != null) box.write('user_type', appType);

        print('Token: $token');
        print('Role: $role');
        print('User ID: $userId');
        // print('App Type: $appType');

        // Get.snackbar(
        //   "Success",
        //   "Login Successful",
        //   backgroundColor: AppColors.primaryGradinatMixColor,
        //   colorText: AppColors.white,
        //   snackPosition: SnackPosition.TOP,
        // );
        // Clear all OTP text fields
        for (final controller in OTPcontrollers) {
          controller.clear();
        }
        Future.delayed(const Duration(milliseconds: 100), () {
          if (role != null) {
            Get.offAll(() => HomeBottomBarView());
          } else {
            Get.offAllNamed('/registration');
          }
        });
        return;
      }

      final message = responseData['message'] ?? "Something went wrong.";
      print(message);
      // Get.snackbar(
      //   "Notice",
      //   message,
      //   backgroundColor: AppColors.error,
      //   colorText: AppColors.white,
      //   snackPosition: SnackPosition.TOP,
      // );
    } catch (e) {
      print('${e.toString()}');
      // Get.snackbar(
      //   "Error",
      //   "Something went wrong: ${e.toString()}",
      //   backgroundColor: AppColors.error,
      //   colorText: AppColors.white,
      //   snackPosition: SnackPosition.TOP,
      // );
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
