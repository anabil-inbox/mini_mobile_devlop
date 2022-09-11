import 'package:get/get.dart';
import 'package:inbox_clients/util/sh_util.dart';

abstract class ConstanceNetwork {
  ///todo here insert base_url
  ///old imageUrl http://inbox.ahdtech.com/
  ///new imageUrl http://mini.inbox.com.qa/
  static String imageUrl = SharedPref.instance.getAppSettings()!.domain.toString().trim();

  // contsanse for Days Constance
  static var sunday = "sunday";
  static var monday = "monday";
  static var tuesday = "tuesday";
  static var wednesday = "wednesday";
  static var thuersday = "thuersday";
  static var friday = "friday";
  static var saturday = "saturday";

  ///todo here insert key Of Request

  ///todo this for login request user
  static var contryCodeKey = "country_code";
  static var codeKey = "code";
  static var mobileKey = "mobile";
  static var udidKey = "udid";
  static var deviceTypeKey = "device_type";
  static var fcmKey = "fcm";
  static var emailKey = "email";

  ///todo this for add new contact key
  static var mobileNumberKey = "mobile_number";
  static var countryCodeKey = "country_code";

  ///todo this for add new contact key

  ///to add here home api End Pointes :
  static String getCustomerBoxessEndPoint =
      "inbox_app.api.customer_storages.get_storages";
  static String getSearchBoxessEndPoint = "inbox_app.search.search.search_box";

  // to add here my order End Points:
  static String getMyOrddersEndPoint =
      "inbox_app.api.sales_order.get_sales_orders";
  static String newSalesOrder =
      "inbox_app.api.sales_order.create_new_sales_order";

  ///todo here insert end Point
  static String settingeEndPoint = "inbox_app.api.settings.api_settings";

  static String featureEndPoint = "inbox_app.api.settings.features";

  static String countryEndPoint = "inbox_app.api.settings.countries";

  static String registerUser = "inbox_app.api.auth.register";

  static String loginUser = "inbox_app.api.auth.login";

  static String registerCompany = "inbox_app.api.auth.company_register";

  static String loginCompany = "inbox_app.api.auth.company_login";

  static String userStillNotVerifyState = "stillNotVerify";

  static String companyStillNotVerifyState = "CompanystillNotVerify";

  static String userEnterd = "enterd";

  static String userLoginedState = "logined";

  static String verfiyCodeEndPoint = "inbox_app.api.auth.verfiy";

  static String recendVerficationCodeEndPoint =
      "inbox_app.api.auth.resend_code";

  static String addAddressEndPoint = "inbox_app.api.address.add";
  static String createHelpDocPoint =
      "inbox_app.api.service_center.create_help_doc";
  static String getProfileEndPoint = "inbox_app.api.auth.me";

  static String editAddressEndPoint = "inbox_app.api.address.edit";

  static String getMyAddressEndPoint = "inbox_app.api.address.get";

  static String getMyWalletEndPoint = "inbox_app.api.wallet.get_my_wallet";

  static String deleteAdressEndPoint = "inbox_app.api.address.address_del";

  static String logOutEndPoint = "inbox_app.api.auth.logout";

  static String deleteAccountApi = "inbox_app.api.auth.delete_account";

  static String editProfilEndPoint = "inbox_app.api.auth.edit_profile";

  static String getLogEndPoint = "inbox_app.api.loyalty_points.get_log";

  static String depositMoneyEndPoint = "inbox_app.api.wallet.get_deposit_url";

  static String checkDepositEndPoint = "inbox_app.api.wallet.check_payment";

  static String editProfilCompanyEndPoint =
      "inbox_app.api.auth.company_edit_profile";

  //todo this for storage end point
  static String storageCategoriesApi = "inbox_app.api.storage.categories";
  static String storageCheckQuantity = "inbox_app.api.quantity.quantity";
  static String storageAddOrder = "inbox_app.api.sales_order.sales_order";
  static String customerStoragesChangeStatus =
      "inbox_app.api.customer_storages.change_status";
  static String storageWareHouse = "inbox_app.api.warehouse.warehouse";
  static String storageAddNewStorage = "inbox_app.api.sales_order.sales_order";
  static String getTaskEndPoint = "inbox_app.api.task.get_basic_tasks";
  static String getOrderDetailes = "inbox_app.api.sales_order.get_order";

  // check coupon
  static String checkCouponEndPoints =
      "inbox_app.api.loyalty_points.check_coupon";

  // to check Time Slot Here :

  static String checkTimeSlotEndPoint =
      "inbox_app.api.sales_order.check_time_slot";
  // to add here item end pointes :

  static String getBoxBySerialEndPoint =
      "inbox_app.api.customer_storages.get_box";
  static String addItemEndPoint = "inbox_app.api.customer_storages.add_item";
  static String deleteItemEndPoint =
      "inbox_app.api.customer_storages.item_delete";
  static String updateItemEndPoint =
      "inbox_app.api.customer_storages.update_item";
  static String getBeneficiaryEndPoint = "inbox_app.api.task.get_beneficiary";

  // update & delete Box End Point :
  static String updatetBoxEndPoint =
      "inbox_app.api.customer_storages.update_box";
  // to go payment End Points :

  static String paymentEndPoint = "inbox_app.api.get_payment_url.get_payment_url";
      // "inbox_app.api.get_payment_url.get_skip_cash_settings";
  static String applyPaymentEndPoint =
      "inbox_app.api.sales_order.submit_payment";

  //product end point
  static String allOrder = "inbox_app.api.product.get_products";
  static String orderDetails = "inbox_app.api.product.get_product";

  // this for constance network
  static String page = "page";
  static String pageSize = "page_size";
  static String customerKey = "Customer";

  // this for constance Myorder
  static String myOrderDetailesEndPoint = "inbox_app.api.sales_order.get_order";
  static String myPointsEndPoint =
      "inbox_app.api.loyalty_points.get_loyalty_points";
  static String submitPaymentEndPoint =
      "inbox_app.api.sales_order.submit_payment";
  static String getInvoiceUrlPaymentApi = "inbox_app.api.get_payment_url.get_invoice_url";
  static String applyInvoicePaymentApi = "inbox_app.api.get_payment_url.apply_invoice";
  static String uploadOrderSignatureEndPoint =
      "inbox_app.api.sales_order.upload_order_signature";
  static String addReviewApi = "inbox_app.api.service_center.create_review";
  static String cancelOrderApi ="inbox_app.api.sales_order.cancel_order";
  static String applyCancelApi ="inbox_app.api.sales_order.apply_cancel";
  static String editOrderApi ="inbox_app.api.sales_order.edit_order";

  // this for subscriptions
  static String getSubscriptionsEndPoint =
      "inbox_app.api.subscription.get_subscriptions";
  static String terminateSubscriptionsEndPoint =
      "inbox_app.api.subscription.terminate_subscription";

  // this for get Task Response:
  static String getCurrentTaskResponeEndPoint =
      "inbox_app.api.sales_order.get_order_details";
  static String getCasesApi = "inbox_app.api.service_center.get_cases";
  static String createEmergencyCasesApi =
      "inbox_app.api.service_center.create_emer_report"; //

  // this for notifcation
  static String getNotificationsApi =
      "inbox_app.api.loyalty_points.get_notifications";

  //this for cards
  static String addCardApi = "inbox_app.api.get_payment_url.add_card";
  static String getCardApi = "inbox_app.api.get_payment_url.get_cards";

  //todo this for constance Keys
  static String amountKey = "amount";
  static String idKey = "id";
  static String paymentMethodKey = "payment_method";
  static String paymentIdKey = "payment_id";
  static String extraFeesKey = "extra_fees";
  static String reasonKey = "reason";
  static String statusKey = "status";

  //todo this for constance type of user
  static String userType = "user";
  static String companyType = "company";
  static String bothType = "both";

  ///here keys of storage category type:
  static String spaceCategoryType = "Space";
  static String itemCategoryType = "Item";
  static var quantityCategoryType = "Quantity";
  static var driedCage = "Dried Space";
  static var serial = "serial";

  ///here keys of duration status;
  static var dailyDurationType = "Daily";
  static var montlyDurationType = "Monthly";
  static var yearlyDurationType = "Yearly";
  static var unLimtedDurationType = "unlimited";

  //here block and enaeld Folder icons;
  static String enableFolder = "assets/svgs/folder_icon.svg";
  static String disableFolder = "assets/svgs/clocked_file.svg";

  //here order keyes
  static String productId = "product_id";

  static var filter = "filter";

  static var smsKey = /*"sms"*/"mobile";

  static var targetKey = "target";

  static var nameKey = "name";

  static var qtyKey = "qty";

  static var newNameKey = "new_name";

  static var tagsKey = "tags";

  static var dataKey = "data";
  static var deliveryDateKey = "delivery_date";

  static var imageKey = "Image";

  static var storageKey = "storage";

  static var gallerykey = "gallery";

  static var fullNameKey = "full_name";

  static var imageSmallKey = "image";

  static var contactNumberkey = "contact_number";

  static var companyNameKey = "company_name";

  static var companySectorKey = "company_sector";

  static var applicantNameKey = "applicant_name";

  static var applicantDepartmentKey = "applicant_department";

  static var rateKey = "rate";

  static var noteKey = "note";
  static var notesKey = "notes";

  static var driverIdKey = "driver";

  static var salesOrderKey = "sales_order";

  static var emergencyCaseKey = "emergency_case"; //small
  static var orderIdKey = "order_id";

  static var shippingAddressKey = "shipping_address";

  static var orderFromKey = "order_from";
  static var orderToKey = "order_to";

  static var itemsKey = "items"; //small
  static var paymentEntryKey = "payment_entry"; //small

  static Map<String, String> header(int typeToken) {
    Map<String, String> headers = {};
    if (typeToken == 0) {
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Language': Get.locale.toString().split("_")[0],
      };
    } else if (typeToken == 1) {
      headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
    } else if (typeToken == 2) {
      headers = {
        'Authorization':
            'Bearer ${SharedPref.instance.getUserToken().toString()}',
      };
    } else if (typeToken == 3) {
      headers = {
        //  'Authorization': '${SharedPref.instance.getToken().toString()}',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
    } else if (typeToken == 4) {
      print(
          "msg_get_user_token_on_send_to_header ${SharedPref.instance.getUserToken()}");
      headers = {
        'Authorization': 'Bearer ${SharedPref.instance.getUserToken()}',
        'Content-Type': 'application/json',
        'Language': Get.locale.toString().split("_")[0],
        'Accept': 'application/json',
      };
    }

    return headers;
  }
}
