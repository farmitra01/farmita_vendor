import 'package:farmitra/app/ApiModels/addExpertQuery.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class ChatController extends GetxController {
  //TODO: Implement ChatController

  final count = 0.obs;
  final messages = <ChatMessage>[].obs;
  final textController = TextEditingController();
  final scrollController = ScrollController();
  final selectedIndex = 3.obs; // bottom nav selected (Ai Expert index)
  final box = GetStorage();
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    // Prepopulate with AI message that resembles your screenshot
    messages.add(
      ChatMessage(
        isUser: false,
        title: "Farmitra IQ",
        text:
            "नमस्कार! 😊 मैं Farmitra AI हूँ, आपका कृषि विशेषज्ञ मित्र। 🌾🤖\n\nकृषि संबंधित समस्याओं के लिए आप यहां अपने सवाल पूछ सकते हैं 🙏",
      ),
    );
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

  void sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    // Add user message
    messages.add(ChatMessage(isUser: true, text: text));
    textController.clear();
    _scrollToEnd();

    // Call API for AI response
    await addExpertQuery(text);
  }

  Future<void> addExpertQuery(String query) async {
    try {
      print('🔄 Starting addExpertQuery...');

      // Validate query input
      if (query.trim().isEmpty) {
        print('❌ Query is empty.');
        Get.snackbar(
          'Error',
          'Query is required.',
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
        );
        return;
      }

      // Retrieve token from storage
      final token = box.read('user_token');

      if (token == null || token.isEmpty) {
        print('❌ Token is missing.');
        Get.snackbar(
          'Error',
          'Login required. Please try again.',
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
        );
        return;
      }

      // Construct request body
      final Map<String, dynamic> requestBody = {'query': query.trim()};

      print('📤 Sending to: ${ApiEndpoints.addExpertQuery}');
      print('📨 RequestBody: $requestBody');
      print('📨 Encoded JSON: ${json.encode(requestBody)}');

      // Make API call
      final response = await _apiService.callApi(
        endpoint: ApiEndpoints.addExpertQuery,
        method: 'POST',
        body: requestBody,
        requireAuth: true,
        isMultipart: false,
      );

      print('✅ API Response: $response');

      // Parse response using ChatApiResponse model
      final chatResponse = ChatApiResponse.fromJson(response);

      // Debug parsed response
      print('🖥️ Parsed Response: response=${chatResponse.response}, products=${chatResponse.products.length}, model=${chatResponse.model}');
      print('🖥️ Messages before adding: ${messages.length}');

      if (response['success'] == true) {
        // Process response to extract heading (text between **) and body
        String responseText = chatResponse.response.isNotEmpty
            ? chatResponse.response
            : 'No response text received from AI.';
        String heading = '';
        String body = responseText;

        // Extract heading if it starts with **...**
        final headingMatch = RegExp(r'\*\*(.*?)\*\*').firstMatch(responseText);
        if (headingMatch != null) {
          heading = headingMatch.group(1)!.trim(); // Text between **
          body = responseText.replaceFirst(headingMatch[0]!, '').trim(); // Remove heading and **
        }

        // Add AI response to messages
        messages.add(
          ChatMessage(
            isUser: false,
            title: "Farmitra IQ",
            text: body,
            heading: heading.isNotEmpty ? heading : null,
          ),
        );
        print('🖥️ Added message: heading=$heading, body=$body');
        print('🖥️ Messages after adding: ${messages.length}');
        _scrollToEnd();

        // Get.snackbar(
        //   'Success',
        //   chatResponse.response,
        //   backgroundColor: AppColors.primaryGradinatMixColor,
        //   colorText: AppColors.white,
        // );

        // Store response if needed
        // box.write('chat_response', response);
      } else {
        final errorMsg =
            chatResponse.response.isNotEmpty
                ? chatResponse.response
                : 'Failed to process query';
        Get.snackbar(
          'Error',
          errorMsg,
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
        );
        // Add error message to UI
        messages.add(
          ChatMessage(
            isUser: false,
            title: "Farmitra IQ",
            text: errorMsg,
          ),
        );
        print('🖥️ Added error message: $errorMsg');
        _scrollToEnd();
      }
    } catch (e) {
      print('❗ Exception occurred: $e');
      Get.snackbar(
        'Error',
        'Exception: $e',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
      // Add fallback AI message in case of error
      messages.add(
        ChatMessage(
          isUser: false,
          title: "Farmitra IQ",
          text: "क्षमा करें, कुछ त्रुटि हुई। कृपया पुनः प्रयास करें।",
        ),
      );
      print('🖥️ Added fallback message');
      _scrollToEnd();
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void changeTab(int idx) => selectedIndex.value = idx;
}

class ChatMessage {
  final bool isUser;
  final String? title; // for AI (Farmitra IQ)
  final String text;
  final String? heading; // New field for bold heading

  ChatMessage({
    required this.isUser,
    this.title,
    required this.text,
    this.heading,
  });
}