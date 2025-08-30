import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/POS/controllers/view_contact_controller.dart';
import 'package:farmitra/app/modules/POS/views/checkout.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewContact extends StatelessWidget {
  const ViewContact({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewContactController viewContactController = Get.put(
      ViewContactController(),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Contacts:',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.5),
            Text(
              'Your customers and saved contacts',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: AppColors.primaryGradinatMixColor,
              child: Icon(Icons.close, color: AppColors.white),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            CustomTextFormField(
              hintText: 'Search',
              keyboardType: TextInputType.text,
              controller: viewContactController.search,
              validator: (p0) {},
              suffixIcon: Icons.search,
              borderRadius: 10,
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColors.border),
              ),
              child: TabBar(
                physics: NeverScrollableScrollPhysics(),
                controller: viewContactController.tabController,
                dividerHeight: 00,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.white,
                ),
                labelColor: AppColors.textPrimary,
                labelStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                unselectedLabelColor: Color(0xffB3B3B3),
                tabs: [Tab(child: Text('Recent')), Tab(child: Text('All'))],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: viewContactController.tabController,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewContactController.contactList.length,
                    itemBuilder: (context, index) {
                      var Data = viewContactController.contactList[index];
                      return Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.lightGrey,
                              ),
                            ),
                            SizedBox(width: 2.5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Data['Name'],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 2.5),
                                Text(
                                  Data['Number'],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Obx(
                              () => Checkbox(
                                activeColor: AppColors.primaryGradinatMixColor,
                                value:
                                    viewContactController
                                        .isRecentCheckedList[index]
                                        .value,
                                onChanged: (value) {
                                  viewContactController
                                      .isRecentCheckedList[index]
                                      .value = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.lightGrey,
                              ),
                            ),
                            SizedBox(width: 2.5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amakant Sharma',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 2.5),
                                Text(
                                  '+91 98729 29491',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Obx(
                              () => Checkbox(
                                activeColor: AppColors.primaryGradinatMixColor,
                                value:
                                    viewContactController
                                        .isAllCheckedList[index]
                                        .value,
                                onChanged: (value) {
                                  viewContactController
                                      .isAllCheckedList[index]
                                      .value = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomGradientButton(
              text: 'Select Contact ',
              onPressed: () {
                List<Map<String, String>> selectedContacts =
                    viewContactController.getSelectedContacts();
                Get.to(() => Checkout(), arguments: selectedContacts);
              },
            ),
            SizedBox(height: 10),
            Text(
              '+ Add Customer',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryGradinatMixColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
