import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/manage_appointment._controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageAppointmant extends StatelessWidget {
  const ManageAppointmant({super.key});

  @override
  Widget build(BuildContext context) {
    final ManageAppointmentController manageAppointmantController = Get.put(
      ManageAppointmentController(),
    );
    return Scaffold(
      appBar: VendorAppBar(title: 'Manage Appointment'),
      body: Column(
        children: [
          SizedBox(height: 10),
          TabBar(
            controller: manageAppointmantController.tabController,
            dividerColor: Colors.transparent,
            indicatorColor: AppColors.primaryGradinatMixColor,
            labelColor: AppColors.primaryGradinatMixColor,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: [
              Container(
                height: 75,
                color: Colors.transparent,
                child: Tab(
                  child: Container(
                    height: 75,
                    // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.background,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 2.5,
                          color: AppColors.containerShadowColor,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/Package.svg',
                              height: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '15',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text('Online'),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 75,
                color: Colors.transparent,
                child: Tab(
                  child: Container(
                    height: 75,

                    // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.background,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 2.5,
                          color: AppColors.containerShadowColor,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/Package.svg',
                              height: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '15',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text('Farm Visit'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: manageAppointmantController.tabController,
              children: [buildOnlineTab(context), buildOfflineTab(context)],
            ),
          ),
        ],
      ),
      // floatingActionButton: Container(
      //   width: 150,
      //   height: 50,
      //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(30),
      //     color: AppColors.error,
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Save',
      //         style: GoogleFonts.montserrat(
      //           fontSize: 18,
      //           fontWeight: FontWeight.w600,
      //           color: AppColors.white,
      //         ),
      //       ),
      //       Spacer(),
      //       Icon(Icons.arrow_forward_ios_rounded, color: AppColors.white),
      //       SizedBox(width: 10),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),

        child: CustomGradientButton(text: 'Save', onPressed: () {}),
      ),
    );
  }
}

Widget buildOnlineTab(BuildContext context) {
  final ManageAppointmentController manageAppointmentController = Get.put(
    ManageAppointmentController(),
  );

  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 2.5,
            color: AppColors.containerShadowColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Consultation Fee',
            style: GoogleFonts.montserrat(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Enter your Consultation fees which will be charged to patients.',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 5),
          CustomTextFormField(
            hintText: 'Enter Appontment Consultation Charges',
            keyboardType: TextInputType.number,
            controller: manageAppointmentController.appointmentConsultationFee,
            validator: (p0) {},
          ),
          SizedBox(height: 5),
          CustomTextFormField(
            hintText: 'Enter Disease Consultation Charges',
            keyboardType: TextInputType.number,
            controller: manageAppointmentController.diseaseConsultationFee,
            validator: (p0) {},
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Enter Farm visit Charges',

            keyboardType: TextInputType.number,
            controller: manageAppointmentController.farmAdvisoryConsultationFee,
            validator: (p0) {},
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Availability',
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.dialog(buildBlockData());
                },
                child: Text(
                  'Block Time',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.error,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            'Enter your timings which will be used for appointment.',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 25,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: manageAppointmentController.weeks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    manageAppointmentController.toggleSelection(index);
                  },
                  child: Obx(() {
                    bool isSelected = manageAppointmentController
                        .selectedIndices
                        .contains(index);

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.5),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 2.5,
                      ),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                        color:
                            isSelected
                                ? AppColors.primaryGradinatMixColor
                                : AppColors.lightGrey,
                      ),
                      child: Text(
                        manageAppointmentController.weeks[index],
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color:
                              isSelected ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Session Time',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),

          Obx(
            () => Column(
              children: List.generate(
                manageAppointmentController.timeFields.length ~/ 2,
                (index) {
                  bool isFirstRow = index == 0;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        // First Time Picker
                        Expanded(
                          child: TextFormField(
                            controller:
                                manageAppointmentController
                                    .timeControllers[index * 2],
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: '09:00 AM',
                              suffixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                            ),
                            onTap:
                                () => manageAppointmentController.selectTime(
                                  context,
                                  index * 2,
                                ),
                          ),
                        ),
                        SizedBox(width: 5),
                        // Second Time Picker
                        Expanded(
                          child: TextFormField(
                            controller:
                                manageAppointmentController
                                    .timeControllers[index * 2 + 1],
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: '06:00 PM',
                              suffixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                            ),
                            onTap:
                                () => manageAppointmentController.selectTime(
                                  context,
                                  index * 2 + 1,
                                ),
                          ),
                        ),
                        // Add or Remove Button
                        SizedBox(
                          width: 30,
                          child: IconButton(
                            onPressed:
                                isFirstRow
                                    ? manageAppointmentController
                                        .addNewTimeField
                                    : () => manageAppointmentController
                                        .removeTimeField(index * 2),
                            icon: Icon(
                              isFirstRow
                                  ? Icons.add_circle_outline
                                  : Icons.cancel_outlined,
                              color: AppColors.primaryGradinatMixColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    ),
  );
}

Widget buildOfflineTab(BuildContext context) {
  final ManageAppointmentController manageAppointmentController = Get.put(
    ManageAppointmentController(),
  );
  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 2.5,
            color: AppColors.containerShadowColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Consultation Fee',
            style: GoogleFonts.montserrat(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Enter your Consultation fees which will be charged to patients.',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Minimum Booking Charges',
            keyboardType: TextInputType.number,
            controller: manageAppointmentController.bookingFee,
            validator: (p0) {},
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: ' Consultation Charges',
            keyboardType: TextInputType.number,
            controller: manageAppointmentController.offlineConsultationFee,
            validator: (p0) {},
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Follow Up Charges',
            keyboardType: TextInputType.number,
            controller: manageAppointmentController.offlineFollowUp,
            validator: (p0) {},
          ),
          SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Maximum Service distance in KM',
            keyboardType: TextInputType.number,
            controller: manageAppointmentController.maxServiceDistance,
            validator: (p0) {},
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Availability',
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.dialog(buildBlockData());
                },
                child: Text(
                  'Block Time',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.error,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            'Enter your timings which will be used for appointment.',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 25,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: manageAppointmentController.weeks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    manageAppointmentController.toggleSelection(index);
                  },
                  child: Obx(() {
                    bool isSelected = manageAppointmentController
                        .selectedIndices
                        .contains(index);

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.5),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 2.5,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                        color:
                            isSelected
                                ? AppColors.primaryGradinatMixColor
                                : AppColors.background,
                      ),
                      child: Text(
                        manageAppointmentController.weeks[index],
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color:
                              isSelected ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),

          SizedBox(height: 20),
          Text(
            'Session Time',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              
             
            ],
          ),
          Obx(
            () => Column(
              children: List.generate(
                manageAppointmentController.timeFields.length ~/ 2,
                (index) {
                  bool isFirstRow = index == 0;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        // First Time Picker
                        Expanded(
                          child: TextFormField(
                            controller:
                                manageAppointmentController
                                    .timeControllers[index * 2],
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: '09:00 AM',
                              suffixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                            ),
                            onTap:
                                () => manageAppointmentController.selectTime(
                                  context,
                                  index * 2,
                                ),
                          ),
                        ),
                        SizedBox(width: 5),
                        // Second Time Picker
                        Expanded(
                          child: TextFormField(
                            controller:
                                manageAppointmentController
                                    .timeControllers[index * 2 + 1],
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: '06:00 PM',
                              suffixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                            ),
                            onTap:
                                () => manageAppointmentController.selectTime(
                                  context,
                                  index * 2 + 1,
                                ),
                          ),
                        ),
                        // Add or Remove Button
                        SizedBox(
                          width: 30,
                          child: IconButton(
                            onPressed:
                                isFirstRow
                                    ? manageAppointmentController
                                        .addNewTimeField
                                    : () => manageAppointmentController
                                        .removeTimeField(index * 2),
                            icon: Icon(
                              isFirstRow
                                  ? Icons.add_circle_outline
                                  : Icons.cancel_outlined,
                              color: AppColors.primaryGradinatMixColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    ),
  );
}

Widget buildBlockData() {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    title: Text(
      "Select Date",
      style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    content: SizedBox(
      height: 500, // Adjust height for calendar
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            onDateChanged: (selectedDate) {
              print("Selected Date: $selectedDate");
              Get.closeAllSnackbars();
              Get.back(closeOverlays: true);
              (); // Close the dialog after selecting a date
            },
          ),
          SizedBox(height: 10),
          Text(
            'Blocked Data',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              5,
              (index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.green),
                ),
                child: Text('10'),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
