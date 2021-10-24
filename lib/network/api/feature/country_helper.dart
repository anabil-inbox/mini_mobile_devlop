import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/network/api/model/country_api.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class CountryHelper {
  CountryHelper._();
  static final CountryHelper getInstance = CountryHelper._();
  var log = Logger();

  //todo get Feature From Api 
    Future<List<Country>> getCountryApi() async{
      try {
      var response = await CountryApi.getInstance.getAppCountreis(url: "${ConstanceNetwork.countryEndPoint}", header: ConstanceNetwork.header(0));
      if (response.status?.success == true) {
        print("msg_res_ ${response.data["Countries"]}");
        List data = response.data["Countries"];
        return data.map((e) => Country.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log.d(e.toString());
      return [];
    }
    }
}