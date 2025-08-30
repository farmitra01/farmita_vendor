import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/controllers/filter_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class Filter extends StatelessWidget {
  Filter({super.key});
  final FilterController controller = Get.put(FilterController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            _buildHeader(controller),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSidebar(controller),
                  _buildContentArea(controller),
                ],
              ),
            ),
            _buildFooter(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(FilterController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Filters',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: controller.resetFilters,
            child: Text(
              'Reset Filters',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: AppColors.primaryGradinatMixColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(FilterController controller) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        border: const Border(
          right: BorderSide(color: Colors.black12, width: 1),
        ),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.sidebarOptions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => controller.selectedSidebarIndex.value = index,
            child: Obx(() {
              final bool isSelected =
                  index == controller.selectedSidebarIndex.value;
              return Container(
                height: 50,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.white : AppColors.lightGrey,
                  border: const Border(
                    bottom: BorderSide(color: AppColors.black, width: 0.5),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.sidebarOptions[index],
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: AppColors.black,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildContentArea(FilterController controller) {
    return Obx(() {
      switch (controller.selectedSidebarIndex.value) {
        case 0:
          return _buildCategoryContent(controller);
        case 1:
          return _buildDietaryPreferenceContent(controller);
        case 2:
          return _buildPriceRangeContent(controller);
        case 3:
          return _buildRatingContent(controller);
        case 4:
          return _buildDeliveryContent(controller);
        default:
          return const Expanded(
            child: Center(child: Text('Content not implemented yet')),
          );
      }
    });
  }

  Widget _buildCategoryContent(FilterController controller) {
    return Expanded(
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children:
              controller.categorySelections.keys.map((category) {
                return CheckboxListTile(
                  title: Text(
                    category,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  value: controller.categorySelections[category],
                  onChanged:
                      (value) =>
                          controller.categorySelections[category] =
                              value ?? false,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  activeColor: AppColors.primaryGradinatMixColor,
                  side: BorderSide(color: AppColors.primaryGradinatMixColor),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildDietaryPreferenceContent(FilterController controller) {
    return Expanded(
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children:
              controller.dietarySelections.keys.map((option) {
                return CheckboxListTile(
                  title: Text(
                    option,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  value: controller.dietarySelections[option],
                  onChanged:
                      (value) =>
                          controller.dietarySelections[option] = value ?? false,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  activeColor: AppColors.primaryGradinatMixColor,
                  side: BorderSide(color: AppColors.primaryGradinatMixColor),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildPriceRangeContent(FilterController controller) {
    return Expanded(
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children:
              controller.priceRange.keys.map((option) {
                return CheckboxListTile(
                  title: Text(
                    option,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  value: controller.priceRange[option],
                  onChanged:
                      (value) => controller.priceRange[option] = value ?? false,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.primaryGradinatMixColor,
                  side: BorderSide(color: AppColors.primaryGradinatMixColor),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildRatingContent(FilterController controller) {
    return Expanded(
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children:
              controller.rating.keys.map((option) {
                return CheckboxListTile(
                  title: Text(
                    option,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  value: controller.rating[option],
                  onChanged:
                      (value) => controller.rating[option] = value ?? false,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  activeColor: AppColors.primaryGradinatMixColor,
                  side: BorderSide(color: AppColors.primaryGradinatMixColor),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildDeliveryContent(FilterController controller) {
    return Expanded(
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children:
              controller.delivery.keys.map((option) {
                return CheckboxListTile(
                  title: Text(
                    option,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  value: controller.delivery[option],
                  onChanged:
                      (value) => controller.delivery[option] = value ?? false,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  activeColor: AppColors.primaryGradinatMixColor,
                  side: BorderSide(color: AppColors.primaryGradinatMixColor),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildFooter(FilterController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 44,
                alignment: Alignment.center,
                child: Text(
                  'CLOSE',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: CustomGradientButton(
              text: 'APPLY',
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
