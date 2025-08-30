import 'dart:math';

import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/khata_book/views/add_Customer.dart';
import 'package:farmitra/app/modules/khata_book/views/customer_detail.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../controllers/khata_book_controller.dart';

class KhataBookView extends GetView<KhataBookController> {
  const KhataBookView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(KhataBookController()); // Single controller initialization
    final Map<String, dynamic>? customerData = Get.arguments;

    if (customerData == null) {
      print("No customer data found!");
    } else {
      print('Added Customer Data $customerData');
    }

    return Scaffold(
      appBar: VendorAppBar(title: 'My Khata'),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildCustomerSection(customerData),
                _buildCustomerSection(customerData),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 150,
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () {
            Get.to(
              () => AddCustomer(),
              arguments: controller.currentTabIndex.value,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.white,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.primaryGradinatMixColor.withOpacity(0.2),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                  SizedBox(width: 5),
                  Obx(
                    () => Flexible(
                      child: Text(
                        controller.currentTabIndex.value == 0
                            ? 'Add Customers'
                            : 'Add Suppliers',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGradinatMixColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            color: AppColors.border,
            offset: Offset(0, 1),
            spreadRadius: 1,
          ),
        ],
      ),
      child: TabBar(
        physics: const NeverScrollableScrollPhysics(),
        isScrollable: false,
        controller: controller.tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.symmetric(
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
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
        unselectedLabelColor: AppColors.textSecondary,
        tabs: const [
          Tab(child: Text('Customers')),
          Tab(child: Text('Suppliers')),
        ],
      ),
    );
  }

  Widget _buildCustomerSection(Map<String, dynamic>? customerData) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: Column(
              children: [
                _buildSummaryCard(),
                const SizedBox(height: 10),
                _buildReportAndWalletRow(),
                const SizedBox(height: 10),
                _buildSearchAndFilterRow(),
                const SizedBox(height: 10),
                _buildCategoryList(),
              ],
            ),
          ),
          _buildDetailList(customerData),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      color: AppColors.yellow.withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  '₹42000',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'You will give',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '₹4567',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'You will get',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  // Add report viewing action
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View Report',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                     Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primaryGradinatMixColor,
                      size: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportAndWalletRow() {
    return Row(
      children: [
        Container(
          width: 135,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.primaryGradinatMixColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Free Report',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Get Your Credit Score',
                      maxLines: 3,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Lottie.asset('assets/json/credit_score.json'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Start Now',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.white,
                    size: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.primaryGradinatMixColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹6750',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_double_arrow_right,
                      color: AppColors.white,
                      size: 15,
                    ),
                  ],
                ),
                Text(
                  'Wallet Balance',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 10),
                CustomGradientButton(
                  height: 35,
                  borderRadius: 5,
                  text: 'Pay Money',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilterRow() {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            prefixIcon:  Icon(
              Icons.search,
              color: AppColors.primaryGradinatMixColor,
            ),
            hintText: 'Search Customer',
            keyboardType: TextInputType.text,
            controller: controller.search,
            validator: (value) => null,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          children: [
             Icon(
              Icons.filter_alt_outlined,
              color: AppColors.primaryGradinatMixColor,
            ),
            const SizedBox(height: 10),
            Text(
              'Filter',
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGradinatMixColor,
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          children: [
             Icon(
              Icons.picture_as_pdf,
              color: AppColors.primaryGradinatMixColor,
            ),
            const SizedBox(height: 10),
            Text(
              'PDF',
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGradinatMixColor,
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          children: [
             Icon(Icons.send, color: AppColors.primaryGradinatMixColor),
            const SizedBox(height: 10),
            Text(
              'Reminder',
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGradinatMixColor,
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: controller.listCategories.length,
        itemBuilder: (context, index) {
          return Obx(
            () => GestureDetector(
              onTap: () => controller.selectCategories(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color:
                        controller.selectedIndex.value == index
                            ? AppColors.primaryGradinatMixColor
                            : AppColors.border,
                  ),
                ),
                child: Text(
                  controller.listCategories[index],
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color:
                        controller.selectedIndex.value == index
                            ? AppColors.primaryGradinatMixColor
                            : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailList(Map<String, dynamic>? data) {
    final random = Random();

    // List of all cards to render
    final List<Map<String, dynamic>> customerList = [];

    // Add argument data at the beginning if available
    if (data != null && data.isNotEmpty) {
      customerList.add(data);
    }

    // Add 2 default dummy cards with date and time
    customerList.addAll([
      {
        'name': 'Shankar Rane',
        'money': 4532,
        'date': '05/05/2025',
        'time': '14:30',
      },
      {
        'name': 'Pooja Mehta',
        'money': 2321,
        'date': '05/05/2025',
        'time': '09:15',
      },
    ]);

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: customerList.length,
      itemBuilder: (context, index) {
        final item = customerList[index];
        final name = item['name'].toString();

        // Generate initials from the first letter of each word
        final words = name.split(' ').where((word) => word.isNotEmpty).toList();
        final initials =
            words.length > 1
                ? '${words[0][0]}${words[1][0]}'
                : words.isNotEmpty
                ? words[0][0]
                : '';
        final displayInitials = initials.toUpperCase();

        // Generate random color
        final randomColor = Color.fromRGBO(
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
          0.2,
        );

        // Use provided date and time, or generate current date and time
        final date =
            item['date'] ??
            "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}";
        final time =
            item['time'] ??
            "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}";
        final dateTime = "$date $time";

        return GestureDetector(
          onTap: () {
            Get.to(() => CustomerDetail(), arguments:item['name'] );
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: randomColor,
                    child: Text(
                      displayInitials,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryGradinatMixColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          dateTime,
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '₹${item['money'] ?? 0}',
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.error,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Reminder',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryGradinatMixColor,
                            ),
                          ),
                           Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryGradinatMixColor,
                            size: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
