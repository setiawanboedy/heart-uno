import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/receive_data_controller.dart';

class ReceiveDataView extends GetView<ReceiveDataController> {
  const ReceiveDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReceiveDataView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ReceiveDataView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
