import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/Help_Center/views/call_support_view.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/help_center_controller.dart';

class HelpCenterView extends GetView<HelpCenterController> {
  HelpCenterView({super.key});
  @override
  Widget build(BuildContext context) {
    final HelpCenterController helpCenterController = Get.put(
      HelpCenterController(),
    );
    return Scaffold(
      appBar: VendorAppBar(title: 'Help Center'),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Text(
                'Contact us for help with your Farmitra account, billing, or service issues.',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8183A1),
                ),
              ),
              SizedBox(height: 15),

              ListView.builder(
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Prevent unnecessary scrolling inside another scrollable widget
                itemCount: helpCenterController.listData.length,
                itemBuilder: (context, index) {
                  var data = helpCenterController.listData[index];
                  var box = GetStorage();
                  final role = box.read('user_role');
                  final isTextSupport = index == 1;

                  final isEnabled = !isTextSupport || role != null;

                  void navigateToPage(int index) {
                    switch (index) {
                      case 0:
                        Get.to(CallEmailSupportView());
                        break;
                      case 1:
                        if (isEnabled) {
                          Get.toNamed('/text-support');
                        }
                        break;
                      case 2:
                        Get.toNamed('/faq');
                        break;
                      case 3:
                        Get.toNamed('/videotutorial');
                        break;
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 15.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Opacity(
                            opacity: isEnabled ? 1.0 : 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap:
                                      isEnabled
                                          ? () => navigateToPage(index)
                                          : null,
                                  child: Row(
                                    children: [
                                      GradientSvgIcon(
                                        assetName: data['image'],
                                        size: index == 2 ? 10 : 20,
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            AppColors.primaryFirstGradiant,
                                            AppColors.primarySecondGradiant,
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        data['title'] ?? '',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 6),
                                if (data['SubTitle'] != null)
                                  Text(
                                    data['SubTitle'],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 80),
              SvgPicture.asset(
                'assets/svgs/farmitra.svg',
                height: 100,
                width: double.infinity,
                color: AppColors.secondary.withOpacity(0.5),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           GestureDetector(
              //             onTap: () {
              //               Get.to(CallSupportView());
              //             },
              //             child: Row(
              //               children: [
              //                 GradientSvgIcon(
              //                   assetName: 'assets/icons/call.svg',
              //                   size: 20,
              //                   gradient: LinearGradient(
              //                     begin: Alignment.topCenter,
              //                     end: Alignment.bottomCenter,
              //                     colors: [
              //                       AppColors.primaryFirstGradiant,
              //                       AppColors.primarySecondGradiant,
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(width: 10),
              //                 Text(
              //                   'Call Support',
              //                   style: GoogleFonts.montserrat(
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w600,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           SizedBox(height: 10),
              //           Text(
              //             '          Chat with Our Support Team for Quick Answers',
              //             style: GoogleFonts.montserrat(
              //               fontSize: 12,
              //               fontWeight: FontWeight.w500,
              //               color: AppColors.textSecondary,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 30),
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed('/text-support');
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               children: [
              //                 GradientSvgIcon(
              //                   assetName: 'assets/icons/message.svg',
              //                   size: 20,
              //                   gradient: LinearGradient(
              //                     begin: Alignment.topCenter,
              //                     end: Alignment.bottomCenter,
              //                     colors: [
              //                       AppColors.primaryFirstGradiant,
              //                       AppColors.primarySecondGradiant,
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(width: 10),
              //                 Text(
              //                   'Text Support',
              //                   style: GoogleFonts.montserrat(
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w600,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             SizedBox(height: 10),
              //             Text(
              //               '          Get Immediate Assistance Over the Phone',
              //               style: GoogleFonts.montserrat(
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w500,
              //                 color: Color(0xff636363),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 20),
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed('/text-support');
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               children: [
              //                 GradientSvgIcon(
              //                   assetName: 'assets/icons/email.svg',
              //                   size: 15,
              //                   gradient: LinearGradient(
              //                     begin: Alignment.topCenter,
              //                     end: Alignment.bottomCenter,
              //                     colors: [Color(0xffF27129), Color(0xffA3410A)],
              //                   ),
              //                 ),
              //                 SizedBox(width: 10),
              //                 Text(
              //                   'Email Support',
              //                   style: GoogleFonts.montserrat(
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w600,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             SizedBox(height: 10),
              //             Text(
              //               '          Reach Out via Email for Detailed Help',
              //               style: GoogleFonts.montserrat(
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w500,
              //                 color: Color(0xff636363),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 15),
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed('/faq');
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               children: [
              //                 GradientSvgIcon(
              //                   assetName: 'assets/icons/faq.svg',
              //                   size: 10,
              //                   gradient: LinearGradient(
              //                     begin: Alignment.topCenter,
              //                     end: Alignment.bottomCenter,
              //                     colors: [Color(0xffF27129), Color(0xffA3410A)],
              //                   ),
              //                 ),
              //                 SizedBox(width: 5),
              //                 Text(
              //                   ' FAQS',
              //                   style: GoogleFonts.montserrat(
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w600,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             SizedBox(height: 10),
              //             Text(
              //               '          Explore Our Knowledge Base for Solutions',
              //               style: GoogleFonts.montserrat(
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w500,
              //                 color: Color(0xff636363),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 30),
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed('/videotutorial');
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               children: [
              //                 GradientSvgIcon(
              //                   assetName: 'assets/icons/videotutorial.svg',
              //                   size: 20,
              //                   gradient: LinearGradient(
              //                     begin: Alignment.topCenter,
              //                     end: Alignment.bottomCenter,
              //                     colors: [Color(0xffF27129), Color(0xffA3410A)],
              //                   ),
              //                 ),
              //                 SizedBox(width: 10),
              //                 Text(
              //                   'Video Tutorial',
              //                   style: GoogleFonts.montserrat(
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w600,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             SizedBox(height: 10),
              //             Text(
              //               '           Watch Step-by-Step Guides to Resolve Issues',
              //               style: GoogleFonts.montserrat(
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w500,
              //                 color: Color(0xff636363),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
