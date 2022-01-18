import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';

class LocalBulk {
  Set<StorageItem> endStorageItem = {};
  StorageItem? optionStorageItem;
  num bulkprice = 0;

  // num getBulkBalance(){
  //   num balance = 0.0;
  //   return balance;
  // }
  
  void printObject() {
    print("--------------------------------------------------");
    print("msg_in_print_array_length:: ${endStorageItem.length}");
    for (var item in endStorageItem) {
      print("msg_in_print_array ${item.toJson()}");
    }
    
    print("msg_option ${optionStorageItem?.toJson()}");
    print("--------------------------------------------------");
  }
}
