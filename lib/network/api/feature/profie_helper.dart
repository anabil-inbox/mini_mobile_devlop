import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/profile/get_wallet_model.dart';
import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/network/api/model/profile_api.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/sh_util.dart';
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

  Future<AppResponse> editAddress(Map<String, dynamic> body) async {
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

  Future<AppResponse> deleteAddress({var body}) async {
    var appResponse = await ProfileApi.getInstance.deleteAddress(
        url: "${ConstanceNetwork.deleteAdressEndPoint}",
        header: ConstanceNetwork.header(4),
        body: body);
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> logOut() async {
    var appResponse = await ProfileApi.getInstance.logOut(
      url: "${ConstanceNetwork.logOutEndPoint}",
      header: ConstanceNetwork.header(4),
    );
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> editProfile(var body) async {
    var appResponse = await ProfileApi.getInstance.editProfile(
        body: body,
        url: SharedPref.instance
                    .getCurrentUserData()
                    .crNumber
                    .toString()
                    .isEmpty ||
                GetUtils.isNull(
                    SharedPref.instance.getCurrentUserData().crNumber)
            ? "${ConstanceNetwork.editProfilEndPoint}"
            : "${ConstanceNetwork.editProfilCompanyEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<GetWallet> getMyWallet() async {
    var appResponse = await ProfileApi.getInstance.getMyWallet(
        url: "${ConstanceNetwork.getMyWalletEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return GetWallet.fromJson(appResponse.data);
    } else {
      return GetWallet.fromJson(appResponse.data ?? {});
    }
  }
}
