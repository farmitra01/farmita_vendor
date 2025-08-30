import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/inventory/controllers/product_details_controller.dart';
import 'package:farmitra/app/modules/inventory/views/edit_product.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart'; // Make sure to import GetX
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatelessWidget {
  // Use GetX to initialize the controller properly
  final ProductDetailsController productDetailsController = Get.put(
    ProductDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: false,
        title: TextFormField(
          decoration: InputDecoration(
            prefixIcon: GestureDetector(
              onTap: () {
                Get.back();
                ();
              },
              child: Icon(Icons.arrow_back, color: Colors.grey),
            ),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            hintText: " Search in ...",
            hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search, color: AppColors.textSecondary),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 24,
                    width: 1,
                    color: AppColors.lightGrey,
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
      body: Column(
        children: [
          PreferredSize(
            preferredSize: Size.fromHeight(50), // Set the height for TabBar
            child: TabBar(
              labelColor: AppColors.appBarColor,
              indicatorColor: AppColors.primaryGradinatMixColor,
              labelPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              unselectedLabelColor: AppColors.textSecondary,
              automaticIndicatorColorAdjustment: true,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              controller: productDetailsController.tabController,
              tabs: List.generate(
                6,
                (index) => Tab(text: 'Vegitables & Fruits'),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: productDetailsController.tabController,
              children: List.generate(6, (index) {
                return Center(child: FirstFindLibrary(context));
              }),
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
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

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

Widget FirstFindLibrary(BuildContext context) {
  final ProductDetailsController productDetailsController = Get.put(
    ProductDetailsController(),
  );
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Row(
            children: [
              Obx(() {
                return Checkbox(
                  value: productDetailsController.isAllSelected.value,
                  activeColor: AppColors.primaryGradinatMixColor,
                  onChanged: (bool? value) {
                    if (value != null) {
                      productDetailsController.toggleSelectAll(value);
                      productDetailsController.showCheckBox();
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
                    TextSpan(),
                    TextSpan(
                      text: "(125 Products)",
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
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 15,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                productDetailsController.showCheckBox();
                // productDetailsController.selectIndex(index);
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Obx(
                          () =>
                              productDetailsController.isChecked.value == true
                                  ? SizedBox(
                                    height: 5,
                                    width: 10,
                                    child: Obx(() {
                                      return Checkbox(
                                        activeColor:
                                            AppColors.primaryGradinatMixColor,

                                        value:
                                            productDetailsController
                                                .productSelections[index],
                                        onChanged: (value) {
                                          if (value != null) {
                                            productDetailsController
                                                .toggleProductSelection(
                                                  index,
                                                  value,
                                                );
                                          }
                                        },
                                      );
                                    }),
                                  )
                                  : productDetailsController.selectedIndex ==
                                      index
                                  ? SizedBox(
                                    height: 5,
                                    width: 10,
                                    child: Obx(
                                      () => Checkbox(
                                        activeColor:
                                            AppColors.primaryGradinatMixColor,
                                        value:
                                            productDetailsController
                                                .selectedItems[index],
                                        onChanged: (value) {
                                          productDetailsController
                                              .toggleSelection(index);
                                        },
                                      ),
                                    ),
                                  )
                                  : SizedBox(),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
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
                        const SizedBox(width: 10),
                        Column(
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
                                      color: const Color(0xff8a8a8a),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Switch with GetX
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Switch(
                                value:
                                    productDetailsController
                                        .switchStates[index],
                                onChanged: (value) {
                                  productDetailsController.toggleSwitch(
                                    index,
                                    value,
                                  );
                                  productDetailsController
                                      .isSwitchedState
                                      .value = value;
                                },
                                activeColor: AppColors.white,
                                activeTrackColor:
                                    AppColors.primaryGradinatMixColor,
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor: AppColors.white,
                              ),
                            ),
                            Obx(
                              () => Text(
                                productDetailsController.switchStates[index]
                                    ? " Delete from\ninventory"
                                    : " Add to\ninventory",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
            );
          },
        ),
      ],
    ),
  );
}

void seeOptionBottomsheet(BuildContext context) {
  final ProductDetailsController productDetailsController = Get.put(
    ProductDetailsController(),
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
                itemCount: productDetailsController.bottom_sheet_data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        productDetailsController.bottom_sheet_data[index].icon,
                        SizedBox(height: 10),
                        Text(
                          productDetailsController
                              .bottom_sheet_data[index]
                              .text,
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
