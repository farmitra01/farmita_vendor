import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewContactController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    isRecentCheckedList
        .assignAll(List.generate(contactList.length, (index) => false.obs));
    isAllCheckedList
        .assignAll(List.generate(contactList.length, (index) => false.obs));

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var search = TextEditingController();
  var isRecentCheckedList = List.generate(10, (index) => false.obs).obs;
  var isAllCheckedList = List.generate(10, (index) => false.obs).obs;

  var ischecked = false.obs;

  final List<Map<String, dynamic>> contactList = [
    {'Name': 'Saurabh', 'Number': '7895333202'},
    {'Name': 'Pratik', 'Number': '9895333202'},
    {'Name': 'Aman', 'Number': '9889649343'},
    {'Name': 'Ashish', 'Number': '8808247526'},
    {'Name': 'Prince', 'Number': '9170117549'},
    {'Name': 'Vishal', 'Number': '8923851561'},
    {'Name': 'Rahul', 'Number': '7398308395'},
    {'Name': 'Navin', 'Number': '8115559629'},
  ].obs;

   List<Map<String, String>> getSelectedContacts() {
var selectedContacts = <Map<String, String>>[].obs;

  for (int i = 0; i < contactList.length; i++) {
    if (isRecentCheckedList[i].value || isAllCheckedList[i].value) {
      selectedContacts.add({
        'Name': contactList[i]['Name'].toString(), 
        'Number': contactList[i]['Number'].toString()
      });
    }
  }
  return selectedContacts;
}
}
