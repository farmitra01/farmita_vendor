import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/inventory/controllers/inventory_controller.dart';
import 'package:farmitra/app/modules/inventory/views/edit_product.dart';
import 'package:farmitra/app/modules/inventory/views/inventory_view.dart';
import 'package:farmitra/app/modules/inventory/views/product_category.dart';
import 'package:farmitra/app/modules/inventry/views/add_rental_item.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/inventry_controller.dart';

class InventryView extends GetView<InventryController> {
  InventryView({super.key});
  final StoreCategoryController storeCategoryController = Get.put(
    StoreCategoryController(),
  );
  @override
  Widget build(BuildContext context) {
    final InventryController inventryController = Get.put(InventryController());
    final StoreCategoryController storeCategoryController = Get.put(
      StoreCategoryController(),
    );
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(bottom: 35),
              color: AppColors.appBarColor,
              child: VendorAppBar(
                title:
                    storeCategoryController.previousPageGridTitle == 'Rental' ||
                            storeCategoryController.previousPageGridTitle ==
                                'Expert' ||
                            storeCategoryController.previousPageGridTitle ==
                                'Drone'
                        ? 'Add Machines'
                        : 'Inventory',
                actions: [
                  buildActionButton(Icons.message_outlined),
                  SizedBox(width: 10),
                  buildActionButton(Icons.notifications),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight + 45, // Position below AppBar
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
              ),
              child: CustomTextFormField(
                hintText: 'Search In',
                keyboardType: TextInputType.text,
                controller: inventryController.searchbar,
                borderRadius: 10,
                validator: (p0) {},
                suffixWidget: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 24,
                        width: 1,
                        color: AppColors.secondary,
                      ),
                    ),
                    Icon(Icons.mic, color: AppColors.primaryGradinatMixColor),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: kToolbarHeight + 100,
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product Categories',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(ProductCategory());
                          },
                          child: GradientText(
                            text: 'View All',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryFirstGradiant,
                                AppColors.primarySecondGradiant,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _StickyTextHeaderDelegate(),
                ),
                // SliverToBoxAdapter(
                //   child:
                // ),
                SliverList(delegate: buildSliverList()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:
          storeCategoryController.previousPageGridTitle == 'Rental'
              ? FloatingActionButton(
                onPressed: () {
                  Get.to(
                    () =>
                        // storeCategoryController.previousPageGridTitle == 'Rental'
                        //     ?
                        AddRentalItem(),
                    //     :00
                    //  EditProduct(),
                  );
                },
                backgroundColor: Colors.transparent,
                child: Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryFirstGradiant,
                        AppColors.primarySecondGradiant,
                      ],
                    ),
                  ),
                  child: Icon(Icons.add, color: AppColors.white),
                ),
              )
              : null,
    );
  }
}

class _StickyTextHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 150;
  @override
  double get maxExtent => 150;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final InventoryController inventoryController = Get.put(
      InventoryController(),
    );
    final InventryController inventryController = Get.put(InventryController());

    return Column(
      children: [
        Container(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          child: TabBar(
            physics: BouncingScrollPhysics(),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            controller: inventoryController.categoryTabController,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            automaticIndicatorColorAdjustment: true,
            labelColor: AppColors.primaryGradinatMixColor,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: [
              buildCategoriesTabbar(),
              buildCategoriesTabbar(),
              buildCategoriesTabbar(),
              buildCategoriesTabbar(),
              buildCategoriesTabbar(),
            ],
          ),
        ),
        Container(
          color: AppColors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                return Checkbox(
                  value: inventryController.isAllSelected.value,
                  activeColor: AppColors.primaryGradinatMixColor,
                  onChanged: (bool? value) {
                    if (value != null) {
                      inventryController.toggleSelectAll(value);
                      inventryController.showCheckBox();
                    }
                  },
                );
              }),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "All Products ",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextSpan(
                      text: "(15 Products)",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff8a8a8a),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  seeOptionBottomsheet(context);
                },
                child: Obx(
                  () => Text(
                    "See Options",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color:
                          inventryController.isCheck == true
                              ? AppColors.primaryGradinatMixColor
                              : AppColors.secondary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

Widget buildActionButton(IconData icon) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.white),
    ),
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Icon(icon, color: AppColors.white),
    ),
  );
}

