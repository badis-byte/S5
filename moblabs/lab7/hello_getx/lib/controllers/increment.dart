import 'package:get/get.dart';
import 'package:hello_getx/controllers/history.dart';

class IncrementController extends GetxController {
  late final HistoryController histcont = Get.find<HistoryController>();
  final increment = 0.obs;

  @override
  void onReady() {}

  @override
  void onClose() {}

  void doIncrement() {
    increment.value = increment.value + 1;
    histcont.incHistory();
  }

  void doDecrement() {
    increment.value = increment.value - 1;
    histcont.decHistory();
  }
}
