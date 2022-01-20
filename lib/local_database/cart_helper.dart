import 'package:inbox_clients/local_database/model/cart_model.dart';
import 'package:inbox_clients/local_database/sql_helper.dart';

class CartHelper{

  //todo this singleton
  CartHelper._();
  static final CartHelper instance = CartHelper._();
  factory CartHelper() => instance;


  //todo this for get cart item
  Future<List<CartModel>> getMyCart()async{
    var value = await SqlHelper.instance.selectAllDataFromDatabase();
    List<Map<String, Object?>> map = value!;
    List<CartModel> listData = map.map((e) => CartModel.fromJson(e)).toList();
    return listData;
  }

  //todo this for insert to myCartTable
  Future<int> addToCart(CartModel data)async{
    data.toJson().remove("id");
    return await SqlHelper.instance.insertDataToDatabase(data);
  }

  //todo this for deleteItem From myCartTable
  Future<int> deleteItemCart(CartModel data)async{
    return await SqlHelper.instance.deleteDataFromDatabase(data);
  }

  //todo this for update item in my cart
  Future<int> updateItemCart(CartModel data)async{
    return await SqlHelper.instance.updateDataToDatabase(data);
  }

  //todo this for getSingle item in my cart
  Future<CartModel> getSingleItemCart(CartModel data)async{
    var value = await SqlHelper.instance.selectAllDataFromDatabaseWhere(data.id);
    List<Map<String, Object?>> map = value!;
    List<CartModel> listData = map.map((e) => CartModel.fromJson(e)).toList();
    return listData.first;
  }

  //todo this for delete item in my cart
  Future<int> deleteDataBase()async{
    return await SqlHelper.instance.deleteDatabases();
  }

}