import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/Help_Center/views/text_support_view.dart';
import 'package:farmitra/app/modules/Wallet/views/wallet_view.dart';
import 'package:farmitra/app/modules/khata_book/controllers/customer_detail_controller.dart';
import 'package:farmitra/app/modules/khata_book/views/customer_profile.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetail extends StatelessWidget {
  const CustomerDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerDetailController customerDetailController = Get.put(
      CustomerDetailController(),
    );
    final customerName = Get.arguments as String? ?? 'Unknown User';
    final words =
        customerName.split(' ').where((word) => word.isNotEmpty).toList();
    final initials =
        words.length > 1
            ? '${words[0][0]}${words[1][0]}'
            : words.isNotEmpty
            ? words[0][0]
            : '';
    final displayInitials = initials.toUpperCase();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        leadingWidth: 25,
        iconTheme: IconThemeData(color: AppColors.white),
        title: GestureDetector(
          onTap: () {
            Get.to(() => CustomerProfile());
          },
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  ();
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: Text(
                    displayInitials,
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        customerName,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.edit, color: AppColors.green),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Noida Uttar Pradesh 201301',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => TextSupportView());
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.message, color: AppColors.white),
                  ),
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () async {
                  final Uri phoneUri = Uri(scheme: 'tel', path: '9721854225');
                  try {
                    if (await canLaunchUrl(phoneUri)) {
                      await launchUrl(phoneUri);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'No dialer app found. Please install a dialer app.',
                          ),
                        ),
                      );
                      debugPrint('Could not launch dialer');
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error launching dialer: $e')),
                    );
                    debugPrint('Error launching dialer: $e');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.call, color: AppColors.white),
                  ),
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.green.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹4532',
                              style: GoogleFonts.montserrat(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryGradinatMixColor,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_double_arrow_right,
                              color: AppColors.primaryGradinatMixColor,
                            ),
                          ],
                        ),
                        Text(
                          'You Will Get',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryGradinatMixColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomGradientButton(
                                height: 40,
                                borderRadius: 10,
                                text: 'Request Money',
                                onPressed: () {
                                  Get.bottomSheet(buildRequestMoney(context));
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 1,
                              child: CustomGradientButton(
                                height: 40,
                                borderRadius: 10,
                                text: 'Pay',
                                onPressed: () {
                                  Get.to(() => WalletView());
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          borderRadius: 5,
                          hintText: 'Date',
                          keyboardType: TextInputType.none,
                          controller: customerDetailController.date,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Date is required';
                            }
                            return null;
                          },
                          suffixWidget: GestureDetector(
                            onTap:
                                () =>
                                    customerDetailController.pickDate(context),
                            child: const Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
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
                      GestureDetector(
                        onTap: () async {
                          const phoneNumber = '9721854225';
                          const message =
                              'Hello Dear, your due is ₹4532. Pay ASAP.';
                          final encodedMessage = Uri.encodeComponent(message);
                          final uri = Uri.parse(
                            'whatsapp://send?phone=$phoneNumber&text=$encodedMessage',
                          );
                          try {
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              final webUri = Uri.parse(
                                'https://api.whatsapp.com/send?phone=$phoneNumber&text=$encodedMessage',
                              );
                              await launchUrl(
                                webUri,
                                mode: LaunchMode.externalNonBrowserApplication,
                              );
                            }
                          } catch (e) {
                            Get.snackbar(
                              'Error',
                              'Failed to open WhatsApp. Make sure WhatsApp is installed.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.send,
                              color: AppColors.primaryGradinatMixColor,
                            ),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order - 1001',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '02 Apr 2024, 06:10 PM',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'You Will Give',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              '- ₹4532',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            const phoneNumber = '9721854225';
                            const message =
                                'Hello Dear, your due is ₹4532. Pay ASAP.';
                            final encodedMessage = Uri.encodeComponent(message);
                            final uri = Uri.parse(
                              'whatsapp://send?phone=$phoneNumber&text=$encodedMessage',
                            );
                            try {
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(
                                  uri,
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                final webUri = Uri.parse(
                                  'https://api.whatsapp.com/send?phone=$phoneNumber&text=$encodedMessage',
                                );
                                await launchUrl(
                                  webUri,
                                  mode:
                                      LaunchMode.externalNonBrowserApplication,
                                );
                              }
                            } catch (e) {
                              Get.snackbar(
                                'Error',
                                'Failed to open WhatsApp. Make sure WhatsApp is installed.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Reminder',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blue,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => Row(
                children: [
                  Checkbox(
                    activeColor: AppColors.primaryGradinatMixColor,
                    value: customerDetailController.allSelected.value,
                    onChanged: customerDetailController.toggleAll,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'All Transactions',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    customerDetailController.isShowCheckbox.value
                        ? '${customerDetailController.selectedList.length}'
                        : '${customerDetailController.transectionlist.length}',
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => SliverList.builder(
              itemCount: customerDetailController.transectionlist.length,
              itemBuilder: (context, index) {
                try {
                  final item = customerDetailController.transectionlist[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (customerDetailController.isShowCheckbox.value)
                        Checkbox(
                          activeColor: AppColors.primaryGradinatMixColor,
                          value: customerDetailController.selectedList[index],
                          onChanged:
                              (val) => customerDetailController
                                  .toggleIndividual(index, val),
                        ),
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          item['orderid']?.toString() ??
                                              'You Give',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          item['purpose']?.toString() ??
                                              'Purpose',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '- ₹${item['dueAmount']?.toString() ?? '0'}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            item['status'] == 'Pay'
                                                ? AppColors
                                                    .primaryGradinatMixColor
                                                : AppColors.error,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item['date&time']?.toString() ??
                                          'Date not set',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (item['status'] == 'Pay') {
                                          Get.to(() => WalletView());
                                        } else {
                                          const phoneNumber = '9721854225';
                                          final message =
                                              'Hello Dear, your due is ₹${item['dueAmount']?.toString() ?? '0'}. Pay ASAP.';
                                          final encodedMessage =
                                              Uri.encodeComponent(message);
                                          final uri = Uri.parse(
                                            'whatsapp://send?phone=$phoneNumber&text=$encodedMessage',
                                          );
                                          try {
                                            if (await canLaunchUrl(uri)) {
                                              await launchUrl(
                                                uri,
                                                mode:
                                                    LaunchMode
                                                        .externalApplication,
                                              );
                                            } else {
                                              final webUri = Uri.parse(
                                                'https://api.whatsapp.com/send?phone=$phoneNumber&text=$encodedMessage',
                                              );
                                              await launchUrl(
                                                webUri,
                                                mode:
                                                    LaunchMode
                                                        .externalNonBrowserApplication,
                                              );
                                            }
                                          } catch (e) {
                                            Get.snackbar(
                                              'Error',
                                              'Failed to open WhatsApp. Make sure WhatsApp is installed.',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                            );
                                          }
                                        }
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            item['status']?.toString() ??
                                                'Reminder',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.blue,
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } catch (e) {
                  print('Error rendering transaction at index $index: $e');
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: CustomGradientButton(
                gradientColors: [AppColors.error, AppColors.error],
                text: 'You Give',
                onPressed: () {
                  Get.bottomSheet(buildyouGive());
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomGradientButton(
                text: 'You Receive',
                onPressed: () {
                  Get.bottomSheet(buildyouReceive());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildRequestMoney(BuildContext context) {
  final CustomerDetailController customerDetailController = Get.find();
  return SingleChildScrollView(
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Request Money',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryGradinatMixColor,
              ),
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              hintText: 'Enter Request Amount',
              keyboardType: TextInputType.number,
              controller: customerDetailController.requestMoney,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Amount is required';
                }
                if (double.tryParse(value) == null) {
                  return 'Enter a valid number';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'Select Date',
              keyboardType: TextInputType.none,
              controller: customerDetailController.requestMoneydate,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Date is required';
                }
                return null;
              },
              suffixWidget: GestureDetector(
                onTap:
                    () =>
                        customerDetailController.pickRequestMoneyDate(context),
                child: Icon(Icons.calendar_month_outlined),
              ),
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'Enter Purpose',
              keyboardType: TextInputType.text,
              controller: customerDetailController.purpose,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Purpose is required';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            CustomGradientButton(
              text: 'Submit',
              onPressed: () {
                customerDetailController.addTransection();
                Get.back();
                ();
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}

Widget buildyouGive() {
  final CustomerDetailController customerDetailController = Get.put(
    CustomerDetailController(),
  );
  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Give Money',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryGradinatMixColor,
            ),
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Enter Giving Amount',
            keyboardType: TextInputType.number,
            controller: customerDetailController.giveAmount,
            validator: (p0) {},
            inputFormatters: [LengthLimitingTextInputFormatter(5)],
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Enter Giving Purpose',
            keyboardType: TextInputType.number,
            controller: customerDetailController.givepurpose,
            validator: (p0) {},
            inputFormatters: [LengthLimitingTextInputFormatter(5)],
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Enter Giving Date',
            keyboardType: TextInputType.number,
            controller: customerDetailController.givedate,
            validator: (p0) {},
            inputFormatters: [LengthLimitingTextInputFormatter(5)],
          ),
          SizedBox(height: 10),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  activeColor: AppColors.primaryGradinatMixColor,

                  value: 'Cash',
                  groupValue: customerDetailController.selectedMethod.value,
                  onChanged: (value) {
                    customerDetailController.selectedMethod.value = value!;
                  },
                ),
                Text('Cash'),
                SizedBox(width: 35),

                Radio<String>(
                  activeColor: AppColors.primaryGradinatMixColor,
                  value: 'Online',
                  groupValue: customerDetailController.selectedMethod.value,
                  onChanged: (value) {
                    customerDetailController.selectedMethod.value = value!;
                  },
                ),
                Text('Online'),
              ],
            ),
          ),
          SizedBox(height: 10),
          CustomGradientButton(text: 'Submit & Pay ', onPressed: () {}),
        ],
      ),
    ),
  );
}

Widget buildyouReceive() {
  final CustomerDetailController customerDetailController = Get.put(
    CustomerDetailController(),
  );
  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Give Receive',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryGradinatMixColor,
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 0.1,
                  color: Colors.grey,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: ExpansionTile(
              shape: Border.all(color: Colors.transparent),
              iconColor: AppColors.primaryGradinatMixColor,
              internalAddSemanticForOnTap: true,
              children: [
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(height: 2.5),
                          Row(
                            children: [
                              Text(
                                'orderid - #987532',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '₹400',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Obx(
                                () => Checkbox(
                                  activeColor:
                                      AppColors.primaryGradinatMixColor,
                                  value:
                                      customerDetailController
                                          .checkBoxList[index]
                                          .value,
                                  onChanged:
                                      (value) => customerDetailController
                                          .toggleCheckbox(index, value!),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Previous Dues (2-Orders)',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '+₹800',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Net Amount Receive:',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: '  Enter Amount',
            keyboardType: TextInputType.text,
            controller: customerDetailController.totalBillAmount,
            validator: (p0) {},
            suffixIcon: Icons.cancel_outlined,
            onChanged: (value) {
              customerDetailController.updateRemainingAmount(value);
            },
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => Text(
                  'Remaining Amount: ₹ ${customerDetailController.remainingAmount.value}',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Enter Receiving Amount',
            keyboardType: TextInputType.number,
            controller: customerDetailController.giveAmount,
            validator: (p0) {},
            inputFormatters: [LengthLimitingTextInputFormatter(5)],
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Enter Receiving Purpose',
            keyboardType: TextInputType.number,
            controller: customerDetailController.givepurpose,
            validator: (p0) {},
            inputFormatters: [LengthLimitingTextInputFormatter(5)],
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Enter Receiving Date',
            keyboardType: TextInputType.number,
            controller: customerDetailController.givedate,
            validator: (p0) {},
            inputFormatters: [LengthLimitingTextInputFormatter(5)],
          ),
          SizedBox(height: 10),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  activeColor: AppColors.primaryGradinatMixColor,

                  value: 'Cash',
                  groupValue: customerDetailController.selectedMethod.value,
                  onChanged: (value) {
                    customerDetailController.selectedMethod.value = value!;
                  },
                ),
                Text('Cash'),
                SizedBox(width: 35),

                Radio<String>(
                  activeColor: AppColors.primaryGradinatMixColor,
                  value: 'Online',
                  groupValue: customerDetailController.selectedMethod.value,
                  onChanged: (value) {
                    customerDetailController.selectedMethod.value = value!;
                  },
                ),
                Text('Online'),
              ],
            ),
          ),
          SizedBox(height: 10),
          CustomGradientButton(text: 'Submit & Pay ', onPressed: () {}),
        ],
      ),
    ),
  );
}
