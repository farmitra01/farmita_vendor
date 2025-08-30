import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/views/hold_order.dart';
import 'package:farmitra/app/modules/POS/views/pos_category_search_view.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:hive/hive.dart';
import '../controllers/pos_controller.dart';

class PosView extends GetView<PosController> {
  PosView({super.key});

  @override
  Widget build(BuildContext context) {
    final PosController posController = Get.put(PosController());
    // var previousPageGridTitle = Get.arguments;
    final List<dynamic> args = Get.arguments ?? [false, false];
    print('pos = ${args}');
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: VendorAppBar(
        title: 'POS',
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => HoldOrder());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColors.white),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.white),
                    ),
                    child: Text(
                      '3',
                      style: GoogleFonts.montserrat(color: AppColors.white),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'On-Hold',
                    style: GoogleFonts.montserrat(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Text(
                    'Search in JP Provisional Store',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.search, color: AppColors.textSecondary),
                  SizedBox(width: 10),
                  Text(
                    '|',
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      color: AppColors.border,
                    ),
                  ),
                  SizedBox(width: 10),
                  GradientSvgIcon(
                    icon: Icon(Icons.qr_code_scanner_sharp),
                    size: 30,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryFirstGradiant,
                        AppColors.primarySecondGradiant,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 55,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: posController.categoryList.length,
                itemBuilder: (context, index) {
                  var category = posController.categoryList[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Icon(
                          category['icon'], // Corrected key from 'icons' to 'icon'
                          size: 30,
                          color: AppColors.primaryGradinatMixColor,
                        ),
                      ),
                      Text(
                        category['name'],
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
            Divider(color: AppColors.border),
            GridView.builder(
              shrinkWrap: true, // Ensures GridView takes only required space
              physics:
                  NeverScrollableScrollPhysics(), // Disables GridView scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 10,
                crossAxisSpacing: 0,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showProductDetailsBottomSheet(context);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.containerShadowColor,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.asset(
                                'assets/images/perfume.png',
                                height: 115,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Green Capsicum\n(Shimla Mirch)',
                                  maxLines: 2,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '250 g',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                SizedBox(height: 10),
                                RichText(
                                  softWrap: true,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '₹40\n',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '₹50',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSecondary,
                                          decoration:
                                              TextDecoration.lineThrough,
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
                    Positioned(
                      bottom: 0.2,
                      right: 10,
                      child: Container(
                        height: 40,
                        width: 85,
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Colors.grey.shade100,
                        ),
                        child: Obx(
                          () =>
                              posController.quantities[index] == 0
                                  ? GradientOutlinedButton(
                                    text: 'ADD',
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.primaryFirstGradiant,
                                        AppColors.primarySecondGradiant,
                                      ],
                                    ),
                                    onPressed: () {
                                      posController.incrementQuantity(index);
                                      posController.isShowItemAddedBar.value =
                                          true;
                                    },
                                    borderRadius: BorderRadius.circular(5),
                                  )
                                  : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: AppColors.border,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 35,
                                          width: 30,
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              posController.decrementQuantity(
                                                index,
                                              );
                                              if (posController
                                                      .quantities[index] ==
                                                  0) {
                                                posController
                                                    .isShowItemAddedBar
                                                    .value = false;
                                              }
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                              color:
                                                  AppColors
                                                      .primaryGradinatMixColor,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => Text(
                                            '${posController.quantities[index]}',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  AppColors
                                                      .primaryGradinatMixColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35,
                                          width: 30,
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed:
                                                () => posController
                                                    .incrementQuantity(index),
                                            icon: Icon(
                                              Icons.add,
                                              color:
                                                  AppColors
                                                      .primaryGradinatMixColor,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '   Recurring Orders',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'View All   ',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Image.asset(
                            'assets/images/lays.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 100,
                                width: 100,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Chips & Namkeens',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₹120',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            CustomOutlinedButton(
                              onPressed: () {},
                              text: 'ADD',
                              textStyle: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGradinatMixColor,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '   Recurring Customers',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'View All   ',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Image.asset(
                              'assets/images/manArc.png',
                              height: 100,
                              width: 100,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image_not_supported),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Rahul Satti',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹120',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 2.5),
                              CustomOutlinedButton(
                                onPressed: () {},
                                text: 'View All',
                                textStyle: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: AppColors.primaryGradinatMixColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GradientText(
                text: 'We Sell Everything!',
                style: GoogleFonts.montserrat(
                  fontSize: 52,
                  fontWeight: FontWeight.w700,
                ),
                gradient: LinearGradient(
                  colors: [Color(0xff373A60), Color(0xff7178C6)],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Designed & Developed with ❤️ in Bharat',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffCDCDCD),
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => Padding(
          padding: EdgeInsets.only(
            bottom: posController.isShowItemAddedBar.value == true ? 80 : 20,
          ),
          child: SizedBox(
            width: 150,
            child: FloatingActionButton(
              onPressed: () {},
              child: CustomGradientButton(
                text: 'Category',
                icon: Icons.category,
                onPressed: () {
                  Get.toNamed('/pos_category', arguments: args);
                },
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomSheet: Obx(() {
        return posController.isShowItemAddedBar.value
            ? AddedItemList()
            : SizedBox();
      }),
    );
  }
}

void showProductDetailsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        initialChildSize: 0.9,
        builder: (context, scrollController) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Carousel Slider
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 225,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.8,
                          ),
                          items:
                              [
                                'assets/images/perfum_front.webp',
                                'assets/images/prfume-back.webp',
                                'assets/images/perfume-detais1.webp',
                                'assets/images/perfume-detais2.webp',
                                'assets/images/perfume-detais3.webp',
                                'assets/images/perfume-detais4.webp',
                              ].map((imagePath) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Image.asset(
                                      imagePath,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return const Center(
                                          child: Text('Image not found'),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 10),
                        // Product Title
                        Text(
                          'Park Avenue Men Classic Deo Good Morning',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color:
                                AppColors
                                    .textPrimary, // Replace with AppColors.textPrimary
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Category
                        Text(
                          'Deos & Perfumes',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color:
                                AppColors
                                    .primaryGradinatMixColor, // Replace with AppColors.primaryGradinatMixColor
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Variants
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xffED7D3D),
                                ),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffFFE9DD),
                                    Color(0xffED7D3D),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '220 Ml',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          AppColors
                                              .textPrimary, // Replace with AppColors.textPrimary
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '₹270  ',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors
                                                    .textPrimary, // Replace with AppColors.textPrimary
                                          ),
                                        ),
                                        TextSpan(
                                          text: '₹360',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                AppColors
                                                    .textSecondary, // Replace with AppColors.textSecondary
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.border,
                                ), // Replace with AppColors.border
                                // color: Colors.grey[
                                //     200], // Replace with AppColors.lightGrey
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '2 x 220 Ml',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          AppColors
                                              .textPrimary, // Replace with AppColors.textPrimary
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Out of stock',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          AppColors
                                              .textSecondary, // Replace with AppColors.textSecondary
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Product Details
                        Text(
                          'Product Details:',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color:
                                AppColors
                                    .textPrimary, // Replace with AppColors.textPrimary
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '''Key Features
Fresh, cool and enticing fragrance
With a refreshing blend of citrusy mandarin and bergamot scent notes
Features hints of sweet vanilla and guinea tonka beans
Long lasting effect
Evokes confidence and composure''',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                AppColors
                                    .textSecondary, // Replace with AppColors.textSecondary
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Similar Products
                        Text(
                          'More Similar Products',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color:
                                AppColors
                                    .textPrimary, // Replace with AppColors.textPrimary
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 265,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return _buildProductItem(context);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Top 10 Products
                        Text(
                          'Top 10 products you will sell in this categories:',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color:
                                AppColors
                                    .textPrimary, // Replace with AppColors.textPrimary
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 265,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return _buildProductItem(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Bottom Fixed Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '220 ML',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                AppColors
                                    .textPrimary, // Replace with AppColors.textPrimary
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '₹520',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      AppColors
                                          .textPrimary, // Replace with AppColors.textPrimary
                                ),
                              ),
                              TextSpan(
                                text: ' MRP ',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      AppColors
                                          .textSecondary, // Replace with AppColors.textSecondary
                                ),
                              ),
                              TextSpan(
                                text: '₹360',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      AppColors
                                          .textSecondary, // Replace with AppColors.textSecondary
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Inclusive of all taxes',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomGradientButton(
                        borderRadius: 10,
                        text: 'Add to Cart',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

// Helper method to build product items
Widget _buildProductItem(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.border,
            ), // Replace with AppColors.border
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/neviaMan_Deo.png',
              height: 150,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 100,
          child: Text(
            'Nivea Men Fresh Active Deodorant',
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color:
                  AppColors.textPrimary, // Replace with AppColors.textPrimary
            ),
          ),
        ),
        Text(
          '150 ML',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color:
                AppColors.textSecondary, // Replace with AppColors.textSecondary
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '₹175',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color:
                          AppColors
                              .textPrimary, // Replace with AppColors.textPrimary
                    ),
                  ),
                  TextSpan(
                    text: '\n₹200',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color:
                          AppColors
                              .textSecondary, // Replace with AppColors.textSecondary
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 35,
              child: GradientOutlinedButton(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryFirstGradiant,
                    AppColors.primarySecondGradiant,
                  ],
                ),
                onPressed: () {},
                borderRadius: BorderRadius.circular(5),
                text: 'ADD',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
