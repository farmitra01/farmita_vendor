import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as https;
import 'package:farmitra/app/ApiModels/get-farmer-query-by-status_pending_model.dart';

class HomeService {
  final String token = GetStorage().read('user_token');
  //  '485|WPPaDBgC0Dim2aeRVPhW4hEJmKLU4Wsbdk1yZY1Z2395a871';

  Future<List<dynamic>> fetchQueries() async {
    final url = Uri.parse(
      'https://api.farmitra.in/api/expert/get-farmer-query-by-status?query_status=1&query_type=1',
    ); // Replace with your actual URL

    try {
      final response = await https.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('stored token ${token}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          List<dynamic> data = jsonResponse['data'];
          return data;
        } else {
          throw Exception('API returned success = false');
        }
      } else {
        throw Exception('Server returned status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching queries: $e');
      rethrow;
    }
  }

  Future<List<dynamic>> fetchAcceptdQueries() async {
    final url = Uri.parse(
      'https://api.farmitra.in/api/expert/get-farmer-query-by-status?query_status=2',
    ); // Replace with your actual URL

    try {
      final response = await https.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          // Assuming 'data' is a list of queries
          List<dynamic> data = jsonResponse['data'];
          return data;
        } else {
          throw Exception('API returned success = false');
        }
      } else {
        throw Exception('Server returned status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching queries: $e');
      rethrow; // Let caller handle it too if needed
    }
  }
}
