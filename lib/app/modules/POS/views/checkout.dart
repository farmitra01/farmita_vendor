import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/controllers/pos_checkout_controller.dart';
import 'package:farmitra/app/modules/POS/views/apply_coupon.dart';
import 'package:farmitra/app/modules/POS/views/hold_order.dart';
import 'package:farmitra/app/modules/POS/views/pos_warning.dart';
import 'package:farmitra/app/modules/POS/views/view_contact.dart';
import 'package:farmitra/app/modules/home/controllers/first_med_controller.dart';
import 'package:farmitra/app/modules/home/views/med_order_details.dart';
import 'package:farmitra/app/modules/registration/controllers/store_category_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_outlined_button.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_text.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the PosCheckoutController
    final PosCheckoutController posCheckoutController = Get.put(
      PosCheckoutController(),
    );
    final RxList<Map<String, String>> selectedContacts = RxList(
      Get.arguments as List<Map<String, String>>? ?? [],
    );
    final FirstMedController firstMedController = Get.put(FirstMedController());
    final StoreCategoryController storeCategoryController = Get.put(
      StoreCategoryController(),
    );

    // Calculate total price dynamically
    String calculateTotalPrice() {
      double total = posCheckoutController.addedItems.fold(0, (sum, item) {
        final price = double.tryParse(item['productPrice'] ?? '0') ?? 0;
        final quantity =
            posCheckoutController.quantities[posCheckoutController.addedItems
                .indexOf(item)];
        return sum + (price * quantity);
      });
      return total.toStringAsFixed(0); // Format as integer
    }

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: VendorAppBar(
        title: "Checkout",
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.white),
            ),
            child: GestureDetector(
              onTap: () => Get.to(() => const HoldOrder()),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white),
                    ),
                    child: Text(
                      '3', // Replace with dynamic count if available
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'On-Hold',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart Items Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Cart Items',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Obx(
                        () => Text(
                          ' (${posCheckoutController.addedItems.length} Product)',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2.5,
                          offset: Offset(0, 0),
                          color: AppColors.border,
                          spreadRadius: 0.4,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: posCheckoutController.addedItems.length,
                            itemBuilder: (context, index) {
                              final item =
                                  posCheckoutController.addedItems[index];
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 15,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item['productname'] ?? '',
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.textPrimary,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            // const SizedBox(width: 8),
                                            SizedBox(
                                              height: 30,
                                              child: Obx(
                                                () =>
                                                    posCheckoutController
                                                                .isAdded[index] ==
                                                            false
                                                        ? GradientOutlinedButton(
                                                          text: 'ADD',
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                          gradient: LinearGradient(
                                                            begin:
                                                                Alignment
                                                                    .topCenter,
                                                            end:
                                                                Alignment
                                                                    .bottomCenter,
                                                            colors: [
                                                              AppColors
                                                                  .primaryFirstGradiant,
                                                              AppColors
                                                                  .primarySecondGradiant,
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            posCheckoutController
                                                                    .isAdded[index] =
                                                                true;
                                                            posCheckoutController
                                                                    .quantities[index] =
                                                                1;
                                                          },
                                                        )
                                                        : Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  5,
                                                                ),
                                                            border: Border.all(
                                                              color:
                                                                  AppColors
                                                                      .border,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              IconButton(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                onPressed:
                                                                    () => posCheckoutController
                                                                        .decrementQuantity(
                                                                          index,
                                                                        ),
                                                                icon: Icon(
                                                                  Icons.remove,
                                                                  color:
                                                                      AppColors
                                                                          .primaryGradinatMixColor,
                                                                ),
                                                                iconSize: 15,
                                                              ),
                                                              Obx(
                                                                () => Text(
                                                                  '${posCheckoutController.quantities[index]}',
                                                                  style: GoogleFonts.montserrat(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color:
                                                                        AppColors
                                                                            .primaryGradinatMixColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              IconButton(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                onPressed:
                                                                    () => posCheckoutController
                                                                        .incrementQuantity(
                                                                          index,
                                                                        ),
                                                                icon: Icon(
                                                                  Icons.add,
                                                                  color:
                                                                      AppColors
                                                                          .primaryGradinatMixColor,
                                                                ),
                                                                iconSize: 15,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              '₹${item['productPrice'] ?? ''}',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (item['hasGift'] == true)
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            height: 18,
                                            width: 18,
                                            padding: const EdgeInsets.all(3.5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                              ),
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppColors
                                                      .primaryFirstGradiant,
                                                  AppColors
                                                      .primarySecondGradiant,
                                                ],
                                              ),
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/svgs/gift_bw.svg',
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Container(color: Colors.grey, height: 0.5),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Write instructions for customer',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.add_circle_outline,
                                color: AppColors.textSecondary,
                                size: 20,
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

            // Quick Adds Section
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Quick adds to this cart',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: posCheckoutController.quickAddedList.length,
                  itemBuilder: (context, index) {
                    final item = posCheckoutController.quickAddedList[index];
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 80,
                                width: 75,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.border),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      item['productImage'] ?? '',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: 75,
                                child: Text(
                                  item['productname'] ?? '',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: 75,
                                child: Text(
                                  '200G - 250G', // Consider making dynamic
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '₹${item['productPrice'] ?? ''}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '₹${(int.tryParse(item['productPrice'] ?? '0') ?? 0) + 5}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              posCheckoutController.addItemFromQuickList(index);
                            },
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryFirstGradiant,
                                    AppColors.primarySecondGradiant,
                                  ],
                                ),
                              ),
                              child: Icon(Icons.add, color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Add Item Exclusively
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientSvgIcon(
                  icon: const Icon(Icons.add_circle_outline),
                  size: 20,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryFirstGradiant,
                      AppColors.primarySecondGradiant,
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () => Get.bottomSheet(addExclusiveItem()),
                  child: GradientText(
                    text: 'Add Item Exclusively',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryGradinatMixColor,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryFirstGradiant,
                        AppColors.primarySecondGradiant,
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Discount Coupons
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.1,
                    color: AppColors.containerShadowColor,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ExpansionTile(
                shape: Border.all(color: Colors.transparent),
                title: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/percent.svg',
                      height: 30,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Discount Coupons',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                trailing: GestureDetector(
                  onTap: () => Get.to(() => const ApplyCoupon()),
                  child: const Icon(Icons.arrow_right),
                ),
              ),
            ),

            // Bill Details
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text(
                'Bill Details',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: posCheckoutController.priceDetails.length,
                    itemBuilder: (context, index) {
                      final item = posCheckoutController.priceDetails[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Text(
                              item["title"] ?? '',
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            if (item.containsKey("isStrikethrough") &&
                                item["isStrikethrough"] == true) ...[
                              Text(
                                item["price"] ?? '',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                item["discountedPrice"] ?? '',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ] else
                              Text(
                                item["price"] ?? '',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      item["color"] as Color? ??
                                      AppColors.textSecondary,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => Row(
                      children: [
                        Text(
                          "To Pay ",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "₹${calculateTotalPrice()}",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/total_saving_bg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
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
                                const Spacer(),
                                Text(
                                  "₹420", // Replace with dynamic calculation if needed
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Delivery fee saving of ₹ included",
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
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

            // Add Discount
            GestureDetector(
              onTap: () {
                Get.bottomSheet(buildAddDiscount());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.offline_bolt,
                    size: 18,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                  Text(
                    ' Add discount',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  ),
                ],
              ),
            ),

            // Order as Gift
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 0.1,
                    color: AppColors.border,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ExpansionTile(
                shape: Border.all(color: Colors.transparent),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/gift_bw.svg',
                      color: AppColors.primaryGradinatMixColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order as a gift',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2.5),
                          Text(
                            'Add a message card and share it along with the tracking details',
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                trailing: SizedBox(
                  width: 40,
                  child: Obx(
                    () => Checkbox(
                      activeColor: AppColors.primaryGradinatMixColor,
                      side: BorderSide(
                        color: AppColors.primaryGradinatMixColor,
                      ),
                      value: posCheckoutController.isOrderGiftChecked.value,
                      onChanged: (value) {
                        posCheckoutController.isOrderGiftChecked.value =
                            value ?? false;
                        posCheckoutController.isGiftDetailsVisible.value =
                            !posCheckoutController.isGiftDetailsVisible.value;
                      },
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () =>
                  posCheckoutController.isGiftDetailsVisible.value
                      ? Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 0,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.1,
                              color: AppColors.containerShadowColor,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gift Message',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2.5),
                            CustomTextFormField(
                              hintText: 'Enter Gift Message',
                              keyboardType: TextInputType.text,
                              controller: posCheckoutController.giftMassage,
                              maxLines: 3,
                              borderRadius: 10,
                              isDottedBorder: true,
                              validator: (p0) => null,
                            ),
                            const SizedBox(height: 2.5),
                            Text(
                              'From',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2.5),
                            CustomTextFormField(
                              hintText: 'Name',
                              keyboardType: TextInputType.text,
                              controller: posCheckoutController.name,
                              borderRadius: 30,
                              isDottedBorder: true,
                              validator: (p0) => null,
                              suffixIcon: Icons.cancel,
                            ),
                          ],
                        ),
                      )
                      : const SizedBox(),
            ),

            // Customer Details Section
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Customers Details',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: TabBar(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: posCheckoutController.tabController,
                            dividerHeight: 0,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorPadding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColors.primaryGradinatMixColor,
                            ),
                            labelColor: AppColors.white,
                            labelStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                            unselectedLabelColor: AppColors.textSecondary,
                            tabs: const [
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.storefront_outlined, size: 15),
                                    SizedBox(width: 2.5),
                                    Text('Pick-Up'),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.navigation_outlined, size: 15),
                                    Text('Delivery'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 0.1,
                          color: AppColors.border,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () =>
                              selectedContacts.isNotEmpty
                                  ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: selectedContacts.length,
                                    itemBuilder: (context, index) {
                                      final contact = selectedContacts[index];
                                      return Obx(
                                        () => ExpansionTile(
                                          tilePadding: const EdgeInsets.all(0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          title: Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: AppColors.lightGrey,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    contact['Name'] ?? "N/A",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors
                                                                  .textPrimary,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 2.5),
                                                  Text(
                                                    contact['Number'] ?? 'N/A',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors
                                                                  .textSecondary,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  // Handle edit action
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.edit,
                                                      color:
                                                          AppColors
                                                              .primaryGradinatMixColor,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 2.5),
                                                    Text(
                                                      'Edit',
                                                      style: GoogleFonts.montserrat(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors
                                                                .primaryGradinatMixColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: GestureDetector(
                                            onTap:
                                                () => selectedContacts.removeAt(
                                                  index,
                                                ),
                                            child: Icon(
                                              Icons.delete_outline_outlined,
                                              color: AppColors.secondary,
                                            ),
                                          ),
                                          key: const Key(
                                            'deliveryExpansionTile',
                                          ),
                                          initiallyExpanded:
                                              posCheckoutController
                                                  .currentTabIndex
                                                  .value ==
                                              1,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                5.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    'Select an Address:',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 15,
                                                              ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Obx(
                                                                    () => Radio<
                                                                      String
                                                                    >(
                                                                      activeColor:
                                                                          AppColors
                                                                              .primaryGradinatMixColor,
                                                                      value:
                                                                          'Home',
                                                                      groupValue:
                                                                          posCheckoutController
                                                                              .selectedOption
                                                                              .value,
                                                                      onChanged: (
                                                                        value,
                                                                      ) {
                                                                        posCheckoutController.setSelectedOption(
                                                                          value!,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      'C-73, Vijma Girls Pg, C Block, Pocket C, Sector 27, Vizag Nagram, Vishakhapatnam, Andhra Pradesh',
                                                                      style: GoogleFonts.montserrat(
                                                                        fontSize:
                                                                            14,
                                                                        color:
                                                                            AppColors.textSecondary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                      left: 60,
                                                                      top: 10,
                                                                    ),
                                                                child: Text(
                                                                  '+91 ${contact['Number'] ?? ''}',
                                                                  style: GoogleFonts.montserrat(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color:
                                                                        AppColors
                                                                            .textPrimary,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.fromLTRB(
                                                                75,
                                                                8,
                                                                16,
                                                                12,
                                                              ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .more_horiz,
                                                                color:
                                                                    AppColors
                                                                        .textSecondary,
                                                              ),
                                                              const SizedBox(
                                                                width: 12,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .share_outlined,
                                                                color:
                                                                    AppColors
                                                                        .textSecondary,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 15,
                                                              ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Obx(
                                                                    () => Radio<
                                                                      String
                                                                    >(
                                                                      activeColor:
                                                                          AppColors
                                                                              .primaryGradinatMixColor,
                                                                      value:
                                                                          'Work',
                                                                      groupValue:
                                                                          posCheckoutController
                                                                              .selectedOption
                                                                              .value,
                                                                      onChanged: (
                                                                        value,
                                                                      ) {
                                                                        posCheckoutController.setSelectedOption(
                                                                          value!,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      'A Block, Pocket A, Sector 19, Noida, A Block, Pocket A, Sector 19, Noida',
                                                                      style: GoogleFonts.montserrat(
                                                                        fontSize:
                                                                            14,
                                                                        color:
                                                                            AppColors.textSecondary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                      left: 60,
                                                                      top: 10,
                                                                    ),
                                                                child: Text(
                                                                  '+91 ${contact['Number'] ?? ''}',
                                                                  style: GoogleFonts.montserrat(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color:
                                                                        AppColors
                                                                            .textPrimary,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.fromLTRB(
                                                                75,
                                                                8,
                                                                16,
                                                                12,
                                                              ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .more_horiz,
                                                                color:
                                                                    AppColors
                                                                        .textSecondary,
                                                              ),
                                                              const SizedBox(
                                                                width: 12,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .share_outlined,
                                                                color:
                                                                    AppColors
                                                                        .textSecondary,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                  : CustomTextFormField(
                                    hintText: 'Search Customers',
                                    keyboardType: TextInputType.text,
                                    controller:
                                        posCheckoutController.searchCustomer,
                                    validator: (p0) => null,
                                    suffixIcon: Icons.search,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () =>
                              selectedContacts.isEmpty
                                  ? Text(
                                    'No Customer Selected',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  )
                                  : const SizedBox(),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => SizedBox(
                            width: 215,
                            child: CustomGradientButton(
                              text:
                                  selectedContacts.isEmpty
                                      ? '+View Contact'
                                      : '+Select Other Customer',
                              onPressed:
                                  () => Get.to(() => const ViewContact()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 75,
        child: FloatingActionButton.extended(
          extendedPadding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: AppColors.appBarColor,
          onPressed: () {
            Get.to(() => HoldOrder());
          },
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.keyboard_double_arrow_left,
                color: AppColors.white,
              ),
              const SizedBox(width: 3),
              Text(
                'Hold\nOrder',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    "₹${calculateTotalPrice()}",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 2.5),
                Text(
                  'View Detailed Bill',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CustomGradientButton(
                text: 'Accept Payment',
                onPressed: () {
                  posCheckoutController.isChanged.value = true;
                  if (storeCategoryController.previousPageGridTitle == 'Med') {
                    Get.to(() => MedOrderDetails());
                  } else {
                    Get.to(() => PosWarning());
                  }
                },
                borderRadius: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget addExclusiveItem() {
  final PosCheckoutController posCheckoutController =
      Get.find<PosCheckoutController>();
  return BottomSheet(
    onClosing: () {},
    builder: (context) {
      return Container(
        height: 300,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Item :",
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryGradinatMixColor,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'Product Name',
              keyboardType: TextInputType.text,
              controller: posCheckoutController.productName,
              validator: (p0) => null,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'Selling Price(Incl. of all taxes)',
              keyboardType: TextInputType.number,
              controller: posCheckoutController.sellingPrice,
              validator: (p0) => null,
            ),
            const SizedBox(height: 10),
            CustomGradientButton(
              text: 'Add to cart',
              onPressed: () {
                if (posCheckoutController.productName.text.isNotEmpty &&
                    posCheckoutController.sellingPrice.text.isNotEmpty) {
                  posCheckoutController.addItemToList(
                    posCheckoutController.productName.text,
                    posCheckoutController.sellingPrice.text,
                  );
                  Get.closeAllSnackbars();
                  Get.back(closeOverlays: true);
                  (); // Close the bottom sheet
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget buildAddDiscount() {
  final PosCheckoutController posCheckoutController =
      Get.find<PosCheckoutController>();
  final formKey = GlobalKey<FormState>(); // For form validation
  return BottomSheet(
    onClosing: () {
      posCheckoutController.amount.clear();
    },
    builder: (context) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Additional Discount',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            posCheckoutController.isAmount.value = false;
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color:
                                    posCheckoutController.isAmount.value
                                        ? AppColors.border
                                        : AppColors.primaryGradinatMixColor,
                                width:
                                    posCheckoutController.isAmount.value
                                        ? 1
                                        : 2,
                              ),
                              color:
                                  posCheckoutController.isAmount.value
                                      ? Colors.transparent
                                      : AppColors.primaryGradinatMixColor
                                          .withOpacity(0.1),
                            ),
                            child: Text(
                              'By Amount',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color:
                                    posCheckoutController.isAmount.value
                                        ? AppColors.textSecondary
                                        : AppColors.primaryGradinatMixColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            posCheckoutController.isAmount.value = true;
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color:
                                    posCheckoutController.isAmount.value
                                        ? AppColors.primaryGradinatMixColor
                                        : AppColors.border,
                                width:
                                    posCheckoutController.isAmount.value
                                        ? 2
                                        : 1,
                              ),
                              color:
                                  posCheckoutController.isAmount.value
                                      ? AppColors.primaryGradinatMixColor
                                          .withOpacity(0.1)
                                      : Colors.transparent,
                            ),
                            child: Text(
                              'By Percent',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color:
                                    posCheckoutController.isAmount.value
                                        ? AppColors.primaryGradinatMixColor
                                        : AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => CustomTextFormField(
                    hintText:
                        posCheckoutController.isAmount.value
                            ? 'Enter Percentage (%)'
                            : 'Enter Amount (₹)',
                    keyboardType: TextInputType.number,
                    controller:
                        posCheckoutController.isAmount.value
                            ? posCheckoutController.amount
                            : posCheckoutController.percent,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      double? num = double.tryParse(value);
                      if (num == null || num <= 0) {
                        return 'Please enter a valid number';
                      }
                      if (posCheckoutController.isAmount.value && num > 100) {
                        return 'Percentage cannot exceed 100%';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomGradientButton(
                  text: 'Submit',
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      posCheckoutController.applyDiscount(
                        posCheckoutController.percent.text,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
