
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BankAccountView extends GetView {
  const BankAccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VendorAppBar(title: 'Bank Account'),
      body: const Center(
        child: Text(
          'BankAccountView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
