import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/home/controllers/appointment_controller.dart';
import 'package:farmitra/app/utils/global_widgets/custom_gradiant_button.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final AppointmentController appointmentController =
        Get.find<AppointmentController>();
    final Map<String, dynamic> arguments = Get.arguments ?? {};
    final Map<String, dynamic> appointmentData = arguments['appointment'] ?? {};
    final int globalIndex = arguments['globalIndex'] ?? -1;
    final int tabIndex = arguments['tabIndex'] ?? -1;

    // Debug print to check incoming arguments
    debugPrint('AppointmentDetails: Arguments = $arguments');

    // Check for valid data
    if (appointmentData.isEmpty || globalIndex < 0) {
      return const Scaffold(
        appBar: VendorAppBar(title: 'Appointment Details'),
        body: Center(child: Text('No appointment data available')),
      );
    }

    // Extract data with null safety
    final cropImages = List<String>.from(appointmentData['queryimage'] ?? []);
    final userName =
        appointmentData['farmer_details']?['name'] as String? ?? 'Unknown';
    final cropName =
        appointmentData['crop_details']?['name'] as String? ?? 'Unknown';
    final location =
        appointmentData['location'] as String? ?? 'Unknown Location';
    final dateTime =
        appointmentData['appointment_date'] as String? ?? 'Unknown Date';
    final description =
        appointmentData['query'] as String? ?? 'No description available';
    final isFree = appointmentData['isFree'] == true ? 'Free' : 'Paid';
    final phone =
        appointmentData['phone'] as String? ??
        '9277103055'; // Consider validating this default

    // Debug print to check appointment data
    debugPrint('AppointmentDetails: Appointment Data = $appointmentData');

    // Map status integer to display string
    String getStatusString(dynamic apiStatus) {
      if (apiStatus is int) {
        switch (globalIndex) {
          case 1:
            return 'Pending';
          case 2:
            return 'Accepted';
          case 3:
            return 'Confirmed';
          default:
            return 'Unknown';
        }
      }
      return apiStatus?.toString() ?? 'Unknown';
    }

    // Determine status for display and logic
    final displayStatus = appointmentData['query_status'];
    final int status =
        int.tryParse(appointmentData['status']?.toString() ?? '0') ?? 0;

    return Scaffold(
      appBar: const VendorAppBar(title: 'Appointment Details'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.green,
                    radius: 30,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          isFree,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.green,
                          ),
                        ),
                        Text(
                          location,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.message, color: AppColors.green),
                    onPressed:
                        () => Get.toNamed(
                          '/reply',
                          arguments: {
                            'appointment': appointmentData,
                            'globalIndex': globalIndex,
                            'tabIndex': tabIndex,
                          },
                        ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.call, color: AppColors.yellow),
                    onPressed: () async {
                      final phoneUri = Uri(scheme: 'tel', path: phone);
                      try {
                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        } else {
                          Get.snackbar('Error', 'Could not launch dialer');
                        }
                      } catch (e) {
                        Get.snackbar('Error', 'Failed to launch dialer: $e');
                      }
                    },
                  ),
                ],
              ),
            ),
             Divider(color: AppColors.primaryGradinatMixColor),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Text(
                    'Crop: $cropName',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Date & Time: $dateTime',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryGradinatMixColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items:
                  cropImages.isEmpty
                      ? [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.grey[300],
                            width: double.infinity,
                            height: 200,
                            child: Image.asset(
                              'assets/images/Null_ticket.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ]
                      : cropImages.map((imagePath) {
                        // Check if imagePath is a network URL
                        if (imagePath.startsWith('http') ||
                            imagePath.startsWith('https')) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              imagePath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder:
                                  (context, error, stackTrace) => Container(
                                    color: Colors.grey[300],
                                    width: double.infinity,
                                    height: 200,
                                    child: const Center(
                                      child: Text(
                                        'No Image',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                            ),
                          );
                        }
                        // Fallback to asset for local paths
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  color: Colors.grey[300],
                                  width: double.infinity,
                                  height: 200,
                                  child: const Center(
                                    child: Text(
                                      'No Image',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                          ),
                        );
                      }).toList(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Description',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Status: $displayStatus',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lightGrey,
              ),
              child: Text(
                description,
                style: GoogleFonts.montserrat(fontSize: 14),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 75,
        child: Builder(
          builder: (_) {
            debugPrint(
              'AppointmentDetails: query_status = ${appointmentData['query_status']}, displayStatus = $displayStatus',
            );
            debugPrint(
              'AppointmentDetails: status = $status, type = ${appointmentData['status'].runtimeType}',
            );
            if (tabIndex == 1) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomGradientButton(
                      gradientColors: [AppColors.yellow, AppColors.yellow],
                      borderRadius: 10,
                      text: 'Reject',
                      onPressed:
                          () => Get.dialog(
                            buildCaution(globalIndex, appointmentController),
                          ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomGradientButton(
                      borderRadius: 10,
                      text: 'Accept',
                      onPressed: () {
                        appointmentController.acceptAppointment(globalIndex);
                        Get.toNamed(
                          '/reply',
                          arguments: {
                            'appointment': appointmentData,
                            'globalIndex': globalIndex,
                            'tabIndex': tabIndex,
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (tabIndex == 2) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomGradientButton(
                      gradientColors: [AppColors.yellow, AppColors.yellow],
                      borderRadius: 10,
                      text: 'Mark Solved',
                      onPressed: () {
                        appointmentController.markAsSolved(globalIndex);
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomGradientButton(
                      borderRadius: 10,
                      text: 'Reply',
                      onPressed:
                          () => Get.toNamed(
                            '/reply',
                            arguments: {
                              'appointment': appointmentData,
                              'globalIndex': globalIndex,
                              'tabIndex': tabIndex,
                            },
                          ),
                    ),
                  ),
                ],
              );
            } else if (tabIndex == 3) {
              return Center(
                child: CustomGradientButton(
                  borderRadius: 10,
                  text: 'Mark Completed',
                  onPressed: () {
                    appointmentController.markAsCompleted(globalIndex);
                    Get.back();
                  },
                ),
              );
            } else {
              return Center(
                child: Text(
                  'No actions available (Status: $displayStatus)',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget buildCaution(int globalIndex, AppointmentController controller) {
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
    content: const SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Text(
            'Are you sure you want to reject?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
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
                controller.removeAppointment(globalIndex);
                Get.back();
              },
            ),
          ),
        ],
      ),
    ],
  );
}
