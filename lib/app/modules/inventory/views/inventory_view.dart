import 'dart:math';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/inventory/views/bulk_upload.dart';
import 'package:farmitra/app/modules/inventory/views/edit_product.dart';
import 'package:farmitra/app/modules/inventory/views/product_category.dart';
import 'package:farmitra/app/modules/inventory/views/product_details.dart';
import 'package:farmitra/app/modules/inventory/views/product_export.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/inventory_controller.dart';

class InventoryView extends GetView<InventoryController> {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final InventoryController inventoryController = Get.put(
      InventoryController(),
    );
    return Scaffold(
      // appBar:
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
                title: "Product Library",
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildIconButton(Icons.message),
                      _buildIconButton(Icons.notifications_outlined),
                    ],
                  ),
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
                controller: inventoryController.SearchBar,
                borderRadius: 10,
                validator: (p0) {},
                suffixWidget: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 24,
                        width: 1,
                        color: AppColors.background,
                      ),
                    ),
                    GradientSvgIcon(
                      icon: Icon(Icons.mic),
                      size: 25,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryFirstGradiant,
                          AppColors.primarySecondGradiant,
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: kToolbarHeight + 100,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // TabBar Container
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      // color: AppColors.background,
                      border: Border.all(
                        color: AppColors.primaryGradinatMixColor.withOpacity(
                          0.2,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TabBar(
                      controller: inventoryController.tabController,
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.primaryGradinatMixColor.withOpacity(
                          0.2,
                        ),
                      ),

                      // labelColor: Colors.black,
                      // unselectedLabelColor:inventoryController.isTabActiev/,
                      physics: NeverScrollableScrollPhysics(),
                      tabs: [
                        Tab(
                          child: Text(
                            'My Library',
                            style: GoogleFonts.montserrat(
                              color:
                                  // inventoryController.isTabActiev == true ?
                                  AppColors.textPrimary,
                              // : ApepColors.textSecondary,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Tab(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Farmitra ',
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.primaryGradinatMixColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Library',
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 10),
                  // TabBarView
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height -
                        160, // Flexible height
                    child: TabBarView(
                      controller: inventoryController.tabController,
                      // physics: NeverScrollableScrollPhysics(),
                      children: [MyLibrary(context), FarmitraLibrary(context)],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(EditProduct());
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
      ),
    );
  }

  // Helper method for reusable Icon Button
  Widget _buildIconButton(IconData iconData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white),
      ),
      child: Icon(iconData, color: AppColors.white),
    );
  }
}

