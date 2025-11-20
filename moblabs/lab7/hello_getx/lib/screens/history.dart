import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_getx/controllers/history.dart';
import 'package:hello_getx/controllers/increment.dart';

class History extends StatelessWidget {
  History({super.key});
  HistoryController controller = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
        Obx(() => Column(
          children: [
            for(var item in controller.list)
              Text(item)
          ],
        ))
    );
  }
}
