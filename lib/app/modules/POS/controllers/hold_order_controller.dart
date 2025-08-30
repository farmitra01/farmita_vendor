import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HoldOrderController extends GetxController {
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

  List<Map<String, dynamic>> holdOrder = [
    {'user': 'Subham Rawat'},
    {'user': '873709712'},
    {'user': '+Add Contact'},
  ].obs;

  var holdOrderList = <Map<String, dynamic>>[].obs;

  void removeOrder(int index) {
    holdOrder.removeAt(index);
  }

  Future<void> shareOnWhatsApp(String phoneNumber, String message) async {
    try {
      // Format phone number
      final formattedNumber =
          phoneNumber.replaceAll(RegExp(r'\s+|-|\(|\)'), '');

      // Encode message
      final encodedMessage = Uri.encodeComponent(message);

      // Use the web URL format
      final uri = Uri.parse(
          'https://api.whatsapp.com/send?phone=$formattedNumber&text=$encodedMessage');

      await launchUrl(
        uri,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to open WhatsApp');
    }
  }

// Future<void> shareOnWhatsApp(String phoneNumber, String message) async {
//   try {
//     final encodedMessage = Uri.encodeComponent(message);
//     final url = 'https://wa.me/$phoneNumber?text=$encodedMessage';

//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url));
//     } else {
//       Get.snackbar('Error', 'Could not launch WhatsApp');
//     }
//   } catch (e) {
//     Get.snackbar('Error', 'Failed to share via WhatsApp: ${e.toString()}');
//   }
// }
}