Widget MyLibrary(BuildContext context) {
  final InventoryController inventoryController = Get.put(
    InventoryController(),
  );

  return CustomScrollView(
    physics: BouncingScrollPhysics(),
    slivers: [
      // GridView for MyLibrary
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              // color: Colors.orange,
              alignment: Alignment.center,

              child: GestureDetector(
                onTap: () {
                  switch (index) {
                    // case 0:
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => EditProduct(),
                    //     ),
                    //   );
                    //   break;
                    case 0:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BulkUpload()),
                      );
                      break;
                    // case 2:
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ProductDetails(),
                    //     ),
                    //   );
                    //   break;
                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductExport(),
                        ),
                      );
                      break;
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: inventoryController.libraryData[index].borderColor,
                    ),
                    color: inventoryController.libraryData[index].bgColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        inventoryController.libraryData[index].imagePath,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        inventoryController.libraryData[index].text,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // index == 0
                      //     ? Text(
                      //         '(Firsfind Library)',
                      //         style: GoogleFonts.montserrat(
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.w500,
                      //             color: AppColors.textPrimary),
                      //       )
                      //     : SizedBox()
                    ],
                  ),
                ),
              ),
            ),
            childCount: 2,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.3,
          ),
        ),
      ),

      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
      // Vertically scrollable list
      SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() {
              return Checkbox(
                value: inventoryController.isAllSelected.value,
                activeColor: AppColors.primaryGradinatMixColor,
                onChanged: (bool? value) {
                  if (value != null) {
                    inventoryController.toggleSelectAll(value);
                    inventoryController.showCheckBox();
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
                      color: AppColors.textSecondary,
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
              child: GradientText(
                text: "See Options",
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
            SizedBox(width: 10),
          ],
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => GestureDetector(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  child: GestureDetector(
                    onLongPress: () {
                      inventoryController.showCheckBox();
                    },
                    onTap: () {
                      seeOptionBottomsheet(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        // Checkbox logic (as previously corrected)
                        Obx(() {
                          if (inventoryController.isCheck.value == true) {
                            return Obx(() {
                              return Checkbox(
                                activeColor: AppColors.primaryGradinatMixColor,
                                value:
                                    inventoryController
                                        .productSelections[index],
                                onChanged: (value) {
                                  if (value != null) {
                                    inventoryController.toggleProductSelection(
                                      index,
                                      value,
                                    );
                                  }
                                },
                              );
                            });
                          } else if (inventoryController.selectedIndex ==
                              index) {
                            return Obx(() {
                              return Checkbox(
                                value: inventoryController.selectedItems[index],
                                onChanged: (value) {
                                  inventoryController.toggleSelection(index);
                                },
                              );
                            });
                          } else {
                            return SizedBox();
                          }
                        }),
                        SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.background,
                          ),
                          child: SvgPicture.asset(
                            'assets/svgs/add_product.svg',
                          ),
                        ),
                        const SizedBox(width: 5),

                        /// 🔧 MAKE THIS FLEXIBLE!
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Green Capsicum (Shimla Mirch)',
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
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  GradientText(
                                    text: "Available For Gift",
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
                                  SizedBox(width: 5),
                                  GradientSvgIcon(
                                    assetName: 'assets/svgs/gift_bw.svg',
                                    size: 12,
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryFirstGradiant,
                                        AppColors.primarySecondGradiant,
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        /// The switch column stays
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Switch(
                                value: inventoryController.switchStates[index],
                                onChanged: (value) {
                                  inventoryController.toggleSwitch(
                                    index,
                                    value,
                                  );
                                  inventoryController.isSwitchedState.value =
                                      value;
                                },
                                activeColor: AppColors.white,
                                activeTrackColor:
                                    AppColors.primaryGradinatMixColor,
                                inactiveThumbColor:
                                    AppColors.primaryGradinatMixColor,
                                inactiveTrackColor: AppColors.white,
                              ),
                            ),
                            Obx(
                              () => Text(
                                inventoryController.switchStates[index]
                                    ? " Delete from\ninventory"
                                    : " Add to\ninventory",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      inventoryController.switchStates[index]
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
                  color: AppColors.border,
                  thickness: 0.5,
                  endIndent: 10,
                  indent: 10,
                ),
              ],
            ),
          ),
          childCount: 15,
        ),
      ),
    ],
  );
}

// Sticky header delegate for fixing only the text
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
          color: AppColors.background,
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

