import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/Add_coupons/views/create_new_coupons_view.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controllers/add_coupons_controller.dart';

class AddCouponsView extends GetView<AddCouponsController> {
  const AddCouponsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AddCouponsController controller = Get.put(AddCouponsController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: VendorAppBar(title: 'Coupons'),
      body: Obx(() {
        // Log the number of coupons for debugging
        print('Coupons in view: ${controller.validCoupons.length}');
        if (controller.validCoupons.isEmpty) {
          return const Center(child: Text('No coupons available'));
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Promotional Section
                _buildSectionTitle('Promotional'),
                const SizedBox(height: 10),
                _buildCouponList(controller.getPromotionalCoupons(), controller, 'Promotional'),
                const SizedBox(height: 20),
                // Regular Section
                _buildSectionTitle('Regular'),
                const SizedBox(height: 10),
                _buildCouponList(controller.getRegularCoupons(), controller, 'Regular'),
                const SizedBox(height: 20),
                // Others Section
                _buildSectionTitle('Others'),
                const SizedBox(height: 10),
                _buildCouponList(controller.getOtherCoupons(), controller, 'Others'),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          Get.to(() => const create_new_coupons_view());
        },
        child: CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.primaryGradinatMixColor,
          child: const Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildCouponList(List<Map<String, dynamic>> coupons, AddCouponsController controller, String section) {
    print('$section coupons count: ${coupons.length}');
    return coupons.isEmpty
        ? Center(child: Text('No $section Coupons'))
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: coupons.length,
            itemBuilder: (context, index) {
              final coupon = coupons[index];
              final globalIndex = controller.validCoupons.indexWhere(
                (c) => c['code'] == coupon['code'],
              );
              return _buildCouponCard(coupon, globalIndex, controller);
            },
          );
  }

  Widget _buildCouponCard(
    Map<String, dynamic> coupon,
    int index,
    AddCouponsController controller,
  ) {
    final discountValue = (coupon['discount'] ?? 0).toString();
    final discountType = coupon['discount_type'] as String? ?? 'Percentage';
    final isNew = _isNewCoupon(coupon['start_date'] as String?);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.border.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ExpansionTile(
                backgroundColor: Colors.transparent,
                shape: Border.all(color: Colors.transparent),
                iconColor: AppColors.primaryGradinatMixColor,
                title: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Center(
                        child: Text(
                          discountType == 'Amount' ? '₹$discountValue\nOFF' : '$discountValue%\nOFF',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryGradinatMixColor,
                          ),
                        ),
                      ),
                    ),
                    Container(color: AppColors.border, height: 100, width: 1.5),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  coupon['code'] ?? 'N/A',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryGradinatMixColor,
                                  ),
                                ),
                                Obx(
                                  () => Switch(
                                    trackOutlineWidth: const WidgetStatePropertyAll(0),
                                    activeColor: AppColors.primaryGradinatMixColor,
                                    value: controller.isSwitched[index].value,
                                    onChanged: (bool value) {
                                      controller.toggleSwitch(index, value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              coupon['description'] ?? 'No Description',
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGradinatMixColor,
                              ),
                            ),
                            Text(
                              'Total Users: ${coupon['user_limit'] ?? '0'}',
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGradinatMixColor,
                              ),
                            ),
                            Text(
                              'Expires on: ${coupon['end_date'] ?? 'N/A'}',
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGradinatMixColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                children: [
                  Container(
                    width: double.infinity,
                    color: AppColors.green.withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              controller.deleteCoupon(index);
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.error.withOpacity(0.3),
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.delete_outlined,
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Date: ${coupon['start_date'] ?? 'N/A'}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                              Text(
                                'Minimum Purchase: ${coupon['min_cart_value'] ?? '0'}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                              Text(
                                'Max Discount: ${coupon['max_discount'] ?? '0'}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                              Text(
                                'Coupon Type: ${coupon['coupon_type'] ?? 'N/A'}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                              Text(
                                'Discount Type: ${coupon['discount_type'] ?? 'Percentage'}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              Get.to(
                                () => const create_new_coupons_view(),
                                arguments: coupon,
                              );
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.green.withOpacity(0.3),
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: AppColors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isNew)
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    color: AppColors.green,
                  ),
                  child: Text(
                    'NEW',
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  bool _isNewCoupon(String? startDate) {
    if (startDate == null || startDate == 'N/A') return false;
    try {
      final date = DateFormat('dd-MM-yyyy').parse(startDate);
      return date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    } catch (e) {
      return false;
    }
  }
}