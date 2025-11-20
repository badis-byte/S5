import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_getx/controllers/increment.dart';

class WidgetB extends StatelessWidget {
  const WidgetB({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<IncrementController>();
    return Column(
      children: [
        Obx(
          () => Text(
            "Double Value : ${controller.increment.value * 2}",
            style: TextStyle(fontSize: 40),
          ),
        )
      ],
    );
  }
}
