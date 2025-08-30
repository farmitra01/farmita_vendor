import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/inventory/controllers/product_category_controller.dart';
import 'package:farmitra/app/modules/inventory/views/product_details.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductCategoryController productCategoryController = Get.put(
      ProductCategoryController(),
    );

    return Scaffold(
      appBar: VendorAppBar(
        title: "Product Category",
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildIconButton(Icons.message),
                const SizedBox(width: 8),
                _buildIconButton(Icons.notifications_outlined),
              ],
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Obx(
            () => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: Get.size.height),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    selectedIndex:
                        productCategoryController.selectedIndex.value,
                    onDestinationSelected: (int index) {
                      productCategoryController.selectedIndex.value = index;
                    },
                    labelType: NavigationRailLabelType.selected,
                    indicatorColor: AppColors.lightGrey,
                    useIndicator: false,
                    elevation: 0.1,
                    destinations: List.generate(15, (index) {
                      return NavigationRailDestination(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                productCategoryController.selectedIndex.value ==
                                        index
                                    ? AppColors.white
                                    : Colors.grey.withOpacity(0.2),
                          ),
                          child: SvgPicture.asset(
                            'assets/svgs/add_product.svg',
                            height: 35,
                          ),
                        ),
                        label: Text('Item ${index + 1}'),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Vegetables & Fruits'),
                  _buildGrid(productCategoryController, 15),
                  const Divider(color: AppColors.border),
                  _buildSectionHeader('Atta Rice & Daal'),
                  _buildGrid(productCategoryController, 15),
                ],
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.transparent,
      //   child: Container(
      //     height: 100,
      //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      //     decoration: const BoxDecoration(
      //       shape: BoxShape.circle,
      //       gradient: LinearGradient(
      //         colors: [
      //           AppColors.primaryFirstGradiant,
      //           AppColors.primarySecondGradiant,
      //         ],
      //       ),
      //     ),
      //     child: const Icon(Icons.add, color: AppColors.white),
      //   ),
      // ),
    );
  }

  // Icon Button Widget
  Widget _buildIconButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, color: AppColors.white),
      ),
    );
  }

  // Section Header Widget
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Grid Builder Widget
  Widget _buildGrid(ProductCategoryController controller, int itemCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            shrinkWrap:
                true, // Allows GridView to fit inside scrollable content
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.0,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              bool isSelected = index == controller.selectedIndex.value;
              return GestureDetector(
                onTap: () {
                  Get.to(ProductDetails());
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),

                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/bulk_upload.svg',
                        height: 35,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
