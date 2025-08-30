import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/order_details_cotroller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_rectangle_painter.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailsController orderDetailsController = Get.put(
      OrderDetailsController(),
    );
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
                  border: Border.all(color: AppColors.border),
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
                  border: Border.all(color: AppColors.white),
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
                        text: '#10062',
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
        physics: BouncingScrollPhysics(),
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
                        orderDetailsController.isExpanded.value == true
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
                                color: AppColors.white,
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
                                        return orderDetailsController
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
                                                color: AppColors.background,
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
                          return orderDetailsController.isExpanded.value == true
                              ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    orderDetailsController
                                        .customerDetails
                                        .length,
                                itemBuilder: (context, index) {
                                  final item =
                                      orderDetailsController
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
                                                        style: GoogleFonts.montserrat(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              AppColors
                                                                  .green, // Text color
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
                                                            color:
                                                                AppColors.black,
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
                                  orderDetailsController.launchDialPad(
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
                                  orderDetailsController.isExpanded.value =
                                      !orderDetailsController.isExpanded.value;
                                },
                                child: Text(
                                  orderDetailsController.isExpanded.value
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
                      color: AppColors.background,
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
                      color: AppColors.border,
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
                // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: orderDetailsController.priceDetails.length,
                      itemBuilder: (context, index) {
                        final item = orderDetailsController.priceDetails[index];
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Row(
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
                                      color: AppColors.black,
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
                        itemCount: orderDetailsController.stepDetails.length,
                        itemBuilder: (context, index) {
                          final step =
                              orderDetailsController.stepDetails[index];
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
                                                    orderDetailsController
                                                            .stepDetails
                                                            .length -
                                                        1
                                                ? AppColors.white
                                                : AppColors.textSecondary,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          index ==
                                                  orderDetailsController
                                                          .stepDetails
                                                          .length -
                                                      1
                                              ? AppColors.lightGrey
                                              : AppColors.white,
                                      child: GradientSvgIcon(
                                        icon: Icon(
                                          orderDetailsController
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
                                      orderDetailsController
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
                                      orderDetailsController
                                          .stepDetails[index]
                                          .text,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      orderDetailsController
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
            Obx(
              () => Center(
                child:
                    orderDetailsController.isOrderAccepted.value == false
                        ? CustomGradientButton(
                          icon: Icons.check_circle_outline,
                          text: "Accept Order",
                          onPressed: () {
                            // Toggle the value of isOrderAccepted
                            orderDetailsController.isOrderAccepted.value =
                                !orderDetailsController.isOrderAccepted.value;
                            // Get.dialog(buildAlertBox());
                          },
                        )
                        : SliderButtonSheet(), // Display SliderButtonSheet when order is accepted
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
  final OrderDetailsController orderDetailsController = Get.put(
    OrderDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    return
    // Container(
    // height: 300, // Height of the bottom sheet
    // padding: EdgeInsets.all(16),
    // child:
    Stack(
      children: [
        // Dynamic background container
        Obx(
          () => Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient:
                  orderDetailsController.buttonPosition.value < 12
                      ? LinearGradient(
                        colors: [
                          AppColors.primaryFirstGradiant,
                          AppColors.primarySecondGradiant,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                      : LinearGradient(
                        colors: [AppColors.white, AppColors.white],
                      ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                orderDetailsController.buttonPosition.value < 12
                    ? "Start Preparing the Order"
                    : "Started Preparing the Order",
                style: TextStyle(
                  color:
                      orderDetailsController.buttonPosition.value < 12
                          ? AppColors.white
                          : AppColors.primaryGradinatMixColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),

        // Sliding button
        Obx(
          () => AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: orderDetailsController.buttonPosition.value,
            top: 2.5, // Center the button vertically
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                orderDetailsController.updatePosition(details.delta.dx);
              },
              onHorizontalDragEnd: (details) {
                orderDetailsController.onDragEnd();
              },
              child: Container(
                height: 45,
                width: 45,
                margin: EdgeInsets.only(left: 2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient:
                      orderDetailsController.buttonPosition.value < 12
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
                      orderDetailsController.buttonPosition.value < 12
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
    // );
  }
}

Widget buildAlertBox() {
  final OrderDetailsController orderDetailsController = Get.put(
    OrderDetailsController(),
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
            'Are you sure you want to reject this order? This action can be undone.',
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
                orderDetailsController.isOrderAccepted.value = false;
                // Get.to(OrderView());
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
