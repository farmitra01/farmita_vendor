import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  late final WebViewController _controller;
  final RxBool isLoading = true.obs; // ✅ reactive loader state

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (_) => isLoading.value = true,
              onPageFinished: (_) => isLoading.value = false,
            ),
          )
          ..loadRequest(Uri.parse('https://farmitra.com/terms'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VendorAppBar(title: 'Terms & Condition'),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          Obx(
            () =>
                isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
