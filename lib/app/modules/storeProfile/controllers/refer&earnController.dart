import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReferEarnController extends GetxController {
  //TODO: Implement ReferEarnController
  final String referralCode = "ABCDG123";

  Future<void> shareReferralWithImage() async {
    try {
      // Load the image from the assets folder
      final ByteData byteData =  
          await rootBundle.load('assets/images/banner_promo.png');
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/farmitra_referral.jpg');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      // Share the image with referral message
      await Share.shareXFiles(
        [XFile(file.path)],
        text: '''
प्रिय किसान मित्र,
Farmitra ऐप के माध्यम से जुड़ें और खेती को और भी आसान बनाएं! आपका रेफरल कोड $referralCode का उपयोग करें और Farmitra के साथ जुड़ने पर आपको और आपके दोस्त को आकर्षक इनाम मिलेंगे।

Farmitra के साथ आपको मिलेगा:
- फसल की सही जानकारी
- कृषि विशेषज्ञों से सलाह
- बाजार मूल्य अपडेट
- और भी बहुत कुछ!

अभी डाउनलोड करें !
साथ मिलकर स्मार्ट खेती की ओर कदम बढ़ाएं। 🌾
#Farmitra #SmartFarming
      ''',
      );
    } catch (e) {
      print("Error sharing referral: $e");
    }
  }

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
}