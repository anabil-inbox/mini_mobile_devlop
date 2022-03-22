import 'package:inbox_clients/feature/model/subscription_data.dart';
import 'package:inbox_clients/network/api/model/subscription.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

import '../model/app_response.dart';

class SubscriptionFeature {
  SubscriptionFeature._();
  static final SubscriptionFeature getInstance = SubscriptionFeature._();
  var log = Logger();

  Future<List<SubscriptionData>> getSubscriptions(Map<String, dynamic> map) async {
    try {
      var response = await Subscription.getInstance.getSubscriptions(
          url: "${ConstanceNetwork.getSubscriptionsEndPoint}",
          map:map,
          header:  ConstanceNetwork.header(2));
      if (response.status?.success == true) {
        List data = response.data;
        var map = data.map((e) => SubscriptionData.fromJson(e)).toList();
        return map;
      } else {
        return [];
      }
    } catch (e) {
      log.d(e.toString());
      return [];
    }
  }


  Future<AppResponse> terminateSubscriptions(var body) async {
    try {
      var response = await Subscription.getInstance.terminateSubscriptions(
          url: "${ConstanceNetwork.terminateSubscriptionsEndPoint}",
          header:  ConstanceNetwork.header(2),
          body:body);
      Logger().d(response.toJson());
      if (response.status?.success == true) {
       return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      throw e.toString();
    }
  }
}
