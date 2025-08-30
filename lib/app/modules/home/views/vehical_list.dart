import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/views/manage_services.dart';
import 'package:farmitra/app/modules/inventory/controllers/inventory_controller.dart';
import 'package:farmitra/app/modules/inventory/views/edit_product.dart';
import 'package:farmitra/app/modules/inventory/views/product_category.dart';
import 'package:farmitra/app/modules/inventry/controllers/inventry_controller.dart';
import 'package:farmitra/app/modules/inventry/views/inventry_view.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicalList extends StatelessWidget {
  const VehicalList({super.key});

  @override
  Widget build(BuildContext context) {
    final InventryController inventryController = Get.put(InventryController());

    return Scaffold(
      appBar: VendorAppBar(title: 'Vehical List'),
      body: CustomScrollView(
        slivers: [
          // SliverPersistentHeader for the fixed horizontal list
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
          // SliverList for vertical scrolling items
          SliverToBoxAdapter(
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
          SliverList(delegate: buildSliverList()),
        ],
      ),
    );
  }
}

SliverChildBuilderDelegate buildSliverList() {
  final InventryController inventryController = Get.put(InventryController());
  StoreCategoryController storeCategoryController = Get.put(
    StoreCategoryController(),
  );
  return SliverChildBuilderDelegate(
    (context, index) => GestureDetector(
      onTap: () {
        Get.to(() => ManageServices());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                  seeOptionBottomsheet(context);
                },
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Obx(
                      () =>
                          inventryController.isCheck.value
                              ? SizedBox(
                                height:
                                    20, // Changed from 5 to 20 for better checkbox sizing
                                width: 20, // Changed from 10 to 20
                                child: Obx(() {
                                  return Checkbox(
                                    activeColor:
                                        AppColors.primaryGradinatMixColor,
                                    value:
                                        inventryController
                                            .productSelections[index],
                                    onChanged: (value) {
                                      if (value != null) {
                                        inventryController
                                            .toggleProductSelection(
                                              index,
                                              value,
                                            );
                                      }
                                    },
                                  );
                                }),
                              )
                              : inventryController.selectedIndex == index
                              ? SizedBox(
                                height: 20,
                                width: 20,
                                child: Obx(
                                  () => Checkbox(
                                    value:
                                        inventryController.selectedItems[index],
                                    onChanged: (value) {
                                      inventryController.toggleSelection(index);
                                    },
                                  ),
                                ),
                              )
                              : const SizedBox(),
                    ),
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
                                // width: 80,
                              )
                              : SvgPicture.asset('assets/svgs/add_product.svg'),
                    ),
                    const SizedBox(width: 5),
                    Column(
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
                            const SizedBox(width: 35),
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
                    const Spacer(),
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
                                : " out of \nStock ",
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
            const Divider(
              color: Color(0xff8a8a8a),
              thickness: 0.5,
              endIndent: 10,
              indent: 10,
            ),
            storeCategoryController.previousPageGridTitle == 'Rental'
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CustomGradientButton(
                          text: 'Hourly',
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomGradientButton(
                          text: 'Work wise',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                )
                : SizedBox(),
          ],
        ),
      ),
    ),
    childCount: 15,
  );
}

class _StickyTextHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 100;
  @override
  double get maxExtent => 100;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final InventoryController inventoryController = Get.put(
      InventoryController(),
    );
    return Column(
      children: [
        Container(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          child: TabBar(
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
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

Widget buildCategoriesTabbar() {
  return Column(
    children: [
      Image.asset('assets/images/tractor.jpg', height: 50),
      SizedBox(height: 5),
      Text('Tractor', textAlign: TextAlign.center),
    ],
  );
}

Widget buildOfflineAlertBox() {
  return AlertDialog(
    content: SingleChildScrollView(
      // Prevent overflow issues
      child: Column(
        mainAxisSize: MainAxisSize.min, // Prevent unnecessary height expansion
        children: [
          SvgPicture.asset(
            'assets/svgs/alert_triangel.svg',
            fit: BoxFit.contain,
            height: 50, // Set a fixed size
          ),
          SizedBox(height: 10),
          Text(
            'We are adding the product to your inventory.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'or edit it before adding?',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomOutlinedButton(
              onPressed: () {
                Get.to(EditProduct());
              },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.secondary),
              ),
              text: '   Edit & Add',
              textStyle: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.secondary,
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: CustomGradientButton(
              text: 'Add Now',
              onPressed: () {
                Get.back();
                ();
              },
              height: 35,
            ),
          ),
        ],
      ),
    ],
  );
}
