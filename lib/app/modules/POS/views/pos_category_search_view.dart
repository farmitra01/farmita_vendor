import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/controllers/pos_category_search_controller.dart';
import 'package:farmitra/app/modules/POS/views/checkout.dart';
import 'package:farmitra/app/modules/home/controllers/suggest_controller.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PosCategorySearchView extends GetView {
  PosCategorySearchView({super.key});
  final PosCategorySearchController posCategorySearchController = Get.put(
    PosCategorySearchController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            height: 45,
            child: TextFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, color: AppColors.textSecondary),
                ),
                hintText: 'Search in ...',
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff636363),
                ),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/pos_Search_Result_view');
                        },
                        child: Icon(Icons.search, color: Color(0xff636363)),
                      ),
                      Text(
                        "|",
                        style: GoogleFonts.montserrat(
                          fontSize: 35,
                          fontWeight: FontWeight.w100,
                          color: Color(0xffDCDCDC),
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
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            if (posCategorySearchController.isSearch == false)
              SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Searches',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Clear',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Most Recent Sold',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'View All',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.border),
                            color: AppColors.border,
                          ),
                          child: Image.asset(
                            'assets/images/apple.png',
                            height: 75,
                            width: 75,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Apple (सेब)',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '1 Kg',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              '₹20',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 35),
                            SizedBox(
                              height: 35,
                              child: GradientOutlinedButton(
                                text: 'ADD',
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryFirstGradiant,
                                    AppColors.primarySecondGradiant,
                                  ],
                                ),
                                onPressed: () {},
                                borderRadius: BorderRadius.circular(5),
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
            // if (posCategorySearchController.isSearch == true)
          ],
        ),
      ),
      bottomSheet: AddedItemList(),
    );
  }
}

class AddedItemList extends StatelessWidget {
  AddedItemList({super.key});
  // var previousPageGridTitle = Get.arguments;
  // final List<dynamic> args = Get.arguments ?? [false, false];
  final SuggestProductController suggestProductController = Get.put(
    SuggestProductController(),
  );
  @override
  Widget build(BuildContext context) {
    final List<dynamic> args = Get.arguments ?? [false, false];
    print(' itemlistbottom = ${args}');
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryFirstGradiant,
              AppColors.primarySecondGradiant,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white30,
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white54,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffF2F2F2)),
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        suggestProductController.isShowCheckbox.value == true
                            ? 'assets/images/suggetedProductImage.webp'
                            : 'assets/images/apple.png',
                        height: 50,
                        width: 25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment:
                    suggestProductController.isShowCheckbox.value == true
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    '5 Items',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  suggestProductController.isShowCheckbox.value == true
                      ? SizedBox.shrink()
                      : Row(
                        children: [
                          Text(
                            '₹1576',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '₹1275',
                            style: GoogleFonts.montserrat(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  suggestProductController.isShowCheckbox.value == true
                      ? Get.back()
                      : Get.to(() => Checkout());
                },
                child: Row(
                  children: [
                    Text(
                      'View cart',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                    Icon(Icons.arrow_right, color: AppColors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
