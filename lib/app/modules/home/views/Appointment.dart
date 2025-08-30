import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/appointment_controller.dart';
import 'package:farmitra/app/modules/home/services/home_service.dart';
import 'package:farmitra/app/modules/home/views/Appointment_Details.dart';
import 'package:farmitra/app/modules/home/views/reply.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller once
    final AppointmentController appointmentController = Get.put(
      AppointmentController(apiService: HomeService()),
    );

    return Scaffold(
      appBar: const VendorAppBar(title: 'Appointment'),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  color: AppColors.border,
                  offset: Offset(0, 1),
                  spreadRadius: 0.5,
                ),
              ],
            ),
            child: TabBar(
              controller: appointmentController.tabController,
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
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              unselectedLabelColor: AppColors.textSecondary,
              tabs: const [
                Tab(text: 'Online Consultation'),
                Tab(text: 'Farm Visit'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: appointmentController.tabController,
              children: [buildOnlineConsultationTab(), buildFarmVisitTab(1)],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildOnlineConsultationTab() {
  final AppointmentController appointmentController =
      Get.find<AppointmentController>();
  return Column(
    children: [
      const SizedBox(height: 8),
      TabBar(
        controller: appointmentController.consultationTabController,
        dividerColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        labelColor: AppColors.primaryGradinatMixColor,
        unselectedLabelColor: AppColors.textSecondary,
        labelPadding: const EdgeInsets.symmetric(horizontal: 5),
        tabs: [
          Obx(
            () => buildTabContainer(
              'Appointment',
              'assets/svgs/Package.svg',
              appointmentController.getTabCount(1, 'Appointment').toString(),
            ),
          ),
          Obx(
            () => buildTabContainer(
              'Disease',
              'assets/svgs/Package.svg',
              appointmentController.getTabCount(2, 'Disease').toString(),
            ),
          ),
          Obx(
            () => buildTabContainer(
              'Farm Advisory',
              'assets/svgs/Package.svg',
              appointmentController.getTabCount(3, 'Farm Advisory').toString(),
            ),
          ),
        ],
      ),
      Expanded(
        child: TabBarView(
          controller: appointmentController.consultationTabController,
          children: [
            buildSubTabView(1),
            buildSubTabView(2),
            buildSubTabView(3),
          ],
        ),
      ),
    ],
  );
}

Widget buildFarmVisitTab(int tabIndex) {
  final AppointmentController appointmentController =
      Get.find<AppointmentController>();
  return Column(
    children: [
      const SizedBox(height: 8),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              color: AppColors.border,
              offset: Offset(0, 1),
              // spreadWeight: 0.5,
            ),
          ],
        ),

        child: TabBar(
          controller: appointmentController.farmVisitTabController,
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
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelColor: AppColors.textSecondary,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,

          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Accepted'),
            Tab(text: 'Confirmed'),
          ],
        ),
      ),

      Expanded(
        child: TabBarView(
          controller: appointmentController.farmVisitTabController,
          children: [
            buildPendingTab(tabIndex),
            buildAcceptedTab(tabIndex),
            buildConfirmedTab(tabIndex),
          ],
        ),
      ),
    ],
  );
}

Widget buildTabContainer(String title, String iconPath, String count) {
  return Container(
    height: 60,
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
    child: Tab(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.background,
          boxShadow:  [
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
                  iconPath,
                  height: 20,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(width: 8),
                Text(
                  count,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildSubTabView(int tabIndex) {
  final AppointmentController appointmentController =
      Get.find<AppointmentController>();
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              color: AppColors.border,
              offset: Offset(0, 1),
              // spreadWeight: 0.5,
            ),
          ],
        ),
        child: TabBar(
          controller: appointmentController.threeTabController,
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
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelColor: AppColors.textSecondary,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Accepted'),
            Tab(text: 'Confirmed'),
          ],
        ),
      ),
      Expanded(
        child: TabBarView(
          controller: appointmentController.threeTabController,
          children: [
            buildPendingTab(tabIndex),
            buildAcceptedTab(tabIndex),
            buildConfirmedTab(tabIndex),
          ],
        ),
      ),
    ],
  );
}

