import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/my_subscription/controllers/recharge_plan_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RechargePlan extends StatelessWidget {
  const RechargePlan({super.key});

  @override
  Widget build(BuildContext context) {
    final RechargePlanController rechargePlanController = Get.put(
      RechargePlanController(),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.secondary),
        ),
        title: Text(
          'My Recharge Plan',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Renew / Upgrade Plan',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryGradinatMixColor,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: AppColors.lightskyBlue.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Silver',
                        style: GoogleFonts.montserrat(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Plan',
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Quarterly',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Text(
                                'Price',
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Obx(
                                () => Text(
                                  '₹${rechargePlanController.totalPrice.value}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  var method = ['Wallet', 'Discount Coupon'];
                  return InkWell(
                  
                     child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Obx(
                              () => Radio<int>(
                                activeColor: AppColors.primaryGradinatMixColor,
                                value: index,
                                groupValue:
                                    rechargePlanController
                                        .selectedPaymentIndex
                                        .value,
                                onChanged: (int? value) {
                                  if (value != null) {
                                    rechargePlanController.selectPaymentMethod(
                                      value,
                                    );
                                  }
                                },
                              ),
                            ),
                            Icon(Icons.wallet_rounded, color: AppColors.green),
                            const SizedBox(width: 5),
                            Text(
                              method[index],
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            if (index == 0)
                              Column(
                                children: [
                                  Text(
                                    'Available Balance',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Obx(
                                    () => Text(
                                      '₹${rechargePlanController.totalPrice.value}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Text(
                  'Bill Details',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.background,
                  boxShadow:  [
                    BoxShadow(
                      blurRadius: 1,
                      color: AppColors.containerShadowColor,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: rechargePlanController.priceDetails.length,
                        itemBuilder: (context, index) {
                          final item =
                              rechargePlanController.priceDetails[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  item["title"] ?? '',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                if (item.containsKey("isStrikethrough") &&
                                    item["isStrikethrough"] == true) ...[
                                  Text(
                                    item["price"] ?? '',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    item["discountedPrice"] ?? '',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ] else
                                  Text(
                                    item["price"] ?? '',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          item.containsKey("color")
                                              ? Color(
                                                int.parse(
                                                  (item["color"] as String)
                                                      .replaceAll('#', '0xFF'),
                                                ),
                                              )
                                              : AppColors.textSecondary,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Row(
                        children: [
                          Text(
                            "To Pay",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "₹${rechargePlanController.totalPrice.value}",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/total_saving_bg.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 30,
                        ),
                        child: SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Customer's total saving",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  Obx(
                                    () => Text(
                                      "₹${rechargePlanController.totalSavings.value}",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Obx(
                                () => Text(
                                  "Delivery fee saving of ₹${rechargePlanController.deliveryFeeSaving.value} included",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
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
              SizedBox(height: 20),
              Text(
                'Payment Method',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 10),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.6,
                ),
                itemCount: rechargePlanController.paymentMethod.length,
                itemBuilder: (context, index) {
                  var paymentMethod =
                      rechargePlanController.paymentMethod[index];
                  return Obx(
                    () => Container(
                      padding: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              rechargePlanController
                                          .selectedPaymentmethodIndex
                                          .value ==
                                      index
                                  ? AppColors.primaryGradinatMixColor
                                  : AppColors.border,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                paymentMethod['icon'],
                                color: AppColors.secondary,
                              ),
                              Radio<int?>(
                                value: index,
                                groupValue:
                                    rechargePlanController
                                        .selectedPaymentmethodIndex
                                        .value,
                                onChanged: (int? value) {
                                  rechargePlanController.toggleSelection(index);
                                },
                                activeColor: AppColors.primaryGradinatMixColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            paymentMethod['type'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: CustomGradientButton(text: "Accept", onPressed: () {}),
            ),
            SizedBox(width: 5),
            Expanded(
              child: CustomGradientButton(text: "Payment", onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
