import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/network/api/feature/storage_feature.dart';

class LocalBulk {
  Set<StorageItem> endStorageItem = {};
  StorageItem? optionStorageItem;
  Set<StorageFeature>? storageFeature;

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