void seeOptionBottomsheet(BuildContext context) {
  final InventryController inventryController = Get.put(InventryController());

  showModalBottomSheet(
    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(35)),
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Column(
              children: [
                // SizedBox(
                //   height: 8,
                // ),
                SvgPicture.asset(
                  'assets/svgs/gift_bw.svg',
                  color: AppColors.black,
                  height: 20,
                ),
                SizedBox(height: 15),
                Text(
                  'Available\nfor gift',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            SizedBox(width: 5),
            Expanded(
              child: Obx(() {
                final selectedCount =
                    inventryController.productSelections
                        .where((selected) => selected == true)
                        .length;

                // Filter list based on selected count
                final List<Map<String, dynamic>> filteredOptions =
                    selectedCount <= 1
                        ? [
                          {'text': 'Edit', 'icon': Icons.edit_outlined},
                          {
                            'text': 'Out of\nStock',
                            'icon': Icons.shopping_cart_checkout,
                          }, // ✅ Fixed key
                          {
                            'text': 'Add to\nCollection',
                            'icon': Icons.dataset_outlined,
                          }, // ✅ Fixed key
                          {
                            'text': 'Delete\nProduct',
                            'icon': Icons.delete_outline,
                          },
                          {'text': 'Print', 'icon': Icons.print_rounded},
                        ]
                        : inventryController.seeOptionList
                            .where((item) => item['text'] != 'Edit')
                            .toList();

                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredOptions.length,
                  itemBuilder: (context, index) {
                    final data = filteredOptions[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            data['icon'] as IconData,
                            size: 24,
                            color: AppColors.black,
                          ),
                          SizedBox(height: 10),
                          Text(
                            data['text'],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      );
    },
  );
}

SliverChildBuilderDelegate buildSliverList() {
  final inventryController = Get.put(InventryController());
  final storeCategoryController = Get.put(StoreCategoryController());

  return SliverChildBuilderDelegate((context, index) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            spreadRadius: 1,
            color: AppColors.containerShadowColor,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: GestureDetector(
              onLongPress: () {
                inventryController.showCheckBox();
              },
              onTap: () {
                seeOptionBottomsheet(context);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Obx(() {
                    if (inventryController.isCheck.value) {
                      return SizedBox(
                        height: 20,
                        width: 20,
                        child: Obx(
                          () => Checkbox(
                            activeColor: AppColors.primaryGradinatMixColor,
                            value: inventryController.productSelections[index],
                            onChanged: (value) {
                              if (value != null) {
                                inventryController.toggleProductSelection(
                                  index,
                                  value,
                                );
                              }
                            },
                          ),
                        ),
                      );
                    } else if (inventryController.selectedIndex == index) {
                      return SizedBox(
                        height: 20,
                        width: 20,
                        child: Obx(
                          () => Checkbox(
                            value: inventryController.selectedItems[index],
                            onChanged: (value) {
                              inventryController.toggleSelection(index);
                            },
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  Obx(
                    () =>
                        inventryController.isCheck.value
                            ? const SizedBox(width: 15)
                            : const SizedBox(width: 0),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffcdcdcd),
                    ),
                    child:
                        storeCategoryController.previousPageGridTitle ==
                                'Rental'
                            ? Image.asset(
                              'assets/images/tractor.jpg',
                              height: 50,
                            )
                            : SvgPicture.asset(
                              'assets/svgs/add_product.svg',
                              height: 60,
                            ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          storeCategoryController.previousPageGridTitle ==
                                  "Rental"
                              ? 'Tractors'
                              : 'Green Capsicum (Shimla Mirch)',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              '250g',
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff8a8a8a),
                              ),
                            ),
                            // const Spacer()
                            SizedBox(width: 10),
                            Text(
                              'SKUs 25',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "₹40   ",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              TextSpan(
                                text: "₹50",
                                style: GoogleFonts.montserrat(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff8a8a8a),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Row(
                        //   children: [
                        //     GradientText(
                        //       text: "Available For Gift",
                        //       style: GoogleFonts.montserrat(
                        //         fontSize: 12,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //       gradient: LinearGradient(
                        //         colors: [
                        //           AppColors.primaryFirstGradiant,
                        //           AppColors.primarySecondGradiant,
                        //         ],
                        //       ),
                        //     ),
                        //     const SizedBox(width: 5),
                        //     GradientSvgIcon(
                        //       assetName: 'assets/svgs/gift_bw.svg',
                        //       size: 12,
                        //       gradient: LinearGradient(
                        //         colors: [
                        //           AppColors.primaryFirstGradiant,
                        //           AppColors.primarySecondGradiant,
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => Switch(
                          value: inventryController.switchStates[index],
                          onChanged: (value) {
                            inventryController.toggleSwitch(index, value);
                            inventryController.isSwitchedState.value = value;
                          },
                          activeColor: AppColors.white,
                          activeTrackColor: AppColors.primaryGradinatMixColor,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: AppColors.white,
                        ),
                      ),
                      Obx(
                        () => Text(
                          inventryController.switchStates[index]
                              ? "In Stock"
                              : "Out of\nStock",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                inventryController.switchStates[index]
                                    ? AppColors.primaryGradinatMixColor
                                    : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if ([
            'Rental',
            'Drone',
            'Expert',
          ].contains(storeCategoryController.previousPageGridTitle)) ...[
            const Divider(
              color: Color(0xff8a8a8a),
              thickness: 0.5,
              endIndent: 10,
              indent: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomGradientButton(
                      text: 'Hourly',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomGradientButton(
                      text: 'Work wise',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }, childCount: 15);
}
