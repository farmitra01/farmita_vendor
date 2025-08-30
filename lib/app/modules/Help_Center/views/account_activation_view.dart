
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountActivationView extends GetView {
  const AccountActivationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VendorAppBar(title: 'Account Activation'),
      body: const Center(
        child: Text(
          'AccountActivationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
