
import 'package:inbox_clients/feature/model/country.dart';
import 'package:inbox_clients/network/api/model/country_api.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class CountryHelper {
  CountryHelper._();
  static final CountryHelper getInstance = CountryHelper._();
  var log = Logger();

  //todo get Feature From Api 
    Future<Set<Country>> getCountryApi(var queryParameters) async{
      try {
      var response = await CountryApi.getInstance.getAppCountreis(url: "${ConstanceNetwork.countryEndPoint}?page=${queryParameters["page"]}&page_size=${queryParameters["page_size"]}", header: ConstanceNetwork.header(0) , /* queryParameters: queryParameters */);
      if (response.status?.success == true) {
        List data = response.data["items"];
        return data.map((e) => Country.fromJson(e)).toSet();
      } else {
        print("get_in_Eels");
        return {
        };
      }
    } catch (e) {
      log.d(e.toString());
      return {};
    }
    }
}