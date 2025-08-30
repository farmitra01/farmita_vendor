import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/khata_book/controllers/customer_profile_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerProfile extends StatelessWidget {
  const CustomerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerProfileController customerProfileController = Get.put(
      CustomerProfileController(),
    );
    return Scaffold(
      appBar: VendorAppBar(title: 'Customer Profile'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: AppColors.primaryGradinatMixColor.withOpacity(0.2),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 0.5,
                      child: Icon(
                        Icons.camera_alt,
                        color: AppColors.primaryGradinatMixColor,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryGradinatMixColor,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 35,
                        child: Icon(
                          Icons.person_2_rounded,
                          size: 35,
                          color: AppColors.primaryGradinatMixColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              itemCount: customerProfileController.profileList.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          customerProfileController.profileList[index]['icon'],
                          color: AppColors.primaryGradinatMixColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          customerProfileController.profileList[index]['name'],
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: AppColors.primaryGradinatMixColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: AppColors.primaryGradinatMixColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: CustomGradientButton(
          icon: Icons.delete_forever,
          text: 'Delete Customer',
          onPressed: () {},
        ),
      ),
    );
  }
}
