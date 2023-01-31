import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/profile/cards_model.dart';
import 'package:inbox_clients/feature/model/profile/get_wallet_model.dart';
import 'package:inbox_clients/feature/model/profile/invoices_model.dart';
import 'package:inbox_clients/feature/model/profile/log_model.dart';
import 'package:inbox_clients/network/api/model/app_response.dart';
import 'package:inbox_clients/network/api/model/profile_api.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';

import '../../../feature/model/profile/invoices_details_data.dart';

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

  Future<AppResponse> deleteAccount() async {
    var appResponse = await ProfileApi.getInstance.deleteAccount(
      url: "${ConstanceNetwork.deleteAccountApi}",
      header: ConstanceNetwork.header(2),
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

  Future<AppResponse> depositMoneyToWallet(Map<String, dynamic> body) async {
    var appResponse = await ProfileApi.getInstance.depositMoneyToWallet(
        body: body,
        url: "${ConstanceNetwork.depositMoneyEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> checkDeposit(Map<String, dynamic> body) async {
    var appResponse = await ProfileApi.getInstance.checkDeposit(
        body: body,
        url: "${ConstanceNetwork.checkDepositEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> applyInvoicesPayment(Map<String, dynamic> body) async {
    var appResponse = await ProfileApi.getInstance.applyInvoicesPayment(
        body: body,
        url: "${ConstanceNetwork.applyInvoicesPaymentEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> getMyPoints() async {
    var appResponse = await ProfileApi.getInstance.getMyPoints(
        url: "${ConstanceNetwork.myPointsEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<Set<Log>> getUserLogs() async {
    var appResponse = await ProfileApi.getInstance.getUserLog(
        url: "${ConstanceNetwork.getLogEndPoint}",
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      List data = appResponse.data;
      return data.map((e) => Log.fromJson(e)).toSet();
    } else {
      return {};
    }
  }

  Future<AppResponse> sendNote(Map<String, dynamic> body) async {
    var appResponse = await ProfileApi.getInstance.sendNote(
        body: body,
        url: "${ConstanceNetwork.createHelpDocPoint}",
        header: ConstanceNetwork.header(2));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> getUserData() async {
    var appResponse = await ProfileApi.getInstance.getProfile(
        url: "${ConstanceNetwork.getProfileEndPoint}",
        header: ConstanceNetwork.header(2));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> addCard() async {
    var appResponse = await ProfileApi.getInstance.addCard(
        url: "${ConstanceNetwork.addCardApi}",
        header: ConstanceNetwork.header(2));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<CardsData> getCards() async {
    var appResponse = await ProfileApi.getInstance.getCard(
        url: "${ConstanceNetwork.getCardApi}",
        header: ConstanceNetwork.header(2));
    if (appResponse.status?.success == true) {
      return CardsData.fromJson(appResponse.data);
    } else {
      return CardsData.fromJson(appResponse.data ?? {});
    }
  }

  Future<List<InvoicesData>> getMyBill() async {
    var appResponse = await ProfileApi.getInstance.getMyBill(
        url: "${ConstanceNetwork.subscriptionGetInvoicesEndPoint}",
        header: ConstanceNetwork.header(4));
    Logger().w(appResponse.toJson());
    if (appResponse.status?.success == true) {
      List data = appResponse.data;
      return data.map((e) => InvoicesData.fromJson(e)).toList();
    } else {
      return <InvoicesData>[];
    }
  }

  Future<InvoicesDetailsData> getInvoiceDetails(var id) async {
    var appResponse = await ProfileApi.getInstance.getInvoiceDetails(
        url: "${ConstanceNetwork.getInvoiceDetailsEndPoint}$id",
        header: ConstanceNetwork.header(4));
    Logger().w(appResponse.toJson());
    if (appResponse.status?.success == true) {
      return InvoicesDetailsData.fromJson(appResponse.data);
    } else {
      return InvoicesDetailsData.fromJson({});
    }
  }
}
