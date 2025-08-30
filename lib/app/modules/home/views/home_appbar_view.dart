import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/Wallet/views/wallet_view.dart';
import 'package:farmitra/app/modules/home/controllers/home_bottom_bar_controller.dart';
import 'package:farmitra/app/modules/home/controllers/home_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_selected_module_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

class HomeAppbarView extends GetView implements PreferredSizeWidget {
  HomeAppbarView({super.key});
  final HomeController homeController = Get.put(HomeController());
  final StoreCategoryController storeCategoryController = Get.put(
    StoreCategoryController(),
  );
  final HomeBottomBarController homeBottomBarController = Get.find();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
            // width: 200, // Set your desired width
            child: Marquee(
              blankSpace: 100,
              text:
                  // 'Store Name',
                  (homeBottomBarController.user_name != null &&
                          homeBottomBarController.user_name.isNotEmpty)
                      ? homeBottomBarController.user_name
                      : 'Store Name' ?? 'N/A',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              scrollAxis: Axis.horizontal,

              velocity: 40.0,
              pauseAfterRound: Duration(seconds: 3),
              startPadding: 0.0,
              accelerationDuration: Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
          SizedBox(height: 5),
          Text(
            // storeCategoryController.previousPageGridTitle == 'Rental' ||
            //         storeCategoryController.previousPageGridTitle == 'Drone'
            //     ? ''
            //     : homeController.box.read('user_role') == 'Expert'
            //     ? 'Agriculture | Field Expert'
            //     : homeController.box.read('user_role') == 'Vendor'
            //     ? 'Agri Inputs | Seeds '
            //     : 'Category | SubCategory',
            '${homeBottomBarController.user_id.toString()}' ?? 'N/A',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Last Session',
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appBarColor,
                    ),
                  ),
                  Obx(
                    () => Text.rich(
                      TextSpan(
                        children: [
                          // Hours
                          TextSpan(
                            text:
                                '${homeController.hours.value.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'h ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${homeController.minutes.value.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'm ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${homeController.seconds.value.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(
                            text: 's',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 0),
                  child: SizedBox(
                    height: 35,
                    // width: 10,
                    child: Obx(() {
                      return homeController.isTapped == true
                          ? GestureDetector(
                            onTap: () {
                              homeController.isTapped.value =
                                  !homeController.isTapped.value;
                              homeController.stopTimer();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Go Online',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryGradinatMixColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                          : CustomGradientButton(
                            text: "Go Offline",
                            onPressed: () {
                              homeController.isTapped.value = true;

                              homeController.startTimer();
                            },
                          );

                      // Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //       color: Colors.white,
                      //     ),
                      //     child: CustomOutlinedButton(
                      //       spacing: 25,
                      //         text: 'Go Offline',
                      //         textStyle: GoogleFonts.montserrat(
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w600,
                      //             color: AppColors.textPrimary),
                      //         onPressed: () {
                      //
                      //         },
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(20),
                      //             border: Border.all(
                      //                 color: AppColors
                      //                     .primaryGradinatMixColor))),
                      //   );
                      //  CustomGradientButton(
                      //   text: homeController.isTapped == true
                      //       ? "Go Ofline"
                      //       : "Go Online",
                      //   onPressed: () {
                      //     homeController.isTapped.value =
                      //         !homeController.isTapped.value;

                      //     homeController.isTapped.value == true
                      //         ? homeController.startTimer()
                      //         : homeController.stopTimer();
                      //   },
                      // ),
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColors.white),
          ),
          child: GestureDetector(
            onTap: () {
              Get.to(() => WalletView());
            },
            child: SvgPicture.asset(
              'assets/icons/home_icons/Wallet.svg',
              height: 25,
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColors.white),
          ),
          child: Icon(Icons.notifications_outlined, color: AppColors.white),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
