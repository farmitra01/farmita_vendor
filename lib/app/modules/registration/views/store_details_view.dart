import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/registration/controllers/store_details_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custome_appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreDetailsView extends GetView<StoreDetailsController> {
  const StoreDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final StoreDetailsController storeDetailsController = Get.put(
      StoreDetailsController(),
    );
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: true,

        onHelpTap: () => Get.toNamed('/help-center'),
        onTranslateTap: () => Get.toNamed('/add'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nature of business",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Select the nature of your business.",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return  Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  ),
                );
              }
              if (controller.storeOptions.isEmpty) {
                return const Expanded(
                  child: Center(child: Text('No options available.')),
                );
              }
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.storeOptions.length,
                  itemBuilder: (context, index) {
                    final item = controller.storeOptions[index];
                    return Obx(
                      () => GestureDetector(
                        onTap: () => controller.selectItem(index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 3.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  controller.selectedIndex.value == index
                                      ? AppColors.primaryGradinatMixColor
                                      : AppColors.black,
                              width: 1.50,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            isThreeLine: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            title: Text(
                              item.name ?? 'Unnamed',

                              style: GoogleFonts.montserrat(
                                color:
                                    controller.selectedIndex.value == index
                                        ? AppColors.primaryGradinatMixColor
                                        : AppColors.textPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            subtitle: Text(
                              item.desc ?? 'No description',
                              textAlign: TextAlign.left,

                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color:
                                    controller.selectedIndex.value == index
                                        ? AppColors.primaryGradinatMixColor
                                        : AppColors.textPrimary,
                              ),
                            ),
                            trailing: Radio<int>(
                              value: index,
                              groupValue: controller.selectedIndex.value,
                              activeColor: AppColors.primaryGradinatMixColor,
                              onChanged: (int? value) {
                                if (value != null) {
                                  controller.selectItem(value);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: CustomGradientButton(
          text: 'Proceed',
          onPressed: () {
            // if (controller.selectedIndex.value == 2) {
            //   print('Argument Data ${controller.previousSelectedValue.value}');
            //   Get.snackbar(
            //     'Note',
            //     'Coming Soon ... 🙏🙏',
            //     snackPosition: SnackPosition.TOP,
            //     backgroundColor: AppColors.primaryGradinatMixColor,
            //     colorText: AppColors.white,
            //   );
            // } else
            if (controller.previousSelectedValue.value.isEmpty) {
              Get.snackbar(
                'Please',
                'Select Any Nature of Business',
                snackPosition: SnackPosition.TOP,
                backgroundColor: AppColors.primaryGradinatMixColor,
                colorText: AppColors.white,
              );
            } else {
              Get.toNamed(
                '/store_select_module',
                arguments: controller.previousSelectedValue.value,
              );
              print(
                'Selected data on ${controller.previousSelectedValue.value}',
              );
            }
          },
        ),
      ),
    );
  }
}
