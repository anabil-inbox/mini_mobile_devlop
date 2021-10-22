import 'package:inbox_clients/feature/model/features_modle.dart';
import 'package:inbox_clients/network/api/model/feature_api.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class FeatureHelper {
  FeatureHelper._();
  static final FeatureHelper getInstance = FeatureHelper._();
  var log = Logger();

  //todo get Feature From Api 
    Future<List<Feature>> getFeatureApi() async{
      try {
      var response = await FeatureApi.getInstance.getAppFeature(url: "${ConstanceNetwork.featureEndPoint}", header: ConstanceNetwork.header(0));
      if (response.status?.success == true) {
        print("msg_res_ ${response.data["features"]}");
        List data = response.data["features"];
        return data.map((e) => Feature.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log.d(e.toString());
      return [];
    }
    }
}