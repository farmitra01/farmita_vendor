import 'dart:math';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/first_med_controller.dart';
import 'package:farmitra/app/modules/home/views/med_order_details.dart';
import 'package:farmitra/app/modules/home/views/order_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstMedOrder extends StatelessWidget {
  FirstMedOrder({super.key});
  final FirstMedController firstMedController = Get.put(FirstMedController());
  final prescriptionCount = 15.obs; // Observable variable
  final normalCount = 15.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'JP Provisional Store',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Grocery | Stationary',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ],
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
      // VendorAppBar(
      //   title: "Order History",
      //   actions: [
      //     Container(
      //       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(18),
      //         border: Border.all(color: Colors.white),
      //       ),
      //       child: Row(
      //         children: [
      //           SvgPicture.asset(
      //             'assets/svgs/download_report.svg',
      //             height: 15,
      //             color: Colors.white,
      //           ),
      //           SizedBox(width: 10),
      //           Text(
      //             'Download Report',
      //             style: GoogleFonts.montserrat(
      //               fontSize: 12,
      //               fontWeight: FontWeight.w500,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     SizedBox(width: 15),
      //   ],
      // ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'All Orders',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(OrderHistory());
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: AppColors.textSecondary,
                        size: 25,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'History',
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
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  color: AppColors.containerShadowColor,
                  offset: Offset(0, 1),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: TabBar(
              physics: NeverScrollableScrollPhysics(),
              isScrollable: false,
              controller: firstMedController.tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              dividerHeight: 0,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColors.primaryGradinatMixColor,
              ),
              labelColor: Colors.white,
              labelStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              unselectedLabelColor: AppColors.textSecondary,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_convenience_store_outlined, size: 20),
                      SizedBox(width: 5),
                      Text('Online'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pin_drop_outlined, size: 20),
                      SizedBox(width: 5),
                      Text('Offline'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: firstMedController.tabController,
              children: [_buildOnlineTabContent(), _buildOfflineTabContent()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineTabContent() {
    final FirstMedController firstMedController = Get.put(FirstMedController());
    return Column(
      children: [
        // SizedBox(
        //   height: 100,
        //   child:
        //   ListView.builder(
        //     padding: EdgeInsets.symmetric(vertical: 10),
        //     itemCount: 2,
        //     scrollDirection: Axis.horizontal,
        //     itemBuilder: (context, index) {
        //       return
        //     },
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      firstMedController.isPrescriptionTapped.value =
                          !firstMedController.isPrescriptionTapped.value;
                      firstMedController.isNormalTapped.value = false;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              firstMedController.isPrescriptionTapped.value
                                  ? AppColors.primaryGradinatMixColor
                                  : Colors.transparent, // Toggle border color
                        ),
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            color: AppColors.containerShadowColor,
                            offset: Offset(0, 1),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/Package.svg',
                                height: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                prescriptionCount.value.toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Prescription Orders',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color:
                                  firstMedController
                                              .isPrescriptionTapped
                                              .value ==
                                          true
                                      ? AppColors.primaryGradinatMixColor
                                      : AppColors.textPrimary,
                            ),
                          ),
                          // Text(
                          //     '${firstMedController.isPrescriptionTapped.value}')
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      firstMedController.isNormalTapped.value =
                          !firstMedController.isNormalTapped.value;
                      firstMedController.isPrescriptionTapped.value = false;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              firstMedController.isNormalTapped.value
                                  ? AppColors.primaryGradinatMixColor
                                  : Colors.transparent, // Toggle border color
                        ),
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            color: AppColors.containerShadowColor,
                            offset: Offset(0, 1),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/Package.svg',
                                height: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                normalCount.value.toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Normal Orders',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color:
                                  firstMedController.isNormalTapped.value
                                      ? AppColors.primaryGradinatMixColor
                                      : AppColors.textPrimary,
                            ),
                          ),
                          // Text('${firstMedController.isNormalTapped.value}')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: AppColors.containerShadowColor,
                offset: Offset(0, 1),
                spreadRadius: 1,
              ),
            ],
          ),
          child: TabBar(
            isScrollable: false,
            physics: NeverScrollableScrollPhysics(),
            controller: firstMedController.fourTabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            dividerHeight: 0,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AppColors.primaryGradinatMixColor,
            ),
            labelColor: Colors.white,
            labelStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelColor: AppColors.textSecondary,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Preparing'),
              Tab(text: 'Packed'),
              Tab(text: ' Delivery'),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: firstMedController.fourTabController,
            children: [
              pendingTabContent(),
              preparingTabContent(),
              packedTabContent(),
              outForDelieveryTabContent(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOfflineTabContent() {
    return Column(
      children: [
        // SizedBox(
        //   height: 110,
        //   child: ListView.builder(
        //     padding: EdgeInsets.symmetric(vertical: 10),
        //     itemCount: 3,
        //     scrollDirection: Axis.horizontal,
        //     itemBuilder: (context, index) {
        //       return Container(
        //         padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        //         margin: EdgeInsets.only(left: 20),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: Colors.white,
        //           boxShadow: [
        //             BoxShadow(
        //               blurRadius: 1,
        //               color: Colors.grey,
        //               offset: Offset(0, 1),
        //               spreadRadius: 1,
        //             ),
        //           ],
        //         ),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Row(
        //               children: [
        //                 SvgPicture.asset('assets/svgs/Package.svg', height: 20),
        //                 SizedBox(width: 10),
        //                 Text(
        //                   '15',
        //                   style: GoogleFonts.montserrat(
        //                     fontSize: 14,
        //                     fontWeight: FontWeight.w700,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             SizedBox(height: 10),
        //             Text(
        //               'Today',
        //               style: GoogleFonts.montserrat(
        //                 fontSize: 12,
        //                 fontWeight: FontWeight.w500,
        //                 color: Color(0xff636363),
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: AppColors.containerShadowColor,
                offset: Offset(0, 1),
                spreadRadius: 1,
              ),
            ],
          ),
          child: TabBar(
            isScrollable: false,
            physics: NeverScrollableScrollPhysics(),
            controller: firstMedController.threeController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            dividerHeight: 0,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AppColors.primaryGradinatMixColor,
            ),
            labelColor: AppColors.white,
            labelStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelColor: AppColors.textSecondary,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Delivered'),
              Tab(text: 'Pick Up'),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: firstMedController.threeController,
            children: [
              allTabContent(),
              deliverdTabContent(),
              pickUpTabContent(),
            ],
          ),
        ),
      ],
    );
  }
}

Widget pendingTabContent() {
  final FirstMedController firstMedController = Get.put(FirstMedController());
  // print('${firstMedController.isPrescriptionTapped.value}');
  // var isPrescriptionOrder = firstMedController.isPrescriptionTapped.value.obs;
  // var isNormalOrder = firstMedController.isNormalTapped.value.obs;
  return ListView.builder(
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            if (firstMedController.isPrescriptionTapped.value ||
                firstMedController.isNormalTapped.value) {
              Get.to(() => MedOrderDetails());
            } else {
              Get.snackbar(
                'Notice',
                'Please Select Order type',
                backgroundColor: AppColors.primaryGradinatMixColor,
                colorText: AppColors.white,
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Obx(() => Text('Prescription order = ${isPrescriptionOrder}')),
              // Obx(() => Text('Normal order = ${isNormalOrder}')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Order ID: ',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        TextSpan(
                          text: '#10062',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '3 ',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                            // TextSpan(),
                            TextSpan(
                              text: 'Item ',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '29 Sept 2022  04:55 Pm',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffFFDEDE),
                    ),
                    child: Text(
                      'Pending',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffDB5050),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Delievery',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              Container(height: sqrt2, color: Color(0xffDADADA)),
            ],
          ),
        ),
      );
    },
  );
}

Widget preparingTabContent() {
  // final
  return ListView.builder(
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Get.to(MedOrderDetails());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Order ID: ',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        TextSpan(
                          text: '#10062',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '3 ',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                            // TextSpan(),
                            TextSpan(
                              text: 'Item ',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '29 Sept 2022  04:55 Pm',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffFFDEDE),
                    ),
                    child: Text(
                      'Pending',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffDB5050),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Delievery',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(height: sqrt2, color: AppColors.border),
            ],
          ),
        ),
      );
    },
  );
}

Widget packedTabContent() {
  return ListView.builder(
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Get.to(MedOrderDetails());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Order ID: ',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff060505),
                          ),
                        ),
                        TextSpan(
                          text: '#10062',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff060505),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '3 ',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff060505),
                              ),
                            ),
                            // TextSpan(),
                            TextSpan(
                              text: 'Item ',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff060505),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '29 Sept 2022  04:55 Pm',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff636363),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffFFDEDE),
                    ),
                    child: Text(
                      'Pending',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffDB5050),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Delievery',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(height: sqrt2, color: Color(0xffDADADA)),
            ],
          ),
        ),
      );
    },
  );
}

Widget outForDelieveryTabContent() {
  return ListView.builder(
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Get.to(MedOrderDetails());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Order ID: ',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff060505),
                          ),
                        ),
                        TextSpan(
                          text: '#10062',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff060505),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Spacer(),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(15),
                  //     border:
                  //         Border.all(color: AppColors.primaryGradinatMixColor),
                  //   ),
                  //   child: Text(
                  //     'Out for Delievery',
                  //     style: GoogleFonts.montserrat(
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.w500,
                  //         color: AppColors.primaryGradinatMixColor),
                  //   ),
                  // ),
                  // Spacer(),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '3 ',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff060505),
                              ),
                            ),
                            // TextSpan(),
                            TextSpan(
                              text: 'Item ',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff060505),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '29 Sept 2022  04:55 Pm',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff636363),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffFFDEDE),
                    ),
                    child: Text(
                      'Pending',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffDB5050),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Delievery',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              Container(height: sqrt2, color: Color(0xffDADADA)),
            ],
          ),
        ),
      );
    },
  );
}

Widget allTabContent() {
  return ListView.builder(
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Get.to(MedOrderDetails());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Order ID: ',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff060505),
                          ),
                        ),
                        TextSpan(
                          text: '#10062',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff060505),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                    child: Text(
                      'Delivered',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '3 ',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff060505),
                              ),
                            ),
                            // TextSpan(),
                            TextSpan(
                              text: 'Item ',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff060505),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 15),
                    ],
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Text(
                '29 Sept 2022  04:55 Pm',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff636363),
                ),
              ),
              SizedBox(height: 10),
              Container(height: sqrt2, color: Color(0xffDADADA)),
            ],
          ),
        ),
      );
    },
  );
}

Widget deliverdTabContent() {
  return ListView.builder(
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Order ID: ',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff060505),
                        ),
                      ),
                      TextSpan(
                        text: '#10062',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff060505),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '3',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff060505),
                        ),
                      ),
                      TextSpan(),
                      TextSpan(
                        text: 'Item',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff060505),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 15),
              ],
            ),
            SizedBox(height: 10),
            Text(
              '29 Sept 2022  04:55 Pm',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff636363),
              ),
            ),
            SizedBox(height: 10),
            Container(height: sqrt2, color: Color(0xffDADADA)),
          ],
        ),
      );
    },
  );
}

Widget pickUpTabContent() {
  return ListView.builder(
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Order ID: ',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff060505),
                        ),
                      ),
                      TextSpan(
                        text: '#10062',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff060505),
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '3',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff060505),
                        ),
                      ),
                      TextSpan(),
                      TextSpan(
                        text: 'Item',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff060505),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              '29 Sept 2022  04:55 Pm',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff636363),
              ),
            ),
            SizedBox(height: 10),
            Container(height: sqrt2, color: Color(0xffDADADA)),
          ],
        ),
      );
    },
  );
}
