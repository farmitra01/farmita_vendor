import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/views/pos_category_search_view.dart';
import 'package:farmitra/app/modules/home/controllers/suggest_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestProduct extends StatelessWidget {
  const SuggestProduct({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller inside build to ensure proper lifecycle
    final SuggestProductController suggestProductController = Get.put(
      SuggestProductController(),
    );

    return Scaffold(
      appBar: const VendorAppBar(title: 'Suggest Product'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            CustomTextFormField(
              hintText: 'Search Product',
              keyboardType: TextInputType.text,
              controller: suggestProductController.search,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a search term';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    activeColor: AppColors.primaryGradinatMixColor,
                    value: suggestProductController.isChecked.value,
                    onChanged: (value) {
                      suggestProductController.isChecked.value = value!;
                      if (value) {
                        suggestProductController.selectedProducts.value =
                            Set.from(List.generate(5, (index) => index));
                      } else {
                        suggestProductController.selectedProducts.clear();
                      }
                      suggestProductController.isShowCheckbox.value =
                          !suggestProductController.isShowCheckbox.value;
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'All Products',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  '(5 Products)', // Matches itemCount
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount:
                    5, // Replace with dynamic count if using a data model
                itemBuilder: (context, index) {
                  return Obx(
                    () => Row(
                      children: [
                        suggestProductController.isShowCheckbox.value == true
                            ? SizedBox(
                              width: 18,
                              child: Checkbox(
                                activeColor: AppColors.primaryGradinatMixColor,
                                value: suggestProductController.selectedProducts
                                    .contains(index),
                                onChanged: (value) {
                                  if (value == true) {
                                    suggestProductController.selectedProducts
                                        .add(index);
                                  } else {
                                    suggestProductController.selectedProducts
                                        .remove(index);
                                  }
                                  // Update "Select All" checkbox state
                                  suggestProductController.isChecked.value =
                                      suggestProductController
                                          .selectedProducts
                                          .length ==
                                      5;
                                },
                              ),
                            )
                            : SizedBox.shrink(),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Image.asset(
                                    'assets/images/suggetedProductImage.webp',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.error),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.lightGrey,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Product Name', // Replace with dynamic data
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Details:',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            'Reddish - brown pustules on a wheat stem will turn black as it decays',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
      bottomNavigationBar: Obx(() {
        return suggestProductController.selectedProducts.isNotEmpty
            ? AddedItemList()
            : SizedBox.shrink();
      }),
    );
  }
}
