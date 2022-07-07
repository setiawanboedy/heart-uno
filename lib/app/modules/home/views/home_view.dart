import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heart_usb/app/modules/pages/parent.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: AppBar(
        title: const Text('Heart Rate'),
        centerTitle: true,
      ),
      child: Center(
        child: Obx(
          () => Column(
            children: [
              Text("Status: ${controller.status} "),
              controller.model.isNotEmpty
                  ? Text("Info: ${controller.model.first.data.port } ")
                  : Container(),
              Expanded(
                child: ListView.builder(
                    itemCount: controller.serialData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(controller.serialData[index]),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
