import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/controllers/pos_category_controller.dart';
import 'package:farmitra/app/modules/POS/views/pos_category_search_view.dart';
import 'package:farmitra/app/modules/POS/views/pos_view.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PosCategoryView extends GetView {
  PosCategoryView({super.key});
  final PosCategoryController posCategoryController = Get.put(
    PosCategoryController(),
  );
  // var previousPageGridTitle = Get.arguments;
  // final List<dynamic> args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: VendorAppBar(
        title: "Category",
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: GestureDetector(
              onTap: () => Get.toNamed('/pos_category_search_view'),
              child: Icon(Icons.search, color: AppColors.white),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: Get.size.height),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    selectedIndex: posCategoryController.selectedIndex.value,
                    onDestinationSelected: (int index) {
                      posCategoryController.selectedIndex.value = index;
                    },
                    backgroundColor: AppColors.lightGrey,
                    labelType: NavigationRailLabelType.selected,
                    indicatorColor: AppColors.secondary,
                    useIndicator: false,
                    elevation: 0.1,
                    destinations: List.generate(15, (index) {
                      return NavigationRailDestination(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 8,
                        ),
                        icon: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                posCategoryController.selectedIndex == index
                                    ? AppColors.white
                                    : AppColors.lightGrey,
                          ),
                          child: Image.asset(
                            'assets/images/apple.png',
                            height: 50,
                          ),
                        ),
                        label: Text('Item $index'),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return GestureDetector(
                          onTap: () {
                            _showSortBottomSheet(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.swap_vert,
                                  color: AppColors.textSecondary,
                                  size: 16,
                                ),
                                Text(
                                  'Sort',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.textSecondary,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 10,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            'Data $index',
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 0.5,
                          mainAxisSpacing: 10,
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
                              margin: EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.border,
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
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Green Capsicum\n(Shimla Mirch)',
                                          maxLines: 2,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '250 g',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                            SizedBox(width: 25),
                                            Text(
                                              "SKU's",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          ' ₹40',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 2.5),
                                        Text(
                                          ' ₹50',
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
                                  const SizedBox(height: 2),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 12,
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
                                    posCategoryController.quantities[index] == 0
                                        ? GradientOutlinedButton(
                                          text: 'ADD',
                                          gradient: const LinearGradient(
                                            colors: [
                                              AppColors.primaryFirstGradiant,
                                              AppColors.primarySecondGradiant,
                                            ],
                                          ),
                                          onPressed: () {
                                            posCategoryController
                                                .incrementQuantity(index);
                                            // posCategoryController.addData();
                                            // posCategoryController.getData();
                                            posCategoryController
                                                .isShowItemAddedBar
                                                .value = true;
                                          },
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        )
                                        : Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
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
                                                    posCategoryController
                                                        .decrementQuantity(
                                                          index,
                                                        );
                                                    if (posCategoryController
                                                            .quantities[index] ==
                                                        0) {
                                                      posCategoryController
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
                                                  '${posCategoryController.quantities[index]}',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors
                                                            .primaryGradinatMixColor, // Adjust color
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 35,
                                                width: 30,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed:
                                                      () => posCategoryController
                                                          .incrementQuantity(
                                                            index,
                                                          ),
                                                  icon: Icon(
                                                    Icons.add,
                                                    color:
                                                        AppColors
                                                            .primaryGradinatMixColor, // Adjust color
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
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Obx(() {
        return posCategoryController.isShowItemAddedBar.value
            ? AddedItemList()
            : SizedBox();
      }),
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    final PosCategoryController posCategoryController = Get.put(
      PosCategoryController(),
    );
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 350,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              GradientText(
                text: "Sort:- ",
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryFirstGradiant,
                    AppColors.primarySecondGradiant,
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: posCategoryController.sortTypeList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Text(posCategoryController.sortTypeList[index]),
                        Spacer(),
                        Obx(
                          () => Radio<String>(
                            value: '${index + 1}',
                            groupValue:
                                posCategoryController.IsSortSelected.value,
                            onChanged: (value) {
                              posCategoryController.OnRadioSelected(value);
                              print('Choosed ${index + 1}');
                            },
                            activeColor: AppColors.primaryGradinatMixColor,
                          ),
                        ),
                      ],
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
}
