import 'dart:io';
import 'package:farmitra/app/ApiModels/getRegistrationCrousel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:farmitra/app/constants/api_endpoints.dart';
import 'package:farmitra/app/services/network_services.dart';
import 'package:farmitra/app/data/models/registration_model/registration_model.dart';

class RegistrationController extends GetxController {
  final ApiService _apiService = ApiService();
  final GetStorage box = GetStorage(); // ✅ Added

  var isLoading = false.obs;
  var isVideoPlaying = false.obs;

  var mediaList = <MediaData>[].obs;
  var youtubeControllers = <YoutubePlayerController>[].obs;

  var currentStep = 0.obs;
  var items = <Registration_Model>[].obs;
  var currentIndex = 0.obs;

  List<Registration_Model> stepperContent = [
    Registration_Model(
      title: "Profile Validation",
      subtitle: "Validate your profile using your mobile no.",
      imagePath: "assets/icons/registration_stepper_icons/profile.svg",
    ),
    Registration_Model(
      title: "Business Details",
      subtitle: "Provide basic details about your Business",
      imagePath: "assets/icons/registration_stepper_icons/store.svg",
    ),
    Registration_Model(
      title: "K.Y.C.",
      subtitle: "Legal documentations about you & your business",
      imagePath: "assets/icons/registration_stepper_icons/kyc.svg",
    ),
    Registration_Model(
      title: "Bank Details",
      subtitle: "Payment receiving details",
      imagePath: "assets/icons/registration_stepper_icons/bank.svg",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // ✅ Load saved step on init
    int savedStep = box.read('last_registration_step') ?? 0;
    currentStep.value = savedStep;
  }

  @override
  void onReady() {
    super.onReady();
    fetchRegistrationMedia();
  }

  @override
  void onClose() {
    for (final controller in youtubeControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  // ✅ Save step when user taps a step
  void setStep(int stepIndex) {
    currentStep.value = stepIndex;
    box.write('last_registration_step', stepIndex);
  }

  Future<void> fetchRegistrationMedia() async {
    try {
      isLoading.value = true;

      final response = await _apiService.callApi(
        endpoint:
            '${ApiEndpoints.fetchRegistrationMedia}?category=registration',
        method: 'GET',
      );

      final innerData = response['data'];

      if (innerData != null &&
          innerData['success'] == true &&
          innerData['data'] is List) {
        final List data = innerData['data'];

        final parsedMediaList =
            data
                .whereType<Map<String, dynamic>>()
                .map((item) => MediaData.fromJson(item))
                .toList();

        mediaList.assignAll(parsedMediaList);

        for (final controller in youtubeControllers) {
          controller.dispose();
        }
        youtubeControllers.clear();

        for (final media in parsedMediaList) {
          if (media.videoLink != null && media.videoLink!.isNotEmpty) {
            final videoId = YoutubePlayer.convertUrlToId(media.videoLink!);
            if (videoId != null) {
              final ytController = YoutubePlayerController(
                initialVideoId: videoId,
                flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
              );

              ytController.addListener(() {
                final isPlaying = ytController.value.isPlaying;
                if (isVideoPlaying.value != isPlaying) {
                  isVideoPlaying.value = isPlaying;
                }
              });

              youtubeControllers.add(ytController);
            }
          } else {
            youtubeControllers.add(
              YoutubePlayerController(
                initialVideoId: '',
                flags: const YoutubePlayerFlags(autoPlay: false),
              ),
            );
          }
        }
      } else {
        print('❌ Unexpected response format');
      }
    } catch (e) {
      print('❌ Error: $e');
      Get.snackbar('Error', 'Failed to fetch registration media');
    } finally {
      isLoading.value = false;
    }
  }
}
