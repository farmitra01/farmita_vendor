import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/controllers/pos_checkout_controller.dart';
import 'package:farmitra/app/modules/home/controllers/first_med_controller.dart';
import 'package:farmitra/app/modules/home/controllers/med_order_details_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_rectangle_painter.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class MedOrderDetails extends StatelessWidget {
  MedOrderDetails({super.key});

  final MedOrderDetailsController medOrderDetailsController = Get.put(
    MedOrderDetailsController(),
  );
  final List<dynamic> args = Get.arguments ?? [false, false];
  final FirstMedController firstMedController = Get.put(FirstMedController());
  final PosCheckoutController posCheckoutController = Get.put(
    PosCheckoutController(),
  );
  @override
  Widget build(BuildContext context) {
    print('${args}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
                ();
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.appBarColor),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              CustomOutlinedButton(
                icon: Icons.print_sharp,
                text: "Print",
                textStyle: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                onPressed: () {},
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.white),
                ),
              ),
              const SizedBox(width: 5),
              CustomOutlinedButton(
                icon: Icons.share,
                text: "Share",
                textStyle: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                onPressed: () async {
                  const url = 'Shared link will be Here';
                  await Share.share('$url');
                },
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.more_vert, color: AppColors.white),
              const SizedBox(width: 10),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize:
                  MainAxisSize.min, // Added to avoid layout constraint issues
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Order ID: ',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      TextSpan(
                        text: '#10060',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '29 Sept 2022  04:55 PM | Delivery',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryFirstGradiant,
                            AppColors.primarySecondGradiant,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "New Order",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer Details',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Stack(
                children: [
                  Obx(
                    () => CustomPaint(
                      size: Size(
                        350,
                        medOrderDetailsController.isExpanded.value == true
                            ? 335
                            : 150,
                      ),
                      painter: CustomRectanglePainter(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Track Customer',
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '10 to 15 min away',
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 5),
                            GradientSvgIcon(
                              icon: Icon(Icons.open_in_new),
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
                          ],
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: AppColors.border),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/user.jpg'),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Customer Name...',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Online Payment',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '+91 88022 04049',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Obx(() {
                                        return medOrderDetailsController
                                                    .isExpanded
                                                    .value ==
                                                false
                                            ? Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 2.5,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: AppColors.border,
                                              ),
                                              child: Text(
                                                'Paid',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.green,
                                                ),
                                              ),
                                            )
                                            : SizedBox();
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Obx(() {
                          return medOrderDetailsController.isExpanded.value ==
                                  true
                              ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    medOrderDetailsController
                                        .customerDetails
                                        .length,
                                itemBuilder: (context, index) {
                                  final item =
                                      medOrderDetailsController
                                          .customerDetails[index];
                                  bool isOnline =
                                      item["data"] == "Paid"; // Check if "Paid"

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          item["title"] + ":",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Expanded(
                                          // Wrap this to avoid overflow
                                          child: Align(
                                            alignment:
                                                Alignment
                                                    .centerRight, // Aligns text to the right
                                            child:
                                                isOnline
                                                    ? Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 2.5,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors
                                                                .background, // Background color
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ), // Rounded corners
                                                      ),
                                                      child: Text(
                                                        item["data"],
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                0xff02B93B,
                                                              ), // Text color
                                                            ),
                                                      ),
                                                    )
                                                    : Text(
                                                      item["data"],
                                                      style:
                                                          GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                    ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                              : SizedBox();
                        }),
                        SizedBox(height: 10),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 35,
                              child: GradientOutlinedButton(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.primaryFirstGradiant,
                                    AppColors.primarySecondGradiant,
                                  ],
                                ),
                                customChild: GradientSvgIcon(
                                  icon: Icon(Icons.chat),
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
                                onPressed: () {
                                  Get.toNamed('/help-center');
                                },
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                              child: GradientOutlinedButton(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.primaryFirstGradiant,
                                    AppColors.primarySecondGradiant,
                                  ],
                                ),
                                customChild: GradientSvgIcon(
                                  icon: Icon(Icons.call),
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
                                onPressed: () {
                                  medOrderDetailsController.launchDialPad(
                                    "8737099712",
                                  );
                                },
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            // SizedBox(width: 20,),
                            Obx(
                              () => TextButton(
                                onPressed: () {
                                  medOrderDetailsController.isExpanded.value =
                                      !medOrderDetailsController
                                          .isExpanded
                                          .value;
                                },
                                child: Text(
                                  medOrderDetailsController.isExpanded.value
                                      ? 'View Less Details'
                                      : 'View More Detalis',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Instruction From Customer Side',
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.check, size: 10),
                              Text('  First Two Medicines for 10 day'),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.check, size: 10),
                              Text('  cyrup Will be in med size'),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.check, size: 10),
                              Text('  I want just two Enjection '),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                            title: 'Sample',
                            titlePadding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                              bottom: 0,
                            ),
                            titleStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: AppColors.primaryFirstGradiant,
                            ),
                            content: Image.asset(
                              'assets/images/kyc/pan-card.webp',
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        child: Container(
                          height: 120,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.border),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/kyc/pan-card.webp',
                              ),
                              fit: BoxFit.fill,
                              opacity: 0.2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.visibility),
                              Text(
                                'View Sample',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                ' Product Details',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.background,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: AppColors.containerShadowColor,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          margin: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage('assets/images/perfume.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Park Avenue Men Classic Deo Good Morning',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '₹270 x 2 ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' 150 ML',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Tracking ID: SKU 36336889',
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
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  color: AppColors.background,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: AppColors.containerShadowColor,
                      offset: Offset(0, 1),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    GradientSvgIcon(
                      assetName: 'assets/svgs/gift_bw.svg',
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
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order as a gift',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Text(
                          'Customer added message card for recipient.',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gift Message',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    DottedBorder(
                      color: AppColors.border, // Color of the dotted border
                      dashPattern: [3, 3], // Dash and gap lengths
                      borderType: BorderType.RRect, // Rounded rectangle border
                      radius: Radius.circular(12), // Border radius
                      strokeWidth: 1.5, // Thickness of the border
                      child: Padding(
                        padding: const EdgeInsets.all(
                          8.0,
                        ), // Padding inside the border
                        child: TextFormField(
                          minLines: 4, // Minimum height of the TextFormField
                          maxLines: null, // Allows multiline input
                          decoration: InputDecoration(
                            hintText:
                                'Enter your willng text here...', // Placeholder text
                            border:
                                InputBorder.none, // Removes the default border
                            contentPadding: EdgeInsets.all(
                              12,
                            ), // Padding inside the TextFormField
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Form',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    DottedBorder(
                      color: AppColors.border,
                      dashPattern: [3, 3],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(25),
                      strokeWidth: 1.5,
                      child: TextFormField(
                        minLines: 1,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Enter name...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Bill Details',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.background,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: AppColors.containerShadowColor,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: medOrderDetailsController.priceDetails.length,
                      itemBuilder: (context, index) {
                        final item =
                            medOrderDetailsController.priceDetails[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: [
                              Text(
                                item["title"],
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              if (item.containsKey("isStrikethrough")) ...[
                                Text(
                                  item["price"],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  item["discountedPrice"],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ] else
                                Text(
                                  item["price"],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        item["color"] ??
                                        AppColors.textSecondary,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "To Pay ",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "₹520",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGradinatMixColor.withOpacity(
                          0.2,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/total_saving_bg.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 30,
                        ),
                        child: SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Customer's total saving",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "₹520",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Delivery fee saving of ₹ included",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Order Progress / Status',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: AppColors.containerShadowColor,
                      offset: Offset(0, 1),
                      spreadRadius: 1.5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      GradientText(
                        text: " Timeline",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
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
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: medOrderDetailsController.stepDetails.length,
                        itemBuilder: (context, index) {
                          final step =
                              medOrderDetailsController.stepDetails[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Step Icon and Divider
                              Column(
                                children: [
                                  // Step Icon
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            index ==
                                                    medOrderDetailsController
                                                            .stepDetails
                                                            .length -
                                                        1
                                                ? AppColors.white
                                                : AppColors.border,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          index ==
                                                  medOrderDetailsController
                                                          .stepDetails
                                                          .length -
                                                      1
                                              ? AppColors.lightGrey
                                              : AppColors.white,
                                      child: GradientSvgIcon(
                                        icon: Icon(
                                          medOrderDetailsController
                                              .stepDetails[index]
                                              .icon,
                                        ),
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
                                    ),
                                  ),
                                  // Vertical Divider
                                  if (index !=
                                      medOrderDetailsController
                                              .stepDetails
                                              .length -
                                          1)
                                    Dash(
                                      direction:
                                          Axis.vertical, // For a vertical dotted line
                                      length: 40, // Height of the line
                                      dashLength: 4, // Length of each dash
                                      dashThickness:
                                          2, // Thickness of the dashes
                                      dashColor:
                                          AppColors
                                              .border, // Color of the dashes
                                    ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              // Title and Time
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      medOrderDetailsController
                                          .stepDetails[index]
                                          .text,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      medOrderDetailsController
                                          .stepDetails[index]
                                          .time,
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GradientSvgIcon(
                                icon: Icon(Icons.verified),
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
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              DottedBorder(
                borderType: BorderType.RRect,
                dashPattern: [3, 3],
                color: AppColors.border,
                radius: Radius.circular(20),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prepared by:',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Subham Rawat',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Show the bottom sheet with the slider button
            // Get.bottomSheet(
            //   SliderButtonSheet(),
            //   isScrollControlled: true,
            //   backgroundColor: Colors.white,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.vertical(
            //       top: Radius.circular(20),
            //     ),
            //   ),
            // );
            // CustomGradientButton(
            //   icon: Icons.check_circle_outline,
            //   text: "Accept Order",
            //   onPressed: () {
            //     Get.to(PosView());

            //     medOrderDetailsController.isOrderAccepted.value =
            //         !medOrderDetailsController
            //             .isOrderAccepted.value;
            //     Get.dialog(buildAlertBox());
            //   },
            // ),
            Obx(
              () => Center(
                child:
                    medOrderDetailsController.isOrderAccepted.value == false
                        ? CustomGradientButton(
                          icon: Icons.check_circle_outline,
                          text: "Accept Order",
                          onPressed: () {
                            // Toggle the value of isOrderAccepted
                            if (posCheckoutController.isChanged.value ==
                                false) {
                              medOrderDetailsController.isOrderAccepted.value =
                                  !medOrderDetailsController
                                      .isOrderAccepted
                                      .value;
                            }

                            // Get.dialog(buildAlertBox());
                          },
                        )
                        : medOrderDetailsController.isOrderAccepted.value ==
                            true
                        ? SliderButtonSheet()
                        : posCheckoutController.isChanged.value == true
                        ? SliderButtonSheet()
                        : null, // Display SliderButtonSheet when order is accepted
              ),
            ),

            // SizedBox(height: 20), // Spacing between the button and text
            Center(
              child: TextButton(
                onPressed: () {
                  Get.dialog(buildAlertBox());
                },
                child: Text(
                  "Reject Order",
                  style: TextStyle(color: AppColors.error, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliderButtonSheet extends StatelessWidget {
  final MedOrderDetailsController medOrderDetailsController = Get.put(
    MedOrderDetailsController(),
  );
  final FirstMedController firstMedController = Get.put(FirstMedController());
  final PosCheckoutController posCheckoutController = Get.put(
    PosCheckoutController(),
  );
  final List<dynamic> args = Get.arguments ?? [];
  String displayText = '';

  @override
  Widget build(BuildContext context) {
    print('args${args}');
    LinearGradient? getButtonGradient(
      PosCheckoutController posCheckoutController,
      MedOrderDetailsController medOrderDetailsController,
    ) {
      if (posCheckoutController.isChanged.value &&
          medOrderDetailsController.buttonPosition.value >= 12) {
        return LinearGradient(colors: [AppColors.white, AppColors.white]);
      } else if (medOrderDetailsController.buttonPosition.value < 12 ||
          posCheckoutController.isChanged.value) {
        return LinearGradient(
          colors: [
            AppColors.primaryFirstGradiant,
            AppColors.primarySecondGradiant,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      } else if (medOrderDetailsController.buttonPosition.value < 12) {
        return LinearGradient(colors: [AppColors.white, AppColors.white]);
      }
      return null;
    }

    String getButtonText(
      PosCheckoutController posCheckoutController,
      MedOrderDetailsController medOrderDetailsController,
      FirstMedController firstMedController,
    ) {
      if (medOrderDetailsController.isOrderAccepted.value &&
          !posCheckoutController.isChanged.value &&
          !firstMedController.isNormalTapped.value) {
        return 'Add Medicines';
      } else if (firstMedController.isNormalTapped.value) {
        return 'Ready To Deliever';
      } else if (posCheckoutController.isChanged.value &&
          medOrderDetailsController.buttonPosition.value < 12 &&
          !medOrderDetailsController.isAssigDelieveryPartner.value &&
          !medOrderDetailsController.isPreparingOrder.value) {
        return 'Send info to Customer';
      } else if (medOrderDetailsController.buttonPosition.value > 12 &&
          !medOrderDetailsController.isWaiting.value &&
          !medOrderDetailsController.isPreparingOrder.value) {
        return 'Sending info to Customer';
      } else if (medOrderDetailsController.isWaiting.value) {
        return 'Waiting for Approval';
      } else if (medOrderDetailsController.isAssigDelieveryPartner.value &&
          medOrderDetailsController.buttonPosition.value < 12) {
        return 'Order Approved \n Start Preparing Order';
      } else if (medOrderDetailsController.isAssigDelieveryPartner.value &&
          medOrderDetailsController.buttonPosition.value > 12 &&
          !medOrderDetailsController.isEstimatedTime.value) {
        return 'Preparing Order';
      } else if (medOrderDetailsController.isPreparingOrder.value &&
          !medOrderDetailsController.isAssigDelieveryPartner.value &&
          medOrderDetailsController.buttonPosition.value < 12) {
        return 'Assign Delievery Partner';
      } else if (medOrderDetailsController.isPreparingOrder.value &&
          !medOrderDetailsController.isAssigDelieveryPartner.value &&
          medOrderDetailsController.buttonPosition.value > 12) {
        return 'Assigning Delievery Partner';
      } else if (medOrderDetailsController.isEstimatedTime.value &&
          medOrderDetailsController.isPreparingOrder.value &&
          medOrderDetailsController.buttonPosition.value < 12) {
        return 'Ready To Deliever';
      } else {
        return 'Out for Delivery';
      }
    }

    Color getButtonTextColor(
      PosCheckoutController posCheckoutController,
      MedOrderDetailsController medOrderDetailsController,
    ) {
      if (posCheckoutController.isChanged.value &&
          medOrderDetailsController.buttonPosition.value >= 12) {
        return AppColors.primaryGradinatMixColor;
      } else if (medOrderDetailsController.buttonPosition.value < 12 ||
          posCheckoutController.isChanged.value) {
        return AppColors.white;
      }
      return AppColors.primaryGradinatMixColor;
    }

    return Stack(
      children: [
        // Dynamic background container
        Obx(
          () => Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: getButtonGradient(
                posCheckoutController,
                medOrderDetailsController,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.containerShadowColor,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                getButtonText(
                  posCheckoutController,
                  medOrderDetailsController,
                  firstMedController,
                ),
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: getButtonTextColor(
                    posCheckoutController,
                    medOrderDetailsController,
                  ),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        // Sliding button
        Obx(
          () => AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: medOrderDetailsController.buttonPosition.value,
            top: 2.5,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                medOrderDetailsController.updatePosition(details.delta.dx);
              },
              onHorizontalDragEnd: (details) {
                medOrderDetailsController.onDragEnd();
              },
              child: Container(
                height: 45,
                width: 45,
                margin: EdgeInsets.only(left: 2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient:
                      medOrderDetailsController.buttonPosition.value < 12
                          ? LinearGradient(
                            colors: [AppColors.white, AppColors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                          : LinearGradient(
                            colors: [
                              AppColors.primaryFirstGradiant,
                              AppColors.primarySecondGradiant,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color:
                      medOrderDetailsController.buttonPosition.value < 12
                          ? AppColors.primaryGradinatMixColor
                          : AppColors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildAlertBox() {
  final MedOrderDetailsController medOrderDetailsController = Get.put(
    MedOrderDetailsController(),
  );
  final PosCheckoutController posCheckoutController = Get.put(
    PosCheckoutController(),
  );
  return AlertDialog(
    content: SingleChildScrollView(
      // Prevent overflow issues
      child: Column(
        mainAxisSize: MainAxisSize.min, // Prevent unnecessary height expansion
        children: [
          SvgPicture.asset(
            'assets/svgs/alert_triangel.svg',
            fit: BoxFit.contain,
            height: 50, // Set a fixed size
          ),
          SizedBox(height: 10),
          Text(
            'You are about to reject an order!',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Are you sure you want to reject this order? This action can be undone.\n${medOrderDetailsController.isOrderAccepted.value}',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomOutlinedButton(
              onPressed: () {
                Get.back();
                ();
              },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.secondary),
              ),
              icon: Icons.close,
              iconColor: AppColors.secondary,
              text: 'Cancel',
              textStyle: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.secondary,
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: CustomGradientButton(
              text: 'Reject',
              onPressed: () {
                // medOrderDetailsController.isOrderAccepted.value = false;
                posCheckoutController.isChanged.value = false;
                Get.back();
                ();
              },
              height: 35,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildEstimatedTimerPopUp() {
  final MedOrderDetailsController medOrderDetailsController = Get.put(
    MedOrderDetailsController(),
  );
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.timer),
            GestureDetector(
              onTap: () {
                Get.back();
                ();
              },
              child: Icon(Icons.close, color: AppColors.error),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Enter Processing Time in Minute',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryGradinatMixColor,
          ),
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          hintText: 'In Minute',
          keyboardType: TextInputType.number,
          controller: medOrderDetailsController.estimatedTime,
          validator: (p0) {},
          inputFormatters: [LengthLimitingTextInputFormatter(2)],
        ),
      ],
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomOutlinedButton(
              text: 'Cancel',
              textStyle: GoogleFonts.montserrat(
                color: AppColors.primaryGradinatMixColor,
              ),
              onPressed: () {
                Get.back();
                ();
              },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryFirstGradiant),
              ),
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            height: 38,
            width: 115,
            child: CustomGradientButton(
              text: 'Submit',
              onPressed: () {
                Get.back();
                ();
              },
            ),
          ),
        ],
      ),
    ],
  );
}
