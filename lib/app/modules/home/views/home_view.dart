import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/data/models/store_select_model/store_select_model.dart';
import 'package:farmitra/app/modules/POS/views/filter.dart';
import 'package:farmitra/app/modules/Wallet/views/wallet_view.dart';
import 'package:farmitra/app/modules/home/views/AppColorSetting.dart';
import 'package:farmitra/app/modules/home/views/Appointment.dart';
import 'package:farmitra/app/modules/home/views/feed.dart';
import 'package:farmitra/app/modules/home/views/home_appbar_view.dart';
import 'package:farmitra/app/modules/home/views/manage_appointmant.dart';
import 'package:farmitra/app/modules/home/views/manage_services.dart';
import 'package:farmitra/app/modules/home/views/vehical_list.dart';
import 'package:farmitra/app/modules/my_subscription/views/my_subscription_view.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/modules/registration/controllers/store_selected_module_controller.dart';
import 'package:farmitra/app/modules/storeProfile/views/refer&earn.dart';
import 'package:farmitra/app/modules/storeProfile/views/reward.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';
import 'package:farmitra/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  final StoreCategoryController storeCategoryController = Get.put(
    StoreCategoryController(),
  );
  final StoreSelectedModuleController storeSelectedModuleController = Get.put(
    StoreSelectedModuleController(),
  );

  @override
  Widget build(BuildContext context) {
    // var box = GetStorage();
    print(
      'Stored Vendor Details on home page ${homeController.box.read('user_details')} ',
    );
    print(
      'Stored Vendor Role on home page ${homeController.box.read('user_role')}',
    );
    int _getItemCount() {
      if (homeController.box.read('user_role') == 'Rental' ||
          homeController.box.read('user_role') == 'Drone') {
        return homeController.rentalGridItem.length;
      } else if (homeController.box.read('user_role') == 'Vendor') {
        return homeController.retailerGridItem.length;
      }
      return homeController.quickAccessGridItem.length;
    }

    dynamic _getGridItem(int index) {
      if (homeController.box.read('user_role') == 'Rental' ||
          homeController.box.read('user_role') == 'Drone') {
        return homeController.rentalGridItem[index];
      } else if (homeController.box.read('user_role') == 'Vendor') {
        return homeController.retailerGridItem[index];
      }
      return homeController.quickAccessGridItem[index];
    }

    void _handleGridTap(int index, BuildContext context) {
      final category = homeController.box.read('user_role');
      final isRetailer = homeController.box.read('user_role') == 'Vendor';

      switch (index) {
        case 0:
          if (isRetailer) {
            Get.toNamed('/pos');
          }
          if (category == 'Expert') {
            Get.to(() => Appointment());
          }
        case 1:
          if (isRetailer) {
            // Get.toNamed('/pos');
          }
          if (category == 'Expert') {
            Get.to(() => Feed());
          }
        case 2:
          if (category == 'Expert') Get.toNamed("/khata-book");
          break;
        case 4:
          if (isRetailer || category == 'Expert') Get.to(() => WalletView());
          break;
        case 6:
          if (category == 'Rental' || category == 'Drone') {
            Get.to(() => VehicalList());
          } else if (category == 'Expert') {
            Get.to(() => ManageAppointmant());
          }
          break;
        case 7:
          if (isRetailer) {
            Get.to(() => MySubscriptionView());
          } else if (category == 'Expert') {
            Get.to(() => MySubscriptionView());
          }
          break;
        case 9:
          if (category == 'Vendor') {
            Get.toNamed('/inventry');
          }
          break;
        case 12:
          if (category == 'Expert') Get.toNamed("/add-coupons");

        case 13:
          if (category == 'Expert') Get.toNamed("/advertisement");

        case 17:
          if (isRetailer)
            Get.toNamed("/inventory");
          else if (category == 'Expert') {
            Get.to(() => RewardView());
          }
        case 19:
          if (isRetailer)
          // Get.toNamed("/inventory");
          {
          } else if (category == 'Expert') {
            Get.toNamed('/help-center');
          }
        case 22:
          {
            Get.toNamed('/help-center');
          }
          break;
        default:
          break;
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Future.microtask(() async {
            final shouldExit =
                await Get.dialog<bool>(
                  AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('Do you want to close the app?'),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(result: false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Get.back(result: true),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                ) ??
                false;

            if (shouldExit) {
              SystemNavigator.pop();
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: HomeAppbarView(),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Analytics',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      child: TextButton(
                        onPressed: () {
                          Get.to(Filter());
                        },
                        child: Text(
                          'Filter',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryGradinatMixColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                // SizedBox(
                //   height: 150, // Aligned with Container height to avoid clipping
                //   child: ListView.builder(
                //     itemCount: homeController.salesReport.length,
                //     scrollDirection: Axis.horizontal,
                //     physics: NeverScrollableScrollPhysics(),
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 10,
                //     ), // Moved padding here for consistency
                //     itemBuilder: (context, index) {
                //       final report =
                //           homeController.salesReport[index]; // Safe access
                //       return
                //     },
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ), // Moved padding to margin
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius:
                                  4, // Slightly increased for softer shadow
                              spreadRadius: 0,
                              offset: const Offset(
                                0,
                                2,
                              ), // Subtle vertical offset
                              color: AppColors.textSecondary.withOpacity(
                                0.3,
                              ), // Softer shadow
                            ),
                          ],
                          color: AppColors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/home_icons/Today.svg',
                              height:
                                  40, // Constrain image size for consistency
                              width: 40,
                            ),
                            const SizedBox(
                              height: 8,
                            ), // Space between image and text
                            Text(
                              '₹ 0.00', // Consider dynamic data if available
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4), // Space between texts
                            Text(
                              'Today', // Typo fixed in model if applicable
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2, // Prevent overflow
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ), // Moved padding to margin
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius:
                                  4, // Slightly increased for softer shadow
                              spreadRadius: 0,
                              offset: const Offset(
                                0,
                                2,
                              ), // Subtle vertical offset
                              color: AppColors.textSecondary.withOpacity(
                                0.3,
                              ), // Softer shadow
                            ),
                          ],
                          color: AppColors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/home_icons/last7days.svg',
                              height:
                                  40, // Constrain image size for consistency
                              width: 40,
                            ),
                            const SizedBox(
                              height: 8,
                            ), // Space between image and text
                            Text(
                              '₹ 0.00', // Consider dynamic data if available
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4), // Space between texts
                            Text(
                              // report
                              'Last 7 days', // Typo fixed in model if applicable
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2, // Prevent overflow
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ), // Moved padding to margin
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius:
                                  4, // Slightly increased for softer shadow
                              spreadRadius: 0,
                              offset: const Offset(
                                0,
                                2,
                              ), // Subtle vertical offset
                              color: AppColors.textSecondary.withOpacity(
                                0.3,
                              ), // Softer shadow
                            ),
                          ],
                          color: AppColors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/home_icons/last30days.svg',
                              height:
                                  40, // Constrain image size for consistency
                              width: 40,
                            ),
                            const SizedBox(
                              height: 8,
                            ), // Space between image and text
                            Text(
                              '₹ 0.00', // Consider dynamic data if available
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4), // Space between texts
                            Text(
                              'Last 30 days', // Typo fixed in model if applicable
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2, // Prevent overflow
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quick Access',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          AppColorSetting(),
                          isScrollControlled: true,
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/home_icons/Edit.svg'),
                          SizedBox(width: 5),
                          Text(
                            'Edit',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      // BoxShadow(
                      //   blurRadius: 5,
                      //   color: AppColors.containerShadowColor,
                      // ),
                    ],
                    color: AppColors.white,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _getItemCount(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      // crossAxisSpacing: .5, // Added horizontal spacing
                      // mainAxisSpacing: .5, // Added vertical spacing
                      // childAspectRatio: 1.2, // Adjusted for better balance
                    ),
                    itemBuilder: (context, index) {
                      final gridItem = _getGridItem(index);
                      return GestureDetector(
                        onTap: () => _handleGridTap(index, context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientSvgIcon(
                              icon: Icon(
                                gridItem.gridItemIcon,
                                color: AppColors.primaryGradinatMixColor,
                              ),
                              size: 30,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.primaryFirstGradiant,
                                  AppColors.primarySecondGradiant,
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ), // Space between icon and text
                            Text(
                              gridItem.gridItemText,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2, // Prevent overflow
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 15),
                // Container(
                //   height: 150,
                //   width: double.infinity,
                //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     boxShadow: [
                //       BoxShadow(
                //         blurRadius: 5,
                //         color: AppColors.containerShadowColor,
                //       ),
                //     ],
                //     color: AppColors.background,
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Icon(
                //         Icons.network_check_sharp,
                //         color: AppColors.textSecondary,
                //       ),
                //       SizedBox(height: 5),
                //       Text(
                //         '  You have no store\ninsights available yet',
                //         style: GoogleFonts.montserrat(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w500,
                //           color: AppColors.textSecondary,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 15),
                GradientText(
                  text: 'Farmitra',
                  style: GoogleFonts.montserrat(
                    fontSize: 52,
                    fontWeight: FontWeight.w700,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryFirstGradiant,
                      AppColors.primarySecondGradiant,
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "The Farmer's Friend.",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.appBarColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Designed & Developed with ❤️ in Bharat',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 10),

                SizedBox(height: 50),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: HomeBottomBarView()
      ),
    );
  }
}
