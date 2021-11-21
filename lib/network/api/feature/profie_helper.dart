import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/network/api/model/profile_api.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class ProfileHelper {
  ProfileHelper._();
  static final ProfileHelper getInstance = ProfileHelper._();
  var log = Logger();

  Future<AppResponse> addNewAddress(Map<String, dynamic> body) async {
    var appResponse = await ProfileApi.getInstance.addNewAddress(
        body: body,
        url: "${ConstanceNetwork.addAddressEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> editAddress(Map<String,dynamic> body) async {
    var appResponse = await ProfileApi.getInstance.uppdateAddress(
        body: body,
        url: "${ConstanceNetwork.editAddressEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> getMyAddress() async {
    var appResponse = await ProfileApi.getInstance.getMyAddress(
        url: "${ConstanceNetwork.getMyAddressEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> deleteAddress({var body}) async{
    var appResponse = await ProfileApi.getInstance.deleteAddress(
            url: "${ConstanceNetwork.deleteAdressEndPoint}",
            header: ConstanceNetwork.header(4),
            body: body
            );
        if (appResponse.status?.success == true) {
          return appResponse;
        } else {
          return appResponse;
        }
  }

  Future<AppResponse> logOut() async {
    var appResponse = await ProfileApi.getInstance.deleteAddress(
            url: "${ConstanceNetwork.logOutEndPoint}",
            header: ConstanceNetwork.header(4),
            );
        if (appResponse.status?.success == true) {
          return appResponse;
        } else {
          return appResponse;
        }
  }

  Future<AppResponse> editProfile(Map<String,dynamic> body) async {
    var appResponse = await ProfileApi.getInstance.editProfile(
        body: body,
        url: "${ConstanceNetwork.editProfilEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }
}