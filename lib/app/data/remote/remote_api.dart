import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final storage =GetStorage().read('usertoken');

  final token = 'https://api.farmitra.in/api/expert/get-crop-diagnosis-queries';

  Future<Map<String, dynamic>?> getDashboardOverview() async {
    final token = storage.read('token');  // read saved token
    if (token == null) {
      Get.snackbar('Error', 'Token not found, please login again');
      return null;
    }

    final url = Uri.parse('https://api.farmitra.in/api/expert/get-overview');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Parse and return JSON body as Map
      return json.decode(response.body);
    } else {
      Get.snackbar('Error', 'Failed to load dashboard overview');
      return null;
    }
  }

}