Widget FarmitraLibrary(BuildContext context) {
  final InventoryController inventoryController = Get.put(
    InventoryController(),
  );
  return CustomScrollView(
    physics: BouncingScrollPhysics(),
    slivers: [
      SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: _StickyTextHeaderDelegate(),
      ),
      SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() {
              return Checkbox(
                value: inventoryController.isAllSelected.value,
                activeColor: AppColors.primaryGradinatMixColor,
                onChanged: (bool? value) {
                  if (value != null) {
                    inventoryController.toggleSelectAll(value);
                    inventoryController.showCheckBox();
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
                      color: AppColors.textSecondary,
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
              child: GradientText(
                text: "See Options",
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
            SizedBox(width: 10),
          ],
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => GestureDetector(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  child: GestureDetector(
                    onLongPress: () {
                      inventoryController.showCheckBox();
                    },
                    onTap: () {
                      seeOptionBottomsheet(context);
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 10),

                        /// ✅ FIXED CHECKBOX (removed sizing wrapper)
                        Obx(() {
                          if (inventoryController.isCheck.value == true) {
                            return Obx(() {
                              return Checkbox(
                                activeColor: AppColors.primaryGradinatMixColor,
                                value:
                                    inventoryController
                                        .productSelections[index],
                                onChanged: (value) {
                                  if (value != null) {
                                    inventoryController.toggleProductSelection(
                                      index,
                                      value,
                                    );
                                  }
                                },
                              );
                            });
                          } else if (inventoryController.selectedIndex ==
                              index) {
                            return Obx(() {
                              return Checkbox(
                                value: inventoryController.selectedItems[index],
                                onChanged: (value) {
                                  inventoryController.toggleSelection(index);
                                },
                              );
                            });
                          } else {
                            return SizedBox();
                          }
                        }),

                        SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.background,
                          ),
                          child: SvgPicture.asset(
                            'assets/svgs/add_product.svg',
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          // ✅ Wrap main Column to avoid overflow
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Treactor',
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
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(width: 35),
                                  Text(
                                    'SKUs 25',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "₹40   ",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "₹50",
                                                  style: GoogleFonts.montserrat(
                                                    decoration:
                                                        TextDecoration
                                                            .lineThrough,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          GradientText(
                                            text: "Available For Gift",
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
                                          SizedBox(width: 5),
                                          GradientSvgIcon(
                                            assetName:
                                                'assets/svgs/gift_bw.svg',
                                            size: 12,
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.primaryFirstGradiant,
                                                AppColors.primarySecondGradiant,
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // SizedBox(width: 50),
                                  Spacer(),
                                  SizedBox(
                                    height: 35,
                                    width: 80,
                                    child: GradientOutlinedButton(
                                      text: 'ADD',
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryFirstGradiant,
                                          AppColors.primarySecondGradiant,
                                        ],
                                      ),
                                      onPressed: buildOfflineAlertBox,

                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.border,
                  thickness: 0.5,
                  endIndent: 10,
                  indent: 10,
                ),
              ],
            ),
          ),
          childCount: 15,
        ),
      ),
    ],
  );
}

// Custom SliverPersistentHeader Delegate
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => 120;
  @override
  double get maxExtent => 120;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

void showBottomsheet(BuildContext context) {
  final InventoryController inventoryController = Get.put(
    InventoryController(),
  );
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: inventoryController.bottom_sheet_data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        inventoryController.bottom_sheet_data[index].icon,
                        SizedBox(height: 10),
                        Text(
                          inventoryController.bottom_sheet_data[index].text,
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
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget buildCategoriesTabbar() {
  final StoreCategoryController storeCategoryController = Get.put(
    StoreCategoryController(),
  );
  return Column(
    children: [
      storeCategoryController.previousPageGridTitle == 'Rental' ||
              storeCategoryController.previousPageGridTitle == 'Drone' ||
              storeCategoryController.previousPageGridTitle == 'Expert'
          ? Image.asset('assets/images/tractor.jpg', height: 50)
          : SvgPicture.asset('assets/svgs/add_product.svg'),
      SizedBox(height: 5),
      Text(
        storeCategoryController.previousPageGridTitle == 'Rental' ||
                storeCategoryController.previousPageGridTitle == 'Drone' ||
                storeCategoryController.previousPageGridTitle == 'Expert'
            ? 'Tractor'
            : 'Category',
        textAlign: TextAlign.center,
      ),
    ],
  );
}

void buildOfflineAlertBox() {
  Get.dialog(
    AlertDialog(
      content: SingleChildScrollView(
        // Prevent overflow issues
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Prevent unnecessary height expansion
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
                  if (Get.isDialogOpen == true) {
                    Get.back();
                  }
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
                  if (Get.isDialogOpen ?? false) {
                    Get.back(); // Closes the dialog
                  }
                },
                height: 35,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

void seeOptionBottomsheet(BuildContext context) {
  final InventoryController inventoryController = Get.put(
    InventoryController(),
  );
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
                    inventoryController.productSelections
                        .where((selected) => selected == true)
                        .length;

                final List<Map<String, dynamic>> filteredOptions =
                    selectedCount <= 1
                        ? [
                          {'text': 'Edit', 'icon': Icons.edit_outlined},
                          {
                            'text': 'Out of\nStock',
                            'icon': Icons.shopping_cart_checkout,
                          },
                          {
                            'text': 'Add to\nCollection',
                            'icon': Icons.dataset_outlined,
                          },
                          {
                            'text': 'Delete\nProduct',
                            'icon': Icons.delete_outline,
                          },
                          {'text': 'Print', 'icon': Icons.print_rounded},
                        ]
                        : inventoryController.seeOptionList
                            .where((item) => item['text'] != 'Edit')
                            .toList();

                return ListView.builder(
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
