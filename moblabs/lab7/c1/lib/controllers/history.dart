import 'package:get/get.dart';

class HistoryController extends GetxController {
  final list = <String>[].obs;

  @override
  void onReady() {}

  @override
  void onClose() {}

  void incHistory() {
    list.add(DateTime.now().toString() + " Incremented");
  }

  void decHistory() {
    list.add(DateTime.now().toString() + " Decremented");
  }
}