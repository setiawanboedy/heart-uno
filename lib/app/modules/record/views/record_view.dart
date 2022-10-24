import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/record_controller.dart';

class RecordView extends GetView<RecordController> {
  const RecordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RecordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