Widget buildPendingTab(int tabIndex) {
  final AppointmentController appointmentController =
      Get.find<AppointmentController>();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (appointmentController.pendingQueries.isEmpty &&
        !appointmentController.isLoading.value) {
      appointmentController.fetchQueries();
    }
  });
  return Obx(() {
    // Check if pendingQuery data is loading or empty
    if (appointmentController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (appointmentController.pendingQueries.isEmpty) {
      return const Center(child: Text('No pending appointments'));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: appointmentController.pendingQueries.length,
      itemBuilder: (context, index) {
        final globalIndex = index; // Since we're directly using pendingQueries
        final cropImages = List<String>.from(
          appointmentController.pendingQueries[index]['queryimage'] ?? [],
        );
        final userName =
            appointmentController
                .pendingQueries[index]['farmer_details']?['name'] ??
            'Unknown';
        final cropName =
            appointmentController
                .pendingQueries[index]['crop_details']?['name'] ??
            'Unknown Crop';
        final location =
            appointmentController.pendingQueries[index]['location'] ??
            'Unknown Location';
        final dateTime =
            appointmentController.pendingQueries[index]['appointment_date'] ??
            'Unknown Date';
        final description =
            appointmentController.pendingQueries[index]['query'] ??
            'No description available';
        return GestureDetector(
          onTap: () {
            Get.to(
              AppointmentDetails(),
              arguments: {
                'appointment': appointmentController.pendingQueries[index],
                'globalIndex': globalIndex,
                'tabIndex': tabIndex,
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              boxShadow:  [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 2.5,
                  offset: Offset(0, 2),
                  color: AppColors.containerShadowColor,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColors.green,
                      radius: 20,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                userName,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                appointmentController
                                            .pendingQueries[index]['isFree'] ==
                                        true
                                    ? 'Free'
                                    : 'Paid',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.green,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            location,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.message, color: AppColors.green),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () async {
                        final phoneUri = Uri(
                          scheme: 'tel',
                          path:
                              appointmentController
                                  .pendingQueries[index]['phone'] ??
                              '',
                        );
                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        } else {
                          Get.snackbar('Error', 'Could not launch dialer');
                        }
                      },
                      child: const Icon(Icons.call, color: AppColors.yellow),
                    ),
                  ],
                ),
                 Divider(color: AppColors.primaryGradinatMixColor),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.dialog(buildImagePopUp(globalIndex));
                      },
                      child: SizedBox(
                        width: 80,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 90,
                                autoPlay: cropImages.length > 1,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                              ),
                              items:
                                  cropImages.isEmpty
                                      ? [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: Container(
                                            color: Colors.grey[300],
                                            width: double.infinity,
                                            height: 90,
                                            child: Image.asset(
                                              'assets/images/Null_ticket.png',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ]
                                      : cropImages.map((imagePath) {
                                        // Check if imagePath is a URL (network image)
                                        if (imagePath.startsWith('http') ||
                                            imagePath.startsWith('https')) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Image.network(
                                              imagePath,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => Container(
                                                    color: Colors.grey[300],
                                                    width: double.infinity,
                                                    height: 90,
                                                    child: const Center(
                                                      child: Text(
                                                        'No Image',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                          );
                                        }
                                        // Fallback to asset if not a URL
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: Image.asset(
                                            imagePath,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                                      color: Colors.grey[300],
                                                      width: double.infinity,
                                                      height: 90,
                                                      child: const Center(
                                                        child: Text(
                                                          'No Image',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                          ),
                                        );
                                      }).toList(),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap:
                                  () =>
                                      Get.dialog(buildImagePopUp(globalIndex)),
                              child: Text(
                                'View All',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.error,
                                ),
                              ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  cropName,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                dateTime,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lightGrey,
                            ),
                            child: Text(
                              description,
                              style: GoogleFonts.montserrat(fontSize: 12),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 95,
                                child: CustomGradientButton(
                                  gradientColors: [
                                    AppColors.yellow,
                                    AppColors.yellow,
                                  ],
                                  borderRadius: 10,
                                  text: 'Reject',
                                  onPressed:
                                      () =>
                                          Get.dialog(buildCaution(globalIndex)),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 40,
                                width: 95,
                                child: CustomGradientButton(
                                  borderRadius: 10,
                                  text: 'Accept',
                                  onPressed: () {
                                    appointmentController.acceptAppointment(
                                      globalIndex,
                                    );
                                    Get.toNamed(
                                      '/reply',
                                      arguments: {
                                        'appointment':
                                            appointmentController
                                                .pendingQueries[index],
                                        'globalIndex': globalIndex,
                                        'tabIndex': tabIndex,
                                      },
                                    );
                                  },
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
        );
      },
    );
  });
}

Widget buildAcceptedTab(int tabIndex) {
  final AppointmentController appointmentController =
      Get.find<AppointmentController>();

  return Obx(() {
    final filteredAppointments = appointmentController.getAppointmentsByStatus(
      tabIndex,
      'Accepted',
    );
    if (filteredAppointments.isEmpty) {
      return const Center(child: Text('No accepted appointments'));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointmentData = filteredAppointments[index];
        final globalIndex = appointmentController.appointments.indexWhere(
          (appt) => appt['id'] == appointmentData['id'],
        );
        final cropImages = List<String>.from(
          appointmentData['cropimage'] ?? [],
        );
        final userName = appointmentData['user'] ?? 'Unknown';
        final cropName = appointmentData['cropName'] ?? 'Unknown Crop';
        final location = appointmentData['location'] ?? '1.0 KM • Sector 4L';
        final dateTime = appointmentData['dateTime'] ?? '01 Apr 25, 13:09';
        final description =
            appointmentData['description'] ??
            'Reddish - brown pustules on a wheat stem will turn black as it decays';

        return GestureDetector(
          onTap: () {
            Get.to(
              () => AppointmentDetails(),
              arguments: {
                'appointment': appointmentData,
                'globalIndex': globalIndex,
                'tabIndex': tabIndex,
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              boxShadow:  [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 2.5,
                  offset: Offset(0, 2),
                  color: AppColors.containerShadowColor,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColors.green,
                      radius: 20,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                userName,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                appointmentData['isFree'] == true
                                    ? 'Free'
                                    : 'Paid',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.green,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            location,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.message, color: AppColors.green),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () async {
                        final phoneUri = Uri(
                          scheme: 'tel',
                          path: appointmentData['phone'] ?? '9277103055',
                        );
                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        } else {
                          Get.snackbar('Error', 'Could not launch dialer');
                        }
                      },
                      child: const Icon(Icons.call, color: AppColors.yellow),
                    ),
                  ],
                ),
                 Divider(color: AppColors.primaryGradinatMixColor),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.dialog(buildImagePopUp(globalIndex));
                      },
                      child: SizedBox(
                        width: 80,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 90,
                                autoPlay: cropImages.length > 1,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                              ),
                              items:
                                  cropImages.isEmpty
                                      ? [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: Image.asset(
                                            'assets/images/placeholder.jpg',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ]
                                      : cropImages
                                          .map(
                                            (imagePath) => ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.asset(
                                                imagePath,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Image.asset(
                                                      'assets/images/placeholder.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'View All',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.error,
                              ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  cropName,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                dateTime,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lightGrey,
                            ),
                            child: Text(
                              description,
                              style: GoogleFonts.montserrat(fontSize: 12),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 95,
                                child: CustomGradientButton(
                                  gradientColors: [
                                    AppColors.yellow,
                                    AppColors.yellow,
                                  ],
                                  borderRadius: 10,
                                  text: 'Mark Solved',
                                  onPressed: () {
                                    appointmentController.markAsSolved(
                                      globalIndex,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 40,
                                width: 95,
                                child: CustomGradientButton(
                                  borderRadius: 10,
                                  text: 'Reply',
                                  onPressed:
                                      () => Get.to(
                                        () => Reply(),
                                        arguments: {
                                          'appointment': appointmentData,
                                          'globalIndex': globalIndex,
                                          'tabIndex': tabIndex,
                                        },
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
              ],
            ),
          ),
        );
      },
    );
  });
}

Widget buildConfirmedTab(int tabIndex) {
  final AppointmentController appointmentController =
      Get.find<AppointmentController>();
  return Obx(() {
    final filteredAppointments = appointmentController.getAppointmentsByStatus(
      tabIndex,
      'Confirmed',
    );
    if (filteredAppointments.isEmpty) {
      return const Center(child: Text('No confirmed appointments'));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointmentData = filteredAppointments[index];
        final globalIndex = appointmentController.appointments.indexWhere(
          (appt) => appt['id'] == appointmentData['id'],
        );
        final cropImages = List<String>.from(
          appointmentData['cropimage'] ?? [],
        );
        final userName = appointmentData['user'] ?? 'Unknown';
        final cropName = appointmentData['cropName'] ?? 'Unknown Crop';
        final location = appointmentData['location'] ?? '1.0 KM • Sector 4L';
        final dateTime = appointmentData['dateTime'] ?? '01 Apr 25, 13:09';
        final description =
            appointmentData['description'] ??
            'Reddish - brown pustules on a wheat stem will turn black as it decays';

        return GestureDetector(
          onTap: () {
            Get.to(
              AppointmentDetails(),
              arguments: {
                'appointment': appointmentData,
                'globalIndex': globalIndex,
                'tabIndex': tabIndex,
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              boxShadow:  [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 2.5,
                  offset: Offset(0, 2),
                  color: AppColors.containerShadowColor,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColors.green,
                      radius: 20,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                userName,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                appointmentData['isFree'] == true
                                    ? 'Free'
                                    : 'Paid',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.green,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            location,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.message, color: AppColors.green),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () async {
                        final phoneUri = Uri(
                          scheme: 'tel',
                          path: appointmentData['phone'] ?? '9277103055',
                        );
                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        } else {
                          Get.snackbar('Error', 'Could not launch dialer');
                        }
                      },
                      child: const Icon(Icons.call, color: AppColors.yellow),
                    ),
                  ],
                ),
                 Divider(color: AppColors.primaryGradinatMixColor),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.dialog(buildImagePopUp(globalIndex));
                      },
                      child: SizedBox(
                        width: 80,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 90,
                                autoPlay: cropImages.length > 1,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                              ),
                              items:
                                  cropImages.isEmpty
                                      ? [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: Image.asset(
                                            'assets/images/placeholder.jpg',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ]
                                      : cropImages
                                          .map(
                                            (imagePath) => ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.asset(
                                                imagePath,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Image.asset(
                                                      'assets/images/placeholder.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'View All',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.error,
                              ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  cropName,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                dateTime,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryGradinatMixColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lightGrey,
                            ),
                            child: Text(
                              description,
                              style: GoogleFonts.montserrat(fontSize: 12),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 40,
                            width: 120,
                            child: CustomGradientButton(
                              borderRadius: 10,
                              text: 'Completed',
                              onPressed: () {
                                appointmentController.markAsCompleted(
                                  globalIndex,
                                );
                              },
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
        );
      },
    );
  });
}

Widget buildImagePopUp(int globalIndex) {
  final AppointmentController appointmentController =
      Get.find<AppointmentController>();
  return Obx(() {
    if (globalIndex < 0 ||
        globalIndex >= appointmentController.appointments.length) {
      return const SizedBox();
    }
    final appointmentData = appointmentController.appointments[globalIndex];
    final cropImages = List<String>.from(appointmentData['cropimage'] ?? []);

    return AlertDialog(
      backgroundColor: AppColors.lightGrey.withOpacity(0.8),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: Get.width * 0.9,
        height: 400, // ✅ Give fixed height here
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: AppColors.error),
                onPressed: () => Get.back(),
              ),
            ),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 350,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                ),
                items:
                    cropImages.isEmpty
                        ? [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/placeholder.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ]
                        : cropImages
                            .map(
                              (imagePath) => GestureDetector(
                                onTap:
                                    () => Get.dialog(
                                      Dialog(
                                        backgroundColor: Colors.black,
                                        insetPadding: EdgeInsets.zero,
                                        child: Stack(
                                          children: [
                                            InteractiveViewer(
                                              panEnabled: true,
                                              minScale: 2.0,
                                              maxScale: 3.0,
                                              child: Center(
                                                child: Image.asset(
                                                  imagePath,
                                                  fit: BoxFit.contain,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => Image.asset(
                                                        'assets/images/placeholder.jpg',
                                                        fit: BoxFit.contain,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 20,
                                              right: 20,
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () => Get.back(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    imagePath,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                              'assets/images/placeholder.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget buildCaution(int globalIndex) {
  final AppointmentController appointmentController =
      Get.find<AppointmentController>();
  return AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.error),
          onPressed: () => Get.back(),
        ),
      ],
    ),
    content: SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svgs/alert_triangle.svg',
            color: AppColors.error,
            height: 30,
          ),
          const SizedBox(height: 10),
          Text(
            'Are you sure you want to reject?',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomGradientButton(
              gradientColors: [AppColors.green, AppColors.green],
              height: 35,
              borderRadius: 10,
              text: 'Cancel',
              onPressed: () => Get.back(),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomGradientButton(
              gradientColors: [AppColors.error, AppColors.error],
              height: 35,
              borderRadius: 10,
              text: 'Reject',
              onPressed: () {
                appointmentController.removeAppointment(globalIndex);
                Get.back();
              },
            ),
          ),
        ],
      ),
    ],
  );
}
