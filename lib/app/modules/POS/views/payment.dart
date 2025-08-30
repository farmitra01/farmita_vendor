import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/controllers/payment_controller.dart';
import 'package:farmitra/app/modules/POS/views/upi_qr.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

class Payment extends StatelessWidget {
  Payment({super.key});
  final PaymentController paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment:',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 2.5),
            Text(
              'Select how you want to receive payment',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: AppColors.primaryGradinatMixColor,
              child: Icon(Icons.close, color: AppColors.white),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: AppColors.border),
              SizedBox(height: 10),
              Text(
                'Bill Details',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 0.1,
                      color: Colors.grey,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: ExpansionTile(
                  shape: Border.all(color: Colors.transparent),
                  internalAddSemanticForOnTap: true,
                  children: [
                    Container(
                      height: 100,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 2.5,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: paymentController.billDetails.length,
                        itemBuilder: (context, index) {
                          var billDetails =
                              paymentController.billDetails[index];
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    billDetails['type'],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    billDetails['amount'],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.5),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                  title: Row(
                    children: [
                      Text(
                        'Bill Amount',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: AppColors.secondary,
                            size: 15,
                          ),
                          Text(
                            'Edit',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                      Text(
                        '₹520',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 0.1,
                      color: Colors.grey,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: ExpansionTile(
                  shape: Border.all(color: Colors.transparent),
                  internalAddSemanticForOnTap: true,
                  children: [
                    Container(
                      height: 100,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 2.5,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(height: 2.5),
                              Row(
                                children: [
                                  Text(
                                    'orderid - #987532',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '₹400',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Obx(
                                    () => Checkbox(
                                      activeColor:
                                          AppColors.primaryGradinatMixColor,
                                      value:
                                          paymentController
                                              .checkBoxList[index]
                                              .value,
                                      onChanged:
                                          (value) => paymentController
                                              .toggleCheckbox(index, value!),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Previous Dues (2-Orders)',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '+₹800',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              DottedBorder(
                borderType: BorderType.RRect,
                color: AppColors.border,
                radius: Radius.circular(5),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Bill Amount',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '₹ 1,320/-',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Net Amount Receive:',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                hintText: '  Enter Amount',
                keyboardType: TextInputType.text,
                controller: paymentController.totalBillAmount,
                validator: (p0) {},
                suffixIcon: Icons.cancel_outlined,
                onChanged: (value) {
                  paymentController.updateRemainingAmount(value);
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => Text(
                      'Remaining Amount: ₹ ${paymentController.remainingAmount.value}',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
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
                itemCount: paymentController.paymentMethod.length,
                itemBuilder: (context, index) {
                  var paymentMethod = paymentController.paymentMethod[index];
                  return Obx(
                    () => Container(
                      padding: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              paymentController.selectedPaymentIndex.value ==
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
                                    paymentController
                                        .selectedPaymentIndex
                                        .value,
                                onChanged: (int? value) {
                                  paymentController.toggleSelection(index);
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
      bottomNavigationBar: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: CustomGradientButton(
          text: 'Accept Payment',
          onPressed: () {
            Get.to(() => UpiQr());
          },
        ),
      ),
    );
  }
}
