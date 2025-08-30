import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Ensure intl is imported

import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  WalletView({super.key});
  final WalletController walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VendorAppBar(title: 'Wallet'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      // height: 160,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryFirstGradiant.withOpacity(0.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/wallet.svg',
                            color: AppColors.primaryGradinatMixColor,
                            height: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Today',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryGradinatMixColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '₹ 0.00',
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryGradinatMixColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // height: 75,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryGradinatMixColor
                                .withOpacity(0.2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'This week',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '₹ 0.00',
                                style: GoogleFonts.montserrat(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          // height: 75,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.yellow.withOpacity(0.2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'This Month',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '₹ 0.00',
                                style: GoogleFonts.montserrat(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryGradinatMixColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/wallet.svg',
                      color: AppColors.white,
                      height: 35,
                      width: 35,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              walletController.isWithdrawal.value
                                  ? 'Withdrawable Balance'
                                  : 'Balance Unadjusted',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => Text(
                              walletController.isWithdrawal.value
                                  ? '₹ 419.23'
                                  : '₹ 860.23',
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      return walletController.isWithdrawal.value
                          ? TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                AppColors.white,
                              ),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Get.bottomSheet(buildWithdrawal());
                            },
                            child: Text(
                              'Withdrawal',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.green,
                              ),
                            ),
                          )
                          : Column(
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    AppColors.white,
                                  ),
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Pay Now',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.green,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    AppColors.white,
                                  ),
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Get.dialog(buildCashAdjust());
                                },
                                child: Text(
                                  'Adjust Payment',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.green,
                                  ),
                                ),
                              ),
                            ],
                          );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: AppColors.containerShadowColor,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "₹ 441.00",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryGradinatMixColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Cash in Hand',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: AppColors.containerShadowColor,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "₹ 419.23",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryGradinatMixColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Withdrawable Balance',
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: walletController.amountType.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: AppColors.containerShadowColor,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          walletController.amountType[index]['amount'] ?? '',
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryGradinatMixColor,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          walletController.amountType[index]['type'] ?? '',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              TabBar(
                labelColor: AppColors.primaryGradinatMixColor,
                indicatorColor: AppColors.primaryGradinatMixColor,
                controller: walletController.tabController,
                tabs: [
                  Tab(text: 'Withdrawal Request'),
                  Tab(text: 'Payment History'),
                ],
              ),
              Container(
                height: 400,
                child: TabBarView(
                  controller: walletController.tabController,
                  children: [buildWithdrawalRequest(), buildPaymentHistory()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildWithdrawalRequest() {
  final WalletController walletController = Get.find<WalletController>();

  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction History',
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Obx(
            () =>
                walletController.withdrawalRequests.isEmpty
                    ? Center(child: Text('No Withdrawal Requests'))
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: walletController.withdrawalRequests.length,
                      itemBuilder: (context, index) {
                        final request =
                            walletController.withdrawalRequests[index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 8,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('₹ ${request['amount']}'),
                                  Text(
                                    request['timestamp'] ?? '',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Transferred to ${request['type']}'),
                                  Text(
                                    request['status'] ?? '',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightskyBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    ),
  );
}

Widget buildPaymentHistory() {
  return Center(child: Text('Not Found Any Payment History'));
}

Widget buildCashAdjust() {
  final WalletController walletController = Get.find<WalletController>();
  return AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            // Get.closeAllSnackbars();
            Get.back();
            ();
          },
          child: Icon(Icons.close, color: AppColors.error),
        ),
      ],
    ),
    content: Container(
      height: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Cash Adjustment',
            style: GoogleFonts.montserrat(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'To adjust your Cash in Hand Balance and Withdrawal Amount please Click OK to Confirm the adjustments',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    ),
    actions: [
      Row(
        children: [
          Expanded(
            child: CustomGradientButton(
              text: 'Cancel',
              borderRadius: 10,
              onPressed: () {
                Get.back();
                ();
              },
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: CustomGradientButton(
              text: 'OK',
              borderRadius: 10,
              onPressed: () {
                // Get.closeAllSnackbars();
                Get.back();
                // ();
                walletController.isWithdrawal.value = true;
              },
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildWithdrawal() {
  final WalletController walletController = Get.find<WalletController>();
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: AppColors.white,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            'Withdrawal',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Select any one to withdrawal money',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      walletController.isUpi.value = true;
                      walletController.isAccount.value = false;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              walletController.isUpi.value
                                  ? AppColors.primaryGradinatMixColor
                                  : AppColors.border,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/qr-hello.svg',
                            height: 50,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Amit Kumar Singh',
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'amitkumar1974@oksbi',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      walletController.isAccount.value = true;
                      walletController.isUpi.value = false;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              walletController.isAccount.value
                                  ? AppColors.primaryGradinatMixColor
                                  : AppColors.border,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/bank.jpg', height: 50),
                          const SizedBox(height: 10),
                          Text(
                            'SBI\n(State Bank Of India)',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'XXXXXXXXXX123',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Enter Amount',
            keyboardType: TextInputType.number,
            controller: walletController.account,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Amount';
              }
              if (double.tryParse(value) == null) {
                return 'Please Enter a Valid Number';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          CustomGradientButton(
            text: 'Send Request',
            onPressed: () {
              final amount = walletController.account.text;
              if (amount.isNotEmpty && double.tryParse(amount) != null) {
                final now = DateTime.now();
                final formattedTime = DateFormat(
                  'dd MMM yyyy hh:mm a',
                ).format(now);
                walletController.withdrawalRequests.insert(0, {
                  'amount': amount,
                  'timestamp': formattedTime,
                  'type': walletController.isUpi.value ? 'UPI' : 'Bank Account',
                  'status': 'Pending',
                });
                walletController.account.clear();
                Get.back();
                ();
              } else {
                Get.snackbar('Error', 'Please enter a valid amount');
              }
            },
          ),
        ],
      ),
    ),
  );
}
