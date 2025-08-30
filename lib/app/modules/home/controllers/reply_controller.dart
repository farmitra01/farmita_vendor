import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

enum UploadType { image, pdf, video, none }

class ReplyController extends GetxController {
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
    reply.dispose();
    videoController.value?.dispose();
    super.onClose();
  }

  final List<String> imagePaths = [
    'assets/images/damage_leaves_01.jpg',
    'assets/images/damage_leaves_02.jpg',
    'assets/images/damage_leaves_03.jpg',
  ];
  var reply = TextEditingController();

  // var selectedImage = Rx<File?>(
  //   null,
  // ); // Reactive variable to track selected image

  // final ImagePicker _picker = ImagePicker();

  // Future<void> pickImage(ImageSource source) async {
  //   final XFile? pickedFile = await _picker.pickImage(source: source);

  //   if (pickedFile != null) {
  //     selectedImage.value = File(pickedFile.path); // Update reactive variable
  //   }
  // }

  // var reply = TextEditingController();
  // var isAdded = false.obs;
  var selectedFile = Rxn<File>();
  var fileType = UploadType.none.obs;
  var videoController = Rx<VideoPlayerController?>(null);
  // var imagePaths = ['assets/images/product1.png', 'assets/images/product2.png'];

void increment() => count.value++;

  RxList<int> quantities = List.filled(20, 0).obs;
  void incrementQuantity(int index) {
    quantities[index]++;
  }

  void decrementQuantity(int index) {
    if (quantities[index] > 0) {
      quantities[index]--;
    }
  }



  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source); // 5MB limit
    if (pickedFile != null) {
      selectedFile.value = File(pickedFile.path);
      fileType.value = UploadType.image;
    }
  }

  Future<void> pickPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      selectedFile.value = File(result.files.single.path!);
      fileType.value = UploadType.pdf;
    }
  }

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedFile.value = File(pickedFile.path);
      fileType.value = UploadType.video;
      videoController.value = VideoPlayerController.file(selectedFile.value!)
        ..initialize().then((_) {
          videoController.refresh();
        });
    }
  }



}
