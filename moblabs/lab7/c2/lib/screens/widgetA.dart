import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_getx/controllers/increment.dart';

class WidgetA extends StatelessWidget {
  WidgetA({super.key});
  IncrementController controller = Get.find<IncrementController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              controller.doIncrement();
            },
            child: Text("Increment")),
        Obx(() => Text("Value : ${controller.increment}",
            style: TextStyle(fontSize: 40))),
        ElevatedButton(
            onPressed: () {
              controller.doDecrement();
            },
            child: Text("Decrement")),
      ],
    );
  }
}
