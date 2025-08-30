import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/manage_service_controller.dart';
import 'package:farmitra/app/modules/home/views/home_bottom_bar_view.dart';
import 'package:farmitra/app/modules/inventry/views/add_rental_item.dart';
import 'package:farmitra/app/utils/global_widgets/custom_dropdown.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/custom_text_form_field.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageServices extends StatelessWidget {
  ManageServices({super.key});

  @override
  Widget build(BuildContext context) {
    final ManageServiceController manageServiceController = Get.put(
      ManageServiceController(),
    );

    return Scaffold(
      appBar: VendorAppBar(title: 'Manage Service'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => AddRentalItem());
                },
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Tractor',
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryGradinatMixColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 130,
                            width: 150,
                            child: GestureDetector(
                              onTap: () {
                                // Handle image tap
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 15),
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      enlargeCenterPage: true,
                                      aspectRatio: 16 / 9,
                                      viewportFraction: 0.8,
                                    ),
                                    items:
                                        manageServiceController.imagePaths.map((
                                          imagePath,
                                        ) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Image.asset(
                                              imagePath,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.lightGrey,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Reddish - brown pustules on a wheat stem will turn black as it decays',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomGradientButton(
                                        borderRadius: 10,
                                        width: 100,
                                        height: 35,
                                        text: 'Hourly',
                                        onPressed: () {},
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomGradientButton(
                                        borderRadius: 10,
                                        width: 100,
                                        height: 35,
                                        text: 'Work Wise',
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
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
            const SizedBox(height: 10),

            /// TabBar Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  TabBar(
                    controller: manageServiceController.twoTabController,
                    labelColor: AppColors.primaryGradinatMixColor,
                    unselectedLabelColor: AppColors.textSecondary,
                    indicatorColor: AppColors.primaryGradinatMixColor,
                    tabs: const [Tab(text: 'Hourly'), Tab(text: 'Work Wise')],
                  ),
                  SizedBox(
                    height: 650,
                    child: TabBarView(
                      controller: manageServiceController.twoTabController,
                      children: [
                        buildHourlyContent(context),
                        buildWorkWise(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildHourlyContent(BuildContext context) {
  final ManageServiceController manageServiceController =
      Get.find<ManageServiceController>();

  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
          const SizedBox(height: 5),
          Text(
            'Enter your Consultation fees which will be charged to patients.',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Minimum Booking Charges',
            keyboardType: TextInputType.number,
            controller: manageServiceController.bookingFee,
            validator: (p0) => null,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Rental Charges',
            keyboardType: TextInputType.number,
            controller: manageServiceController.offlineConsultationFee,
            validator: (p0) => null,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Discount',
            keyboardType: TextInputType.number,
            controller: manageServiceController.offlineFollowUp,
            validator: (p0) => null,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Maximum Service distance in KM',
            keyboardType: TextInputType.number,
            controller: manageServiceController.maxServiceDistance,
            validator: (p0) => null,
          ),
          const SizedBox(height: 20),
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
                  'Block Date',
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
          const SizedBox(height: 5),
          Text(
            'Enter your timings which will be used for appointment.',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 25,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: manageServiceController.weeks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    manageServiceController.toggleSelection(index);
                  },
                  child: Obx(() {
                    bool isSelected = manageServiceController.selectedIndices
                        .contains(index);
                    return Container(
                      // margin: const EdgeInsets.symmetric(horizontal: 1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2.5,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        border: Border.all(),
                        color:
                            isSelected
                                ? AppColors.primaryGradinatMixColor
                                : AppColors.background,
                      ),
                      child: Text(
                        manageServiceController.weeks[index],
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
          const SizedBox(height: 20),

          // Text(
          //   'Session Time',
          //   style: GoogleFonts.montserrat(
          //     fontSize: 12,
          //     fontWeight: FontWeight.w500,
          //     color: AppColors.textPrimary,
          //   ),
          // ),
          // const SizedBox(height: 10),
          Obx(
            () => Column(
              children: List.generate(
                manageServiceController.timeFields.length ~/ 2,
                (index) {
                  bool isFirstRow = index == 0;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:
                                manageServiceController.timeControllers[index *
                                    2],
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: '09:00 AM',
                              suffixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                            ),
                            onTap:
                                () => manageServiceController.selectTime(
                                  context,
                                  index * 2,
                                ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: TextFormField(
                            controller:
                                manageServiceController
                                    .timeControllers[index * 2 + 1],
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: '06:00 PM',
                              suffixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                            ),
                            onTap:
                                () => manageServiceController.selectTime(
                                  context,
                                  index * 2 + 1,
                                ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 30,
                          child: IconButton(
                            onPressed:
                                isFirstRow
                                    ? manageServiceController.addNewTimeField
                                    : () => manageServiceController
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
          const SizedBox(height: 10),
          CustomGradientButton(
            text: 'Save',
            onPressed: () {
              Get.closeAllSnackbars();
              Get.back(closeOverlays: true);
              ();
            },
          ),
        ],
      ),
    ),
  );
}

Widget buildWorkWise(BuildContext context) {
  final ManageServiceController manageServiceController =
      Get.find<ManageServiceController>();

  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
          const SizedBox(height: 5),
          Text(
            'Enter your Consultation fees which will be charged to patients.',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),

          Obx(
            () => CustomDropdown<String>(
              hint: 'Nature of Work',
              items:
                  manageServiceController
                      .bankDetails, // Keep it as List<String>
              selectedItem:
                  manageServiceController.selectedItem.value.isEmpty
                      ? null
                      : manageServiceController.selectedItem.value,
              onChanged: (value) {
                manageServiceController.updatedSelectedValue(value ?? '');
              },
              itemBuilder: (item) => item, // Correct item mapping
            ),
          ),
          const SizedBox(height: 10),

          CustomTextFormField(
            hintText: 'Minimum Booking Charges',
            keyboardType: TextInputType.number,
            controller: manageServiceController.bookingFee,
            validator: (p0) => null,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Rental Charges',
            keyboardType: TextInputType.number,
            controller: manageServiceController.offlineConsultationFee,
            validator: (p0) => null,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Discount',
            keyboardType: TextInputType.number,
            controller: manageServiceController.offlineFollowUp,
            validator: (p0) => null,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            hintText: 'Maximum Service distance in KM',
            keyboardType: TextInputType.number,
            controller: manageServiceController.maxServiceDistance,
            validator: (p0) => null,
          ),
          const SizedBox(height: 20),

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
                  'Block Date',
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
          const SizedBox(height: 5),
          Text(
            'Enter your timings which will be used for appointment.',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 25,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: manageServiceController.weeks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    manageServiceController.toggleSelection(index);
                  },
                  child: Obx(() {
                    bool isSelected = manageServiceController.selectedIndices
                        .contains(index);
                    return Container(
                      // margin: const EdgeInsets.symmetric(horizontal: 1.5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2.5,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(),
                        color:
                            isSelected
                                ? AppColors.primaryGradinatMixColor
                                : AppColors.background,
                      ),
                      child: Text(
                        manageServiceController.weeks[index],
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
          const SizedBox(height: 20),
          Text(
            'Session Time',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 10),
          Obx(
            () => Column(
              children: List.generate(
                manageServiceController.timeFields.length ~/ 2,
                (index) {
                  bool isFirstRow = index == 0;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:
                                manageServiceController.timeControllers[index *
                                    2],
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: '09:00 AM',
                              suffixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                            ),
                            onTap:
                                () => manageServiceController.selectTime(
                                  context,
                                  index * 2,
                                ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: TextFormField(
                            controller:
                                manageServiceController
                                    .timeControllers[index * 2 + 1],
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: '06:00 PM',
                              suffixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                            ),
                            onTap:
                                () => manageServiceController.selectTime(
                                  context,
                                  index * 2 + 1,
                                ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 30,
                          child: IconButton(
                            onPressed:
                                isFirstRow
                                    ? manageServiceController.addNewTimeField
                                    : () => manageServiceController
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
          const SizedBox(height: 10),
          CustomGradientButton(
            text: 'Save',
            onPressed: () {
              Get.closeAllSnackbars();
              Get.back(closeOverlays: true);
              ();
            },
          ),
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
      height: 500,
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
              ();
            },
          ),
          const SizedBox(height: 10),
          Text(
            'Blocked Data',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              5,
              (index) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.green),
                ),
                child: const Text('10'),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
