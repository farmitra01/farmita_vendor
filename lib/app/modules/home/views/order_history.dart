import 'dart:ffi';
import 'dart:math';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/order_history_cotroller.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistory extends StatelessWidget {
  OrderHistory({super.key});
  final OrderHistory_Controller _orderHistoryController = Get.put(
    OrderHistory_Controller(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: VendorAppBar(
        title: "Order History",
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svgs/download_report.svg',
                  height: 15,
                  color: AppColors.white,
                ),
                SizedBox(width: 10),
                Text(
                  'Download Report',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  color: AppColors.border,
                  offset: Offset(0, 1),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: TabBar(
              physics: NeverScrollableScrollPhysics(),
              isScrollable: false,
              controller: _orderHistoryController.tabController,
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
              controller: _orderHistoryController.tabController,
              children: [_buildOnlineTabContent(), _buildOfflineTabContent()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineTabContent() {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: AppColors.border,
                      offset: Offset(0, 1),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/svgs/Package.svg', height: 20),
                        SizedBox(width: 10),
                        Text(
                          '15',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Today',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            },
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
                color: AppColors.border,
                offset: Offset(0, 1),
                spreadRadius: 1,
              ),
            ],
          ),
          child: TabBar(
            isScrollable: false,
            physics: NeverScrollableScrollPhysics(),
            controller: _orderHistoryController.threeTabController,
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
              Tab(text: 'Refunded'),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _orderHistoryController.threeTabController,
            children: [
              allTabContent(),
              deliverdTabContent(),
              refundedTabContent(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOfflineTabContent() {
    return Column(
      children: [
        SizedBox(
          height: 110,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: AppColors.border,
                      offset: Offset(0, 1),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/svgs/Package.svg', height: 20),
                        SizedBox(width: 10),
                        Text(
                          '15',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Today',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: AppColors.border,
                offset: Offset(0, 1),
                spreadRadius: 1,
              ),
            ],
          ),
          child: TabBar(
            isScrollable: false,
            physics: NeverScrollableScrollPhysics(),
            controller: _orderHistoryController.threeTabController,
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
              Tab(text: 'All'),
              Tab(text: 'Delivered'),
              Tab(text: 'Refunded'),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _orderHistoryController.threeTabController,
            children: [
              allTabContent(),
              deliverdTabContent(),
              refundedTabContent(),
            ],
          ),
        ),
      ],
    );
  }
}

Widget allTabContent() {
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
            Text(
              '29 Sept 2022  04:55 Pm',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 10),
            Container(height: sqrt2, color: AppColors.border),
          ],
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
            Text(
              '29 Sept 2022  04:55 Pm',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 10),
            Container(height: sqrt2, color: AppColors.border),
          ],
        ),
      );
    },
  );
}

Widget refundedTabContent() {
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
            Text(
              '29 Sept 2022  04:55 Pm',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 10),
            Container(height: sqrt2, color: AppColors.border),
          ],
        ),
      );
    },
  );
}
