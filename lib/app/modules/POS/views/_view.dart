import 'package:flutter/material.dart';

import 'package:get/get.dart';

class View extends GetView {
  const View({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'View is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
