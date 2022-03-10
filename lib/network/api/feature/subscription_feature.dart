import 'package:inbox_clients/feature/model/subscription_data.dart';
import 'package:inbox_clients/network/api/model/subscription.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class SubscriptionFeature {
  SubscriptionFeature._();
  static final SubscriptionFeature getInstance = SubscriptionFeature._();
  var log = Logger();

  Future<List<SubscriptionData>> getSubscriptions() async {
    try {
      var response = await Subscription.getInstance.getSubscriptions(
          url: "${ConstanceNetwork.getSubscriptionsEndPoint}",
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
}
