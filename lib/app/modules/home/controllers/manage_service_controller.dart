import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageServiceController extends GetxController
    with GetTickerProviderStateMixin {
  final count = 0.obs;
  late TabController twoTabController;
  @override
  void onInit() {
    super.onInit();
    twoTabController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  final List<String> imagePaths = [
    'assets/images/tractor.jpg',
    'assets/images/tractor.jpg',
    'assets/images/tractor.jpg',
  ];

  final onlineConsultationFee = TextEditingController();
  final bookingFee = TextEditingController();
  final onlineFollowUp = TextEditingController();
  final offlineConsultationFee = TextEditingController();
  final offlineFollowUp = TextEditingController();
  final maxServiceDistance = TextEditingController();
  var time1 = "09:00 AM".obs;
  var time2 = "06:00 PM".obs;

  // Future<void> selectTime(BuildContext context, RxString time) async {
  //   TimeOfDay initialTime = _parseTime(time.value);
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: initialTime,
  //   );
  //   if (picked != null) {
  //     time.value = _formatTime(picked);
  //   }
  // }

  List<String> weeks = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  var selectedIndices = <int>[].obs; // Empty initially (No pre-selected days)

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index); // Deselect if already selected
    } else {
      selectedIndices.add(index); // Select if not already selected
    }
  }

  var timeFields = <RxString>[].obs; // List to store time values
  var timeControllers = <TextEditingController>[].obs; // List of controllers

  TimeOfDay _parseTime(String time) {
    final RegExp timeRegex = RegExp(r"(\d+):(\d+) (AM|PM)");
    final match = timeRegex.firstMatch(time);
    if (match != null) {
      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      String period = match.group(3)!;
      if (period == "PM" && hour != 12) hour += 12;
      if (period == "AM" && hour == 12) hour = 0;
      return TimeOfDay(hour: hour, minute: minute);
    }
    return TimeOfDay(hour: 9, minute: 0);
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }

  // var timeFields = <RxString>[].obs;
  void addNewTimeField() {
    if (timeFields.length < 6) {
      // Limit number of time fields
      timeFields.addAll(["".obs, "".obs]);
      timeControllers.addAll([
        TextEditingController(),
        TextEditingController(),
      ]);
    }
  }

  void removeTimeField(int index) {
    if (timeFields.length > 2) {
      timeFields.removeRange(index, index + 2);
      timeControllers.removeRange(index, index + 2);
    }
  }

  void selectTime(BuildContext context, int index) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      timeFields[index].value = formattedTime;
      timeControllers[index].text = formattedTime; // Update controller text
    }
  }

  var selectedItem = ''.obs;
  var isDropdownValid = true.obs;
  List<String> bankDetails = ['Cutting ', 'Flowing', 'Transport'];
  void updatedSelectedValue(String value) {
    selectedItem.value = value;
    isDropdownValid.value = true; // Reset validation when an item is selected
  }

  bool validateDropdown() {
    if (selectedItem.value.isEmpty) {
      isDropdownValid.value = false;
      return false;
    }
    return true;
  }
}
