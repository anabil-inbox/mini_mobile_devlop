// import 'package:cloud_firestore/cloud_firestore.dart';
//  import 'package:inbox_driver/network/firebase/track_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inbox_clients/network/firebase/track_model.dart';
import 'package:logger/logger.dart';

class FirebaseClint {

  //singleton
  FirebaseClint._();
  static final FirebaseClint instance = FirebaseClint._();
  factory FirebaseClint()=> instance;


  //constance collections
  // static const String? _stagingKey = "test/";//live/ /// todo:// this for testing or live key
  static const String? _diverTrack = "diverTrackList";

  //constance docs
  static const String? _serialOrder = "serialOrder";
  static  String? serialOrderData = "serialOrderData";
  static  String? serialOrderDriverData = "serialOrderDriverData";
  static  String? serialOrderDriverLocations = "serialOrderDriverLocation";

  //this for add driver tracking
  Future<void> addDriverLocation(var customerId , var serial , var bodyData)async{
    try {
      ///  in _diverTrack we will store [customerId]
      ///  in customerId we will store [_serialOrder]
      ///  in _serialOrder we will store [serial]
      ///  in serial we will store [bodyData]
      FirebaseFirestore.instance.collection("$_diverTrack")
              .doc(customerId).collection(_serialOrder.toString())
              .doc(serial).set(bodyData).then((value) {
                Logger().i("Done Store locations [Driver]");
      }).catchError((onError){
        Logger().e("$onError");
      });
    } catch (e) {
      Logger().d(e);
      throw "e";
    }
  }

  // this for get driver tracking
  Stream<TrackModel> getTrackLocation(var customerId  , var serial) async* {
    try {
      ///  in _diverTrack we will get [customerId]
      ///  in customerId we will get [_serialOrder]
      ///  in _serialOrder we will get [serial]
      ///  in serial we will get [bodyData]
      var documentReference =  FirebaseFirestore.instance.collection("$_diverTrack").doc(customerId)
          .collection(_serialOrder.toString()).doc(serial);
      var querySnapshot =  documentReference.snapshots().where((event) => !event.metadata.isFromCache);

      yield await querySnapshot.map((event) => TrackModel.fromJson(event.data()) ).last;

    } catch (e) {
      Logger().d(e);
      throw e;
    }
  }


  //this for add driver tracking
  Future<void> deleteOrderTracking(var customerId , var serial , var bodyData)async{
    try {
      ///  in _diverTrack we will go to [customerId]
      ///  in customerId we will go to [_serialOrder]
      ///  in _serialOrder we will go to delete [serial]
      //  in serial we will store [bodyData]
      FirebaseFirestore.instance.collection("$_diverTrack")
          .doc(customerId).collection(_serialOrder.toString())
          .doc(serial).delete();
    } catch (e) {
      Logger().d(e);
      throw "e";
    }
  }

 }