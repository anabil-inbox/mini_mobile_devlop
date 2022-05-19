import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class FirebaseUtils {
  FirebaseUtils._();
  static final FirebaseUtils instance = FirebaseUtils._();
  factory FirebaseUtils() => instance;

  // static var appVersion = 24;

  //todo this for hide/show wallet and plan manually
  Future<bool> isHideWallet()async{
    var documentReference = FirebaseFirestore.instance.collection("condition").doc("condition");
    var documentSnapshot = await documentReference.get();
    var data = documentSnapshot.data();
    Logger().d(data);
    return data?["hide"]??false;
  }

}