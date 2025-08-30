import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/storeProfile/controllers/store_profile_controller.dart';
import 'package:farmitra/app/modules/storeProfile/views/about_view.dart';
import 'package:farmitra/app/modules/storeProfile/views/review_view.dart';
import 'package:farmitra/app/modules/storeProfile/views/storesTabProfile_view.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class StoreProfileView extends GetView<StoreProfileController> {
  StoreProfileView({super.key});
  final StoreProfileController storeProfileController = Get.put(
    StoreProfileController(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            physics: BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Obx(
                            () => CarouselSlider(
                              options: CarouselOptions(
                                height: 200.0,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  storeProfileController.updateIndex(index);
                                },
                              ),
                              items:
                                  (storeProfileController
                                              .selectedBannerPaths
                                              .isNotEmpty
                                          ? storeProfileController
                                              .selectedBannerPaths
                                          : storeProfileController
                                              .defaultGridImages)
                                      .map((imagePath) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurStyle: BlurStyle.inner,
                                                    spreadRadius: 10,
                                                    blurRadius: 5,
                                                    color: Colors.white,
                                                    offset: Offset(0, 10),
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child:
                                                    imagePath.startsWith(
                                                          'assets/',
                                                        )
                                                        ? Image.asset(
                                                          imagePath,
                                                          fit: BoxFit.cover,
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                        )
                                                        : Image.file(
                                                          File(imagePath),
                                                          fit: BoxFit.cover,
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                        ),
                                              ),
                                            );
                                          },
                                        );
                                      })
                                      .toList(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(
                                      0.0,
                                    ), // transparent towards top
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 25,
                            child: Container(
                              height: 35,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryFirstGradiant,
                                    AppColors.primarySecondGradiant,
                                  ],
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '4.5',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  VerticalDivider(
                                    color: Colors.white,
                                    indent: 5,
                                    endIndent: 5,
                                  ),
                                  Text(
                                    '23',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(),
                                  Icon(
                                    Icons.group,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -10,
                            child: SizedBox(
                              height: 50,
                              width: 100,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    storeProfileController
                                        .selectedBannerPaths
                                        .length,
                                itemBuilder: (context, index) {
                                  return Obx(() {
                                    bool isActive =
                                        index ==
                                        storeProfileController
                                            .currentIndex
                                            .value;
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              isActive
                                                  ? AppColors
                                                      .primaryGradinatMixColor
                                                  : Colors.white,
                                        ),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 20,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                                ();
                              },
                              child: Container(
                                height: 50,
                                width: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white70,
                                ),
                                child: Icon(Icons.arrow_back),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Container(
                                //   height: 50,
                                //   width: 35,
                                //   decoration: BoxDecoration(
                                //     shape: BoxShape.circle,
                                //     color: Colors.white70,
                                //   ),
                                //   child: Icon(Icons.message_rounded, size: 20),
                                // ),
                                // SizedBox(width: 30),
                                InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                      buildProfilAndBannerUploadBottomSheet(),
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white70,
                                    ),
                                    child: Icon(Icons.edit, size: 20),
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
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  collapsedHeight: 110,
                  expandedHeight: 110,
                  backgroundColor: AppColors.white,
                  automaticallyImplyLeading: false,

                  flexibleSpace: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.bottomSheet(
                              buildProfilAndBannerUploadBottomSheet(),
                            );
                          },
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 35,
                                child: Text(
                                  'Farmitra',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 25,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryGradinatMixColor,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    size: 10,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(width: 15),
                      Expanded(
                        child: Obx(() {
                          if (storeProfileController.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final details =
                              storeProfileController.userDetails.value;
                          if (details == null || details.data == null) {
                            return const Center(
                              child: Text("No data available"),
                            );
                          }

                          final data = details.data!; // ✅ Vendor model
                          // ✅ This is your Vendor model (UserData)
                          // print('Api Response in #');
                          return SingleChildScrollView(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ✅ Store Name
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data.storeName ?? 'Store Name',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 5),

                                // ✅ Category | Subcategory
                                Row(
                                  children: [
                                    Text(
                                      data.category != null
                                          ? data.category!.name ?? "Category"
                                          : "Category",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      '|',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      data.subcategories != null &&
                                              data.subcategories!.isNotEmpty
                                          ? data.subcategories!.first.name ??
                                              "Sub Category"
                                          : "Sub Category",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 5),

                                // ✅ Address
                                Text(
                                  data.address ?? 'No Address',
                                  maxLines: 5,
                                  softWrap: true,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // SizedBox(width: 10),
                          Text(
                            'Sun-Mon ',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text('|', style: TextStyle(fontSize: 22)),
                          SizedBox(width: 5),
                          Text(
                            '9:00 Am - 8:00 Pm',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: AppColors.primaryGradinatMixColor,
                              ),
                            ),
                            child: GradientSvgIcon(
                              icon: Icon(Icons.campaign),
                              size: 20,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.primaryFirstGradiant,
                                  AppColors.primarySecondGradiant,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'Sun-Mon ',
                      //       style: GoogleFonts.montserrat(
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.w500,
                      //         color: AppColors.textSecondary,
                      //       ),
                      //     ),
                      //     Text(
                      //       '|',
                      //       style: TextStyle(
                      //         fontSize: 22,
                      //         color: AppColors.textSecondary,
                      //       ),
                      //     ),
                      //     Text(
                      //       '9:00 Am - 8:00 Pm',
                      //       style: GoogleFonts.montserrat(
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.w500,
                      //         color: AppColors.textSecondary,
                      //       ),
                      //       overflow: TextOverflow.ellipsis,
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 10),
                      Divider(thickness: 5, color: AppColors.border),
                    ],
                  ),
                ),
                // **Scrollable Tab Bar**
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: _SliverTabBarDelegate(
                    TabBar(
                      tabs: [
                        Tab(text: 'Profile'),
                        Tab(text: 'Reviews'),
                        Tab(text: 'About'),
                      ],
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        // color: AppColors.primaryGradinatMixColor,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryFirstGradiant,
                            AppColors.primarySecondGradiant,
                          ],
                        ),
                      ),
                      labelColor: AppColors.white,
                      labelStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      dividerColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      unselectedLabelColor: AppColors.textSecondary,
                    ),
                  ),
                ),
              ];
            },

            // **Scrollable TabBarView**
            body: TabBarView(
              children: [StoresTabProfileView(), ReviewView(), AboutView()],
            ),
          ),
        ),
      ),
    );
  }
}

// **Custom SliverPersistentHeader Delegate for TabBar**
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.white, child: tabBar);
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}

Widget buildProfilAndBannerUploadBottomSheet() {
  final StoreProfileController storeProfileController = Get.put(
    StoreProfileController(),
  );

  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            'Upload Logo and Banner',
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),

          Row(
            children: [
              SizedBox(width: 10),

              // Logo Upload
              GestureDetector(
                onTap: () {
                  storeProfileController.pickImage('logo');
                },
                child: Obx(() {
                  return DottedBorder(
                    dashPattern: [2.5, 5],
                    borderType: BorderType.RRect,
                    color: AppColors.border,
                    radius: Radius.circular(10),
                    child: Container(
                      height: 125,
                      width: 125,
                      child:
                          storeProfileController.selectedLogoPath.value.isEmpty
                              ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgs/uploadicon.svg',
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Upload Logo',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    textAlign: TextAlign.center,
                                    'JPEG, PNG, less than 3 MB',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                              : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(
                                    storeProfileController
                                        .selectedLogoPath
                                        .value,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                    ),
                  );
                }),
              ),

              SizedBox(width: 15),

              // Banner Upload
              GestureDetector(
                onTap: () {
                  storeProfileController.pickImage('banner');
                },
                child: DottedBorder(
                  dashPattern: [2.5, 5],
                  borderType: BorderType.RRect,
                  color: AppColors.border,
                  radius: Radius.circular(10),
                  child: Container(
                    height: 125,
                    width: 175,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svgs/uploadicon.svg'),
                        SizedBox(height: 5),
                        Text(
                          'Upload Banner',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'JPEG, PNG, less than 5 MB',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),
          Text(
            'Banner Images:',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Upload Images for your profile banner.',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),

          // -------- GRID VIEW (Default or Uploaded Images) --------
          Obx(() {
            final images =
                storeProfileController.selectedBannerPaths.isEmpty
                    ? storeProfileController.defaultGridImages
                    : storeProfileController.selectedBannerPaths;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 135,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                            images[0].contains('assets/')
                                ? Image.asset(images[0], fit: BoxFit.fill)
                                : Image.file(File(images[0]), fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: images.length > 1 ? images.length - 1 : 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemBuilder: (context, index) {
                      final img = images[index + 1];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                              img.contains('assets/')
                                  ? Image.asset(img, fit: BoxFit.fill)
                                  : Image.file(File(img), fit: BoxFit.fill),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),

          SizedBox(height: 15),
          CustomGradientButton(
            text: 'Upload Images',
            onPressed: () {
              Get.back();
              // storeProfileController.addBannerImage();
              onTap:
              () async {
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  storeProfileController.addBannerImage();
                }
              };
            },
          ),
        ],
      ),
    ),
  );
}
