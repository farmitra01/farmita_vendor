import 'package:get/get.dart';

class HelpCenterController extends GetxController {
  //TODO: Implement HelpCenterController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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

  List<Map<String, dynamic>> listData = [
    {
      'image': 'assets/icons/call.svg',
      'title': 'Call & Email Support',
      'SubTitle': 'Chat with Our Support Team for Quick Answers',
    },
    {
      'image': 'assets/icons/message.svg',
      'title': 'Raise Concerns',
      'SubTitle': 'Get Immediate Assistance Over the Phone',
    },

    {
      'image': 'assets/svgs/FAQ.svg',
      'title': 'FAQS',
      'SubTitle': 'Explore Our Knowledge Base for Solutions',
    },
    {
      'image': 'assets/icons/videotutorial.svg',
      'title': 'Video Tutorial',
      'SubTitle': 'Watch Step-by-Step Guides to Resolve Issues',
    },
  ];
}
