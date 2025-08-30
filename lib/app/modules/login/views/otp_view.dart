import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/login/controllers/login_controller.dart';
import 'package:farmitra/app/modules/login/controllers/otp_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpView extends StatelessWidget {
  OtpView({super.key});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final OtpController otpController = Get.put(OtpController());
    final LoginController loginController = Get.put(LoginController());

    bool isOtpComplete() =>
        otpController.OTPcontrollers.every((c) => c.text.trim().isNotEmpty);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white),
              ),
              child: const Center(
                child: Icon(Icons.arrow_back, size: 20, color: AppColors.white),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OTP Verification',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'We have sent a verification code on',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff636363),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '+91 ${otpController.mobile}',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 100),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 50,
                            height: 50,
                            child: Obx(
                              () => TextFormField(
                                cursorColor: AppColors.primaryGradinatMixColor,
                                controller: otpController.OTPcontrollers[index],
                                focusNode: otpController.focusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          otpController
                                                  .otpErrorMessage
                                                  .isNotEmpty
                                              ? AppColors.error
                                              : const Color(0xff636363),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          otpController
                                                  .otpErrorMessage
                                                  .isNotEmpty
                                              ? AppColors.error
                                              : AppColors
                                                  .primaryGradinatMixColor,
                                    ),
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.error,
                                    ),
                                  ),
                                ),
                                maxLines: 1,
                                onChanged:
                                    (value) => otpController.onOTPChanged(
                                      value,
                                      index,
                                    ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 8),
                      Obx(() {
                        return otpController.otpErrorMessage.isNotEmpty
                            ? Text(
                              otpController.otpErrorMessage.value,
                              style: const TextStyle(
                                color: AppColors.error,
                                fontSize: 12,
                              ),
                            )
                            : const SizedBox();
                      }),
                      const SizedBox(height: 30),
                      Obx(
                        () => CustomGradientButton(
                          text: 'Verify',
                          gradientColors:
                              otpController.isOtpFilled.value
                                  ? [
                                    AppColors.primaryFirstGradiant,
                                    AppColors.primarySecondGradiant,
                                  ]
                                  : [AppColors.border, AppColors.border],
                          onPressed: () {
                            if (!otpController.isOtpFilled.value) return;

                            Future(() async {
                              Get.dialog(
                                Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryGradinatMixColor,
                                  ),
                                ),
                                barrierDismissible: false,
                              );

                              try {
                                await Future.delayed(
                                  const Duration(seconds: 3),
                                );

                                if (_formkey.currentState!.validate()) {
                                  otpController.submitOtp();
                                } else {
                                  otpController.OTPValidation();
                                }
                              } finally {
                                if (Get.isDialogOpen ?? false) Get.back();
                              }
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive it? ",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Obx(
                            () => InkWell(
                              onTap:
                                  otpController.isButtonEnabled.value
                                      ? () async {
                                        otpController.isButtonEnabled.value =
                                            false;

                                        Get.dialog(
                                          Center(
                                            child: CircularProgressIndicator(
                                              color:
                                                  AppColors
                                                      .primaryGradinatMixColor,
                                            ),
                                          ),
                                          barrierDismissible: false,
                                        );

                                        try {
                                          await loginController.loginWithOtp();

                                          await Future.delayed(
                                            const Duration(seconds: 3),
                                          );

                                          otpController.startTimer();
                                        } catch (e) {
                                          otpController.isButtonEnabled.value =
                                              true;

                                          Get.snackbar(
                                            "Error",
                                            "Failed to resend OTP. Please try again.",
                                            backgroundColor: Colors.red
                                                .withOpacity(0.8),
                                            colorText: Colors.white,
                                          );
                                        } finally {
                                          if (Get.isDialogOpen ?? false)
                                            Get.back();
                                        }
                                      }
                                      : null,
                              child: Text(
                                otpController.isButtonEnabled.value
                                    ? "Resend OTP"
                                    : "${otpController.formattedTime}s",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
