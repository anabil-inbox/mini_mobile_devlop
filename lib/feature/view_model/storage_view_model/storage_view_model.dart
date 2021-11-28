import 'package:inbox_clients/util/base_controller.dart';

class StorageViewModel extends BaseController {

  //todo this for appbar select btn
  bool? isSelectBtnClick = false;
  bool? isSelectAllClick = false;
  List<String> listIndexSelected = <String>[];
  //todo this for appbar select btn

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //todo this for show selection btn
  updateSelectBtn() {
    isSelectBtnClick = !isSelectBtnClick!;
    update();
  }

  //todo this for select all item
  updateSelectAll(List<String> list) {
    isSelectAllClick = !isSelectAllClick!;
    update();
    insertAllItemToList(list);
  }

  //todo this for add single item to selected List item
  addIndexToList(var index){
    if(listIndexSelected.contains(index)){
      listIndexSelected.remove(index);
      update();
    }else{
      listIndexSelected.add(index);
      update();
    }
  }

  //todo this for add all item to selected List item
  void insertAllItemToList(List<String> list) {
    if(isSelectAllClick!) {
      listIndexSelected.clear();
      listIndexSelected.addAll(list);
      update();
    }else{
      listIndexSelected.clear();
      update();
    }
  }
}
