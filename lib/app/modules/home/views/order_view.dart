import 'dart:math';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/order_controller.dart';
import 'package:farmitra/app/modules/home/views/order_details.dart';
import 'package:farmitra/app/modules/home/views/order_history.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderView extends GetView {
  OrderView({super.key});
  final OrderController _orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
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
              border: Border.all(color: AppColors.border),
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
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(Icons.notifications_outlined, color: AppColors.white),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.containerShadowColor,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
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
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: TabBar(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _orderController.tabController,
                    dividerHeight: 00,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
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
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_convenience_store_outlined,
                              size: 20,
                            ),
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
                // SizedBox(height: 6),
                SizedBox(
                  height: 500,
                  child: TabBarView(
                    controller: _orderController.tabController,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 6),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(5),
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
                              isScrollable: true,
                              controller: _orderController.orderStatus,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorPadding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 5,
                              ),
                              dividerHeight: 0,
                              tabAlignment: TabAlignment.start,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.primaryGradinatMixColor,
                              ),
                              labelColor: AppColors.white,
                              labelStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                              unselectedLabelColor: AppColors.textSecondary,
                              tabs: [
                                Tab(text: 'Pending'),
                                Tab(text: 'Preparing'),
                                Tab(text: 'Packed'),
                                Tab(text: 'Out for Delivery '),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: TabBarView(
                              controller: _orderController.orderStatus,
                              children: [
                                buildPendingTabBar(),
                                buildPendingTabBar(),
                                buildPendingTabBar(),
                                buildPendingTabBar(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: 6),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(5),
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
                              isScrollable: true,
                              controller: _orderController.orderStatus,
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabAlignment: TabAlignment.start,
                              indicatorPadding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 5,
                              ),
                              dividerHeight: 0,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.primaryGradinatMixColor,
                              ),
                              labelColor: AppColors.white,
                              labelStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                              unselectedLabelColor: AppColors.textSecondary,
                              tabs: [
                                Tab(text: 'Pending'),
                                Tab(text: 'Preparing'),
                                Tab(text: 'Packed'),
                                Tab(text: 'Out for Delivery '),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: TabBarView(
                              controller: _orderController.orderStatus,
                              children: [
                                buildPendingTabBar(),
                                buildPendingTabBar(),
                                buildPendingTabBar(),
                                buildPendingTabBar(),
                              ],
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
        ),
      ),
    );
  }
}

Widget buildPendingTabBar() {
  return ListView.builder(
    shrinkWrap: true,
    // physics: NeverScrollableScrollPhysics(),
    itemCount: 10,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Get.to(OrderDetails());
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
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
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextSpan(
                          text: '#10062',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
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
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextSpan(),
                        TextSpan(
                          text: 'Item',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '29 Sept 2022  04:55 Pm',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.background,
                    ),
                    child: Text(
                      'Pending',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                  // Spacer();
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

Widget buildOfflinePendingTabBar() {
  return ListView.builder(
    shrinkWrap: true,
    // physics: NeverScrollableScrollPhysics(),
    itemCount: 10,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
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
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextSpan(
                        text: '#10062',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
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
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextSpan(),
                      TextSpan(
                        text: 'Item',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  '29 Sept 2022  04:55 Pm',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(width: 10),
                Text("|"),
                SizedBox(width: 10),
                Text(
                  'Delievery',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(height: sqrt2, color: AppColors.border),
          ],
        ),
      );
    },
  );
}
