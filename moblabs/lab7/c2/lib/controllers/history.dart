import 'package:get/get.dart';
import 'package:hello_getx/data/repo/history_repo_abstract.dart%20%20';
import 'package:hello_getx/data/repo/history_repository.dart';

class HistoryController extends GetxController {
  final list = <String>[].obs;

  @override
  void onReady() {}

  @override
  void onClose() {}

  @override
  void onInit() async{
    super.onInit();
    await loadData();
  }

  Future<bool> loadData() async{
    var tmp = await HistoryRepositoryBase.getInstance().getData();
    list.value = tmp;
    return true;
  }

  void incHistory() async{
    await HistoryRepositoryBase.getInstance().insertData("Incremented");
    await loadData();
  }

  void decHistory() async{
    await HistoryRepositoryBase.getInstance().insertData("Decremented");
    await loadData();
  }
}