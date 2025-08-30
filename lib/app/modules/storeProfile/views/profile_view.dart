import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/profile_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_profile_card.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';
import 'package:farmitra/app/utils/global_widgets/store_profile_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

class ProfileView extends GetView {
  ProfileView({super.key});
  final ProfileController profileController = Get.put(ProfileController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                // width: 300,
                child: Marquee(
                  text:
                      '${box.read('user_details')['store_name']}' ??
                      'Store Name',

                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),

                  scrollAxis: Axis.horizontal,
                  blankSpace: 20.0,
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
                //     :
                box.read('user_role') == 'Expert'
                    ? 'Agriculture | Field Expert'
                    : 'Agri Inputs | Seeds ',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.white),
            ),
            child: SvgPicture.asset(
              'assets/icons/home_icons/Wallet.svg',
              height: 25,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 200, child: CustomVendorProfileCard()),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.lightBlue),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    '${box.read('user_details')['store_name']}' ??
                                        '',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  box.read('user_role') == 'Expert'
                                      ? 'Agriculture | Field Expert'
                                      : 'Agri Inputs | Seeds ',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.dialog(buildQrDialog(context));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.lightGrey,
                                    ),
                                    child: Icon(
                                      Icons.qr_code_2_outlined,
                                      size: 35,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Tap to Open',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Status',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 0,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.lightGrey,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: AppColors.yellow,
                              ),
                              SizedBox(width: 2.5),
                              Text(
                                'Waiting Approval',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                              ),
                              SizedBox(width: 2.5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    width: 350,
                    top: -50,
                    right: -2.5,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurStyle: BlurStyle.normal,
                            color: AppColors.containerShadowColor,
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: Offset(0.1, -4),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset('assets/svgs/profileRoof.svg'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Finish your store setup (2/6)',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Unfortunately 😔, we can’t show your profile on the customer feed until you complete your setup.',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Row(
                children: [
                  GradientSvgIcon(
                    icon: Icon(Icons.contact_mail_outlined),
                    size: 25,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primaryFirstGradiant,
                        AppColors.primarySecondGradiant,
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  GradientText(
                    text: 'Profile',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
                ],
              ),
            ),
            SizedBox(
              height: 160,
              child: CustomProfileCard(
                additionalContent: Padding(
                  padding: const EdgeInsets.only(left: 0, right: 15),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/store-profile');
                        },
                        child: StoreProfileRow(
                          leadingIcon: Icons.storefront_outlined,
                          text: "STORE PROFILE",
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.primaryFirstGradiant,
                              AppColors.primarySecondGradiant,
                            ],
                          ),
                          trailingIcon: Icons.arrow_forward_ios_outlined,
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/owner-profile');
                        },
                        child: StoreProfileRow(
                          leadingIcon: Icons.account_circle_outlined,
                          text: "OWNER'S PROFILE",
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.primaryFirstGradiant,
                              AppColors.primarySecondGradiant,
                            ],
                          ),
                          trailingIcon: Icons.arrow_forward_ios_outlined,
                        ),
                      ),
                      SizedBox(height: 10),
                      StoreProfileRow(
                        leadingIcon: Icons.groups_2_outlined,
                        text: "USERS & ROLES",
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryFirstGradiant,
                            AppColors.primarySecondGradiant,
                          ],
                        ),
                        trailingIcon: Icons.arrow_forward_ios_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: GradientSvgIcon(
                      icon: Icon(Icons.currency_rupee_rounded),
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
                    title: Text(
                      'Cash & Bank',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    iconColor: AppColors.lightGrey,
                    collapsedIconColor: AppColors.lightGrey,
                    onExpansionChanged: (Value) {
                      profileController.isCashbankExpanded.value = Value;
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(() {
              return profileController.isCashbankExpanded.value
                  ? Column(
                    children: [
                      SizedBox(height: 10),
                      SizedBox(
                        height: 300,
                        child: CustomProfileCard(
                          additionalContent: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              children: [
                                StoreProfileRow(
                                  leadingIcon: Icons.done_all_outlined,
                                  text: 'Add Bank',
                                ),
                                SizedBox(height: 10),
                                StoreProfileRow(
                                  leadingIcon: Icons.done_all_outlined,
                                  text: 'Add UPI',
                                ),
                                SizedBox(height: 10),
                                StoreProfileRow(
                                  leadingIcon: Icons.done_all_outlined,
                                  text: 'Cash/Cheque',
                                ),
                                SizedBox(height: 10),
                                StoreProfileRow(
                                  leadingIcon: Icons.done_all_outlined,
                                  text: 'Khata Book',
                                ),
                                SizedBox(height: 10),
                                StoreProfileRow(
                                  leadingIcon: Icons.done_all_outlined,
                                  text: 'Apply for Loan',
                                ),
                                SizedBox(height: 10),
                                StoreProfileRow(
                                  leadingIcon: Icons.done_all_outlined,
                                  text: 'Loan Amount',
                                ),
                                SizedBox(height: 10),
                                StoreProfileRow(
                                  leadingIcon: Icons.done_all_outlined,
                                  text: 'Fixed Asset',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  : SizedBox(); // Empty widget when not expanded
            }),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: GradientSvgIcon(
                      icon: Icon(Icons.handshake_outlined),
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
                    title: Text(
                      'Business Settings',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    iconColor: AppColors.lightGrey,
                    collapsedIconColor: AppColors.lightGrey,
                    onExpansionChanged: (value) {
                      profileController.isBusinesSettingExpanded.value = value;
                    },
                  ),
                ),
              ),
            ),
            Obx(() {
              return profileController.isBusinesSettingExpanded.value
                  ? SizedBox(
                    height: 450,
                    child: CustomProfileCard(
                      additionalContent: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Offers',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Promotions',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Coupons',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Greetings',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Subscription Plan',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Reports',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Earnings',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Online Store',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Delivery Range/Distance',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Delivery Charges',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Minimum Order Value',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  : SizedBox();
            }),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: GradientSvgIcon(
                      icon: Icon(Icons.settings_outlined),
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
                    title: Text(
                      'Settings',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    iconColor: AppColors.lightGrey,
                    collapsedIconColor: AppColors.lightGrey,
                    onExpansionChanged: (value) {
                      profileController.isSettingExpanded.value = value;
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(() {
              return profileController.isSettingExpanded.value
                  ? SizedBox(
                    height: 300,
                    child: CustomProfileCard(
                      additionalContent: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'General Setting',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Documentation',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Invoice',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Printer',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Signature',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Notes & Terms',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'App. Language',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  : SizedBox();
            }),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: GradientSvgIcon(
                      icon: Icon(Icons.tag),
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
                    title: Text(
                      'Others',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    iconColor: AppColors.lightGrey,
                    collapsedIconColor: AppColors.lightGrey,
                    onExpansionChanged: (value) {
                      profileController.isOthersExpanded.value = value;
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(() {
              return profileController.isOthersExpanded.value
                  ? SizedBox(
                    height: 300,
                    child: CustomProfileCard(
                      additionalContent: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Backup & Store',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Sync',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Offline Store',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Customers',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Parties',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Your Orders',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Use First Find on Desktop',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  : SizedBox();
            }),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: GradientSvgIcon(
                      icon: Icon(Icons.campaign_outlined),
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
                    title: Text(
                      'Refer & Earn',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    iconColor: AppColors.lightGrey,
                    collapsedIconColor: AppColors.lightGrey,
                    onExpansionChanged: (value) {
                      profileController.isReferEarn.value = value;
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(() {
              return profileController.isReferEarn.value
                  ? SizedBox(
                    height: 160,
                    child: CustomProfileCard(
                      additionalContent: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Invite Store',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Invite Customer',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Reward/Loyality',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  : SizedBox();
            }),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: GradientSvgIcon(
                      icon: Icon(Icons.description_outlined),
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
                    title: Text(
                      'Policy',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    iconColor: AppColors.lightBlue,
                    collapsedIconColor: AppColors.lightBlue,
                    onExpansionChanged: (value) {
                      profileController.isPolicy.value = value;
                    },
                  ),
                ),
              ),
            ),
            Obx(() {
              return profileController.isPolicy.value
                  ? SizedBox(
                    height: 350,
                    child: CustomProfileCard(
                      additionalContent: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Refund & Cancelation',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Privacy Policy',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Terms of use',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Support',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Chat with us',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Help',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Tutorials',
                            ),
                            SizedBox(height: 10),
                            StoreProfileRow(
                              leadingIcon: Icons.done_all_outlined,
                              text: 'Tutorials',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  : SizedBox();
            }),
            SizedBox(height: 15),
            InkWell(
              onTap: () {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientSvgIcon(
                    icon: Icon(Icons.power_settings_new_outlined),
                    size: 25,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primaryFirstGradiant,
                        AppColors.primarySecondGradiant,
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Log Out',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'App Version 1.0',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class CustomVendorProfileCard extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Card(
                  elevation: 0,
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: AppColors.border),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap:
                                    () =>
                                        profileController
                                            .showImageSourceDialog(),
                                child: Container(
                                  height: 85,
                                  width: 85,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          color: AppColors.background,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                          child:
                                              profileController
                                                          .pickedImage
                                                          .value !=
                                                      null
                                                  ? Image.file(
                                                    profileController
                                                        .pickedImage
                                                        .value!,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                  )
                                                  : Image.network(
                                                    'https://api.farmitra.in/storage/${box.read('user_details')['logo']}',
                                                    height: 35,
                                                    width: double.infinity,
                                                    fit: BoxFit.fill,
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) => const Icon(
                                                          Icons.broken_image,
                                                        ),
                                                  ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -5,
                                        left: 32,
                                        child: CircleAvatar(
                                          child: Icon(
                                            Icons.photo_camera,
                                            size: 15,
                                            color: AppColors.secondary,
                                          ),
                                          radius: 10,
                                          backgroundColor: AppColors.lightGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${box.read('user_details')['vendor_name']}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryGradinatMixColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '+91 ${box.read('user_details')['whatsapp_no']}',
                                ),
                                SizedBox(height: 5),
                                Text('${box.read('user_details')['email']}'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Account Status'),
                                SizedBox(height: 5),
                                GradientText(
                                  text: "FF FREEMIUM",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xffFD4044),
                                      Color(0xff800002),
                                      Color(0xff08094B),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Valid till August 20, 2024',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: CustomGradientButton(
                                text: "Go Premium",
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 3, left: 0, right: 0, child: HexagonalAvatar()),
                // Positioned(
                //   bottom: 3,
                //   left: 0,
                //   right: 0,
                //   child: HexagonalAvatar2(),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HexagonalAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: Color(0xffFFFFFF), width: 2);
    return Center(
      child: ClipPath(
        clipper: HexagonalClipper(),
        child: CustomPaint(
          painter: HexagonPainter(),
          child: Container(
            width: 130,
            height: 15,
            decoration: BoxDecoration(border: Border(top: borderSide)),
          ),
        ),
      ),
    );
  }
}

class HexagonalAvatar2 extends StatelessWidget {
  final borderSide = BorderSide(color: Color(0xffFFFFFF), width: 2);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: 180 * math.pi / 180,
        child: ClipPath(
          clipper: HexagonalClipper(),
          child: CustomPaint(
            painter: HexagonPainter(),
            child: Container(
              width: 130,
              height: 15,
              decoration: BoxDecoration(border: Border(top: borderSide)),
            ),
          ),
        ),
      ),
    );
  }
}

class HexagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HexagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path hexagonPath = Path();
    hexagonPath.moveTo(0, 0);
    hexagonPath.lineTo(size.width, 0);
    hexagonPath.lineTo(size.width * 0.8, size.height);
    hexagonPath.lineTo(size.width * 0.2, size.height);
    hexagonPath.close();

    Paint strokePaint =
        Paint()
          ..color = Color(0xffDADADA) // Line color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    // Draw only the stroke (line) of the hexagon
    canvas.drawPath(hexagonPath, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Widget buildQrDialog(BuildContext context) {
  return AlertDialog(
    title: Text(
      'QR - Code',
      style: GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryGradinatMixColor,
      ),
      textAlign: TextAlign.center,
    ),
    content: Image.asset('assets/images/bank/QR_code.webp'),
  );
}
