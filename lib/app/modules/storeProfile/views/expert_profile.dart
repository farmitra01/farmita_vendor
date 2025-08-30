
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/bank_details/views/bank_details_view.dart';
import 'package:farmitra/app/modules/home/views/Appointment.dart';
import 'package:farmitra/app/modules/home/views/manage_appointmant.dart';
import 'package:farmitra/app/modules/login/views/privacy_policy.dart';
import 'package:farmitra/app/modules/login/views/terms_condition.dart';
import 'package:farmitra/app/modules/storeProfile/controllers/expertProfileController.dart';
import 'package:farmitra/app/modules/storeProfile/views/my_profile.dart';
import 'package:farmitra/app/modules/storeProfile/views/reward.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpertProfile extends StatelessWidget {
  const ExpertProfile({super.key});
  @override
  Widget build(BuildContext context) {
    final ExpertprofileController expertprofileController = Get.put(
      ExpertprofileController(),
    );
    final box = GetStorage();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: VendorAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              Container(
                // height: 250,
                // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffC7C7C7),
                      Color(0xffFFFFFF),
                      Color(0xffC7C7C7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.border),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.lightGrey,
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    35,
                                  ),
                                  child: Image.network(
                                    'https://api.farmitra.in/storage/${box.read('user_details')['data']['data']['vendor']['logo']}',
                                    height: 75,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    alignment: Alignment.bottomLeft,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image),
                                  ),
                                ),
                                radius: 35,
                              ),
                              Positioned(
                                bottom: 8,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.background,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.green,
                                    radius: 5,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // SizedBox(width: 20),
                          // Row(
                          //   children: [
                          //     Column(
                          //       children: [
                          //         Text(
                          //           '100k',
                          //           style: GoogleFonts.montserrat(
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.w500,
                          //             color: AppColors.textSecondary,
                          //           ),
                          //         ),
                          //         Text(
                          //           'Follower',
                          //           style: GoogleFonts.montserrat(
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.w500,
                          //             color: AppColors.textSecondary,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(width: 20),
                          //     Column(
                          //       children: [
                          //         Text(
                          //           '10k',
                          //           style: GoogleFonts.montserrat(
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.w500,
                          //             color: AppColors.textSecondary,
                          //           ),
                          //         ),
                          //         Text(
                          //           'Following',
                          //           style: GoogleFonts.montserrat(
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.w500,
                          //             color: AppColors.textSecondary,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(width: 30),
                          SvgPicture.asset(
                            'assets/svgs/farmitra.svg',
                            width: 80,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${box.read('user_details')?['data']['data']['vendor']['vendor_name']}' ??
                            'N/A',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      // SizedBox(height: 5),
                      // GradientText(
                      //   text: 'Expert',
                      //   style: GoogleFonts.montserrat(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      //   gradient: LinearGradient(
                      //     begin: Alignment.topLeft,
                      //     end: Alignment.bottomRight,
                      //     colors: [
                      //       AppColors.primaryFirstGradiant,
                      //       AppColors.primarySecondGradiant,
                      //     ],
                      //   ),
                      // ),

                      // SizedBox(height: 5),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.call_outlined,
                                    color: AppColors.textSecondary,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '+91 ${box.read('user_details')?['data']['data']['vendor']['whatsapp_no']}' ??
                                        'N/A',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.alternate_email,
                                    color: AppColors.textSecondary,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '${box.read('user_details')?['data']['data']['vendor']['email']}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: AppColors.textSecondary,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  SizedBox(
                                    width: 200,

                                    child: Text(
                                      '${box.read('user_details')?['data']['data']['vendor']['address']}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,

                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(color:Colors.green),
                                  color: AppColors.background,
                                ),
                                child: Icon(Icons.qr_code_outlined, size: 25),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Tap to scan',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Get.to(() => RewardView());
                },
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.appBarColor.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 100,
                            child: Image.asset(
                              'assets/images/storeProfile/gifts.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Refer & Earn',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.share,
                                      color: AppColors.primaryGradinatMixColor,
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Invite your friends to earn exciting reward',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: AppColors.border),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Icon(
                                    Icons.diversity_3,
                                    size: 35,
                                    color: AppColors.primaryGradinatMixColor,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '10',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color:
                                              AppColors.primaryGradinatMixColor,
                                        ),
                                      ),
                                      Text(
                                        'Referred Friends',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    size: 35,
                                    color: AppColors.primaryGradinatMixColor,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '10',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color:
                                              AppColors.primaryGradinatMixColor,
                                        ),
                                      ),
                                      Text(
                                        'Referred Friends',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSecondary,
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Column(
                  children: List.generate(
                    expertprofileController.getDetailsList().length,
                    (index) {
                      final item =
                          expertprofileController
                              .getDetailsList()[index]; // Get the map at index
                      return InkWell(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => MyProfile());
                              break;
                            // case 1:
                            //   Get.to(() => Feed());
                            //   break;
                            case 1:
                              Get.to(() => Appointment());
                              break;
                            case 2:
                              Get.toNamed('/store-profile');
                              break;
                            // case 4:
                            //   Get.toNamed('/owner-profile');
                            //   break;
                            case 3:
                              Get.to(() => BankDetailsView());
                              break;
                            case 4:
                              Get.to(() => ManageAppointmant());
                              break;
                            // case 7:
                            //   Get.to(() => Appointment());
                            //   break;
                            case 6:
                              Get.to(() => PrivacyPolicy());
                              break;
                            case 7:
                              Get.to(() => TermsCondition());
                              break;
                            default:
                              break;
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    item['icon'], // Use item to access 'icon'
                                    color: AppColors.primaryGradinatMixColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    item['details'], // Use item to access 'details'
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10,
                                    color: AppColors.primaryGradinatMixColor
                                        .withOpacity(0.9),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: AppColors.primaryGradinatMixColor,
                                thickness: 0.1,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomGradientButton(
                  text: 'Log Out',
                  onPressed: () {
                    final box = GetStorage();
                    box.erase();

                    Get.snackbar(
                      'Logged Out',
                      'You have been successfully logged out.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    CircularProgressIndicator(
                      color: AppColors.primaryGradinatMixColor,
                    );
                    // 🔁 Delay navigation to allow gesture + widget cleanup
                    Future.delayed(Duration(milliseconds: 500), () {
                      Get.offAllNamed('/login');
                    });
                  },
                ),
              ),
              SizedBox(height: 75),
            ],
          ),
        ),
      ),
    );
  }
}
