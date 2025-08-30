import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';

class ApiService {
  static const Duration timeoutDuration = Duration(seconds: 30);

  String? _getToken() {
    return GetStorage().read('user_token');
  }

  Future<Map<String, dynamic>> callApi({
    required String endpoint,
    String method = 'GET',
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
    Map<String, dynamic>? formData,
    Map<String, File>? fileMap,
    String fileFieldName = 'image',
    bool isMultipart = false,
    bool requireAuth = true,
  }) async {
    try {
      Uri uri = Uri.parse(ApiEndpoints.getFullUrl(endpoint));

      if (queryParams != null) {
        uri = uri.replace(queryParameters: queryParams);
      }

      // Base headers
      final requestHeaders = <String, String>{'Accept': 'application/json'};

      // Add token if required
      if (requireAuth) {
        final token = _getToken();
        if (token != null) {
          requestHeaders['Authorization'] = 'Bearer $token';
        }
      }

      // Add content type for non-multipart requests with a body
      if (!isMultipart && body != null) {
        requestHeaders['Content-Type'] = 'application/json';
      }

      // Add any custom headers passed in
      if (headers != null) {
        requestHeaders.addAll(headers);
      }

      http.Response response;

      if (method.toUpperCase() == 'POST' && isMultipart) {
        var request = http.MultipartRequest('POST', uri);
        request.headers.addAll(requestHeaders);

        if (formData != null) {
          formData.forEach((key, value) {
            if (value is List) {
              // For list values like subcategories: [1, 2]
              for (int i = 0; i < value.length; i++) {
                request.fields['$key[$i]'] = value[i].toString();
              }
            } else {
              request.fields[key] =
                  value.toString(); // Safely convert dynamic to String
            }
          });
        }

        if (fileMap != null) {
          for (final entry in fileMap.entries) {
            request.files.add(
              await http.MultipartFile.fromPath(entry.key, entry.value.path),
            );
          }
        }

        final streamedResponse = await request.send().timeout(
          ApiService.timeoutDuration,
        );
        response = await http.Response.fromStream(streamedResponse);
      } else {
        final client = http.Client();
        try {
          switch (method.toUpperCase()) {
            case 'GET':
              response = await client
                  .get(uri, headers: requestHeaders)
                  .timeout(ApiService.timeoutDuration);
              break;
            case 'POST':
              response = await client
                  .post(
                    uri,
                    headers: requestHeaders,
                    body: body != null ? jsonEncode(body) : null,
                  )
                  .timeout(ApiService.timeoutDuration);
              break;
            case 'PUT':
              response = await client
                  .put(
                    uri,
                    headers: requestHeaders,
                    body: body != null ? jsonEncode(body) : null,
                  )
                  .timeout(ApiService.timeoutDuration);
              break;
            case 'DELETE':
              response = await client
                  .delete(
                    uri,
                    headers: requestHeaders,
                    body: body != null ? jsonEncode(body) : null,
                  )
                  .timeout(ApiService.timeoutDuration);
              break;
            case 'PATCH':
              response = await client
                  .patch(
                    uri,
                    headers: requestHeaders,
                    body: body != null ? jsonEncode(body) : null,
                  )
                  .timeout(ApiService.timeoutDuration);
              break;
            default:
              throw Exception('Unsupported HTTP method: $method');
          }
        } finally {
          client.close();
        }
      }

      dynamic responseBody;
      try {
        responseBody =
            response.body.isNotEmpty ? json.decode(response.body) : {};
      } catch (_) {
        responseBody = response.body;
      }

      debugPrint('Request URL: $uri');
      debugPrint('Request Method: $method');
      debugPrint('Request Headers: $requestHeaders');
      debugPrint('Response Status: ${response.statusCode}');
      debugPrint('Response Body: $responseBody');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'success': true,
          'data': responseBody,
          'statusCode': response.statusCode,
        };
      } else {
        final message = responseBody['message']?.toString().toLowerCase() ?? '';

        if (message.contains('unauthenticated') ||
            message.contains('token') ||
            response.statusCode == 401) {
          print('Log in to use all features of the Farmitra App.');
          // Get.snackbar(
          //   'Log In Required',
          //   'Log in to use all features of the Farmitra App.',
          //   snackPosition: SnackPosition.BOTTOM,
          //   backgroundColor: AppColors.error,
          //   colorText: AppColors.white,
          // );
        } else {
          debugPrint('Notice ${responseBody['message']}');
          // Get.snackbar(
          //   'Noticess',
          //   responseBody['message'] ?? '',
          //   snackPosition: SnackPosition.BOTTOM,
          //   backgroundColor: AppColors.error,
          //   colorText: AppColors.white,
          // );
        }

        return {
          'success': false,
          'data': responseBody,
          'statusCode': response.statusCode,
        };
      }
    } on TimeoutException {
      Get.snackbar(
        'Error',
        'Request timed out. Please check your connection.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
      return {'success': false, 'error': 'Timeout', 'statusCode': null};
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
      return {'success': false, 'error': e.toString(), 'statusCode': null};
    }
  }
}
