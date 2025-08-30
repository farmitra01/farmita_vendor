import 'package:farmitra/app/ApiModels/get-farmer-query-by-status_pending_model.dart';
import 'package:farmitra/app/modules/home/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController
  tabController; // Main tabs: Online Consultation, Farm Visit
  late TabController consultationTabController; // Online Consultation sub-tabs
  late TabController farmVisitTabController; // Farm Visit sub-tabs
  late TabController
  threeTabController; // Status tabs: Pending, Accepted, Confirmed

  final appointments =
      <Map<String, dynamic>>[
        {
          'id': '1',
          'user': 'Amit Singh',
          'cropName': 'Wheat',
          'cropimage': [
            'assets/images/damage_leaves_01.jpg',
            'assets/images/damage_leaves_02.jpg',
            'assets/images/damage_leaves_03.jpg',
          ],
          'location': '1.0 KM • Sector 4L',
          'dateTime': '01 Apr 25, 13:09',
          'description': 'Reddish-brown pustules on wheat stem turning black.',
          'isFree': true,
          'phone': '9277103055',
          'status': 'Pending',
          'type': 'Online Consultation',
          'category': 'Appointment',
        },
        {
          'id': '2',
          'user': 'Ram Kamal Yadav',
          'cropName': 'Paddy',
          'cropimage': [
            'assets/images/Null_ticket.png',
            'assets/images/Null_ticket.png',
            'assets/images/Null_ticket.png',
          ],
          'location': '2.5 KM • Sector 5M',
          'dateTime': '02 Apr 25, 10:30',
          'description': 'Yellowing leaves with brown spots.',
          'isFree': false,
          'phone': '9277103056',
          'status': 'Accepted',
          'type': 'Farm Visit',
          'category': 'Disease',
        },
        {
          'id': '3',
          'user': 'Shailesh Yadav',
          'cropName': 'Sugarcane',
          'cropimage': [
            'assets/images/damage_leaves_01.jpg',
            'assets/images/damage_leaves_02.jpg',
            'assets/images/damage_leaves_03.jpg',
          ],
          'location': '3.0 KM • Sector 6N',
          'dateTime': '03 Apr 25, 15:45',
          'description': 'Wilting stalks with discolored leaves.',
          'isFree': true,
          'phone': '9277103057',
          'status': 'Confirmed',
          'type': 'Online Consultation',
          'category': 'Farm Advisory',
        },
        {
          'id': '4',
          'user': 'Subham Rawat',
          'cropName': 'Wheat',
          'cropimage': [
            'assets/images/damage_leaves_01.jpg',
            'assets/images/damage_leaves_02.jpg',
            'assets/images/damage_leaves_03.jpg',
          ],
          'location': '1.5 KM • Sector 7P',
          'dateTime': '04 Apr 25, 09:00',
          'description': 'Powdery mildew on leaves.',
          'isFree': false,
          'phone': '9277103058',
          'status': 'Pending',
          'type': 'Farm Visit',
          'category': 'Appointment',
        },
        {
          'id': '5',
          'user': 'Radhe Kishan',
          'cropName': 'Wheat',
          'cropimage': [
            'assets/images/damage_leaves_01.jpg',
            'assets/images/damage_leaves_02.jpg',
            'assets/images/damage_leaves_03.jpg',
          ],
          'location': '2.0 KM • Sector 8Q',
          'dateTime': '05 Apr 25, 14:20',
          'description': 'Stunted growth with yellowing tips.',
          'isFree': true,
          'phone': '9277103059',
          'status': 'Accepted',
          'type': 'Online Consultation',
          'category': 'Disease',
        },
      ].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    consultationTabController = TabController(length: 3, vsync: this);
    farmVisitTabController = TabController(length: 3, vsync: this);
    threeTabController = TabController(length: 3, vsync: this);
    fetchQueries();
  }

  @override
  void onClose() {
    tabController.dispose();
    consultationTabController.dispose();
    farmVisitTabController.dispose();
    threeTabController.dispose();
    super.onClose();
  }

  List<Map<String, dynamic>> getFilteredAppointments(int tabIndex) {
    String type;
    String category;

    switch (tabIndex) {
      case 1:
        type = 'Online Consultation';
        category = 'Appointment';
        break;
      case 2:
        type = 'Online Consultation';
        category = 'Disease';
        break;
      case 3:
        type = 'Online Consultation';
        category = 'Farm Advisory';
        break;
      case 4:
        type = 'Farm Visit';
        category = 'Appointment';
        break;
      case 5:
        type = 'Farm Visit';
        category = 'Disease';
        break;
      case 6:
        type = 'Farm Visit';
        category = 'Farm Advisory';
        break;
      default:
        return [];
    }

    return appointments
        .where(
          (appointment) =>
              appointment['type'] == type &&
              appointment['category'] == category,
        )
        .toList();
  }

  List<Map<String, dynamic>> getAppointmentsByStatus(
    int tabIndex,
    String status,
  ) {
    final filteredAppointments = getFilteredAppointments(tabIndex);
    return filteredAppointments
        .where((appointment) => appointment['status'] == status)
        .toList();
  }

  void acceptAppointment(int globalIndex) {
    if (globalIndex >= 0 && globalIndex < appointments.length) {
      appointments[globalIndex]['status'] = 'Accepted';
      appointments.refresh();
      Get.snackbar('Success', 'Appointment accepted');
    }
  }

  void markAsSolved(int globalIndex) {
    if (globalIndex >= 0 && globalIndex < appointments.length) {
      appointments[globalIndex]['status'] = 'Confirmed';
      appointments.refresh();
      Get.snackbar('Success', 'Appointment marked as solved');
    }
  }

  void markAsCompleted(int globalIndex) {
    if (globalIndex >= 0 && globalIndex < appointments.length) {
      appointments[globalIndex]['status'] = 'Completed';
      appointments.refresh();
      Get.snackbar('Success', 'Appointment marked as completed');
    }
  }

  void removeAppointment(int globalIndex) {
    if (globalIndex >= 0 && globalIndex < appointments.length) {
      appointments.removeAt(globalIndex);
      appointments.refresh();
      Get.snackbar('Success', 'Appointment rejected and removed');
    }
  }

  int getTabCount(int tabIndex, String category) {
    return getFilteredAppointments(tabIndex).length;
  }

  //Api Function
  final HomeService apiService;

  // Observable list to hold the fetched queries
  var pendingQueries = <dynamic>[].obs;

  // Loading state
  var isLoading = false.obs;

  // Error message state
  var errorMessage = ''.obs;

  AppointmentController({required this.apiService});

  void fetchQueries() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final data = await apiService.fetchQueries();
      pendingQueries.value = data;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
