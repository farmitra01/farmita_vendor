import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessDetailsView extends GetView {
  const BusinessDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VendorAppBar(title: 'Business Details'),
      body: const Center(
        child: Text(
          'BusinessDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
