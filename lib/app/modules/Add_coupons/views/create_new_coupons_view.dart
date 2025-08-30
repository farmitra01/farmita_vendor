import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/Add_coupons/controllers/create_new_coupon_controller.dart';
import 'package:farmitra/app/modules/Add_coupons/views/add_coupons_view.dart';
import 'package:farmitra/app/utils/global_widgets/custom_dropdown.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class create_new_coupons_view extends StatelessWidget {
  const create_new_coupons_view({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateNewCouponController createNewCouponController = Get.put(
      CreateNewCouponController(),
    );

    return Scaffold(
      appBar: VendorAppBar(title: 'Create New Coupon'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
                hintText: 'Title',
                keyboardType: TextInputType.text,
                controller: createNewCouponController.title,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Coupon Type',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(
                          () => CustomDropdown<String>(
                            hint: 'Coupon Type',
                            items: createNewCouponController.couponTypes,
                            selectedItem:
                                createNewCouponController
                                        .selectedItem
                                        .value
                                        .isEmpty
                                    ? null
                                    : createNewCouponController
                                        .selectedItem
                                        .value,
                            onChanged: (value) {
                              createNewCouponController.updatedSelectedValue(
                                value ?? '',
                              );
                            },
                            itemBuilder: (item) => item,
                            // errorText: createNewCouponController.isDropdownValid.value
                            //     ? null
                            //     : 'Coupon type is required',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Code',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          hintText: 'Code',
                          keyboardType: TextInputType.text,
                          controller: createNewCouponController.couponcode,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9]'),
                            ),
                          ],
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Code is required';
                            }
                            if (value.trim().length < 4) {
                              return 'Code must be at least 4 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Max Discount',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          hintText: 'Max Discount',
                          keyboardType: TextInputType.number,
                          controller: createNewCouponController.maxdiscount,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Max discount is required';
                            }
                            if (int.tryParse(value.trim()) == null ||
                                int.parse(value.trim()) <= 0) {
                              return 'Enter a valid number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Min Purchase',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          hintText: 'Min Purchase',
                          keyboardType: TextInputType.number,
                          controller: createNewCouponController.minpurchase,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Min purchase is required';
                            }
                            if (int.tryParse(value.trim()) == null ||
                                int.parse(value.trim()) <= 0) {
                              return 'Enter a valid number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discount',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          hintText: 'Enter Discount',
                          keyboardType: TextInputType.number,
                          controller: createNewCouponController.discount,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Discount is required';
                            }
                            if (int.tryParse(value.trim()) == null ||
                                int.parse(value.trim()) <= 0) {
                              return 'Enter a valid number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discount Type',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(
                          () => CustomDropdown<String>(
                            hint: 'Select Type',
                            items: createNewCouponController.discountTypes,
                            selectedItem:
                                createNewCouponController
                                        .selectedDiscount
                                        .value
                                        .isEmpty
                                    ? null
                                    : createNewCouponController
                                        .selectedDiscount
                                        .value,
                            onChanged: (value) {
                              createNewCouponController.updateSelectedDiscount(
                                value ?? '',
                              );
                            },
                            itemBuilder: (item) => item,
                            // Text: createNewCouponController.selectedDiscount.value.isEmpty &&
                            //         !createNewCouponController.isDropdownValid.value
                            //     ? 'Discount type is required'
                            //     : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Limit for User',
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
                hintText: 'Enter Count',
                keyboardType: TextInputType.number,
                controller: createNewCouponController.userlimit,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'User limit is required';
                  }
                  if (int.tryParse(value.trim()) == null ||
                      int.parse(value.trim()) <= 0) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Date',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(
                          () => TextFormField(
                            readOnly: true,
                            onTap:
                                () => createNewCouponController.pickDate(
                                  isStartDate: true,
                                  context: context,
                                ),
                            decoration: const InputDecoration(
                              hintText: 'Select Start Date',
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController(
                              text: createNewCouponController.startDate.value,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Start date is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Date',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(
                          () => TextFormField(
                            readOnly: true,
                            onTap:
                                () => createNewCouponController.pickDate(
                                  isStartDate: false,
                                  context: context,
                                ),
                            decoration: const InputDecoration(
                              hintText: 'Select End Date',
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController(
                              text: createNewCouponController.endDate.value,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'End date is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: CustomGradientButton(
          text: '+ Add',
          onPressed: () {
            if (createNewCouponController.validateInputs()) {
              final couponData = createNewCouponController.collectCouponData();
              // print('Sending coupon data: $couponData');
              // Wrap couponData in a list
              Get.to(() => const AddCouponsView(), arguments: couponData);
            }
          },
        ),
      ),
    );
  }
}
