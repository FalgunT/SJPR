import 'package:image_picker/image_picker.dart';
import 'package:sjpr/model/api_response_class.dart';
import 'package:sjpr/model/api_response_location.dart';
import 'package:sjpr/model/api_response_taxrate.dart';
import 'package:sjpr/model/category_list_model.dart';
import 'package:sjpr/model/currency_model.dart';
import 'package:sjpr/model/invoice_detail_model.dart';
import 'package:sjpr/model/invoice_list_model.dart';
import 'package:sjpr/model/lineitem_detail_model.dart';
import 'package:sjpr/model/lineitem_list_model.dart';
import 'package:sjpr/model/login.dart';
import 'package:sjpr/model/ownedby_list_model.dart';
import 'package:sjpr/model/product_list_model.dart';
import 'package:sjpr/model/profile_model.dart';
import 'package:sjpr/model/publish_to.dart';
import 'package:sjpr/model/split_list_model.dart';
import 'package:sjpr/model/type_list_model.dart';
import 'package:sjpr/model/upload_invoice.dart';
import 'package:sjpr/services/api_services.dart';
import '../model/api_response_costomer.dart';
import '../model/api_response_otprequest.dart';
import '../model/payment_methods.dart';
import '../screen/invoice/custom_camera2.dart';

class ApiRepositoryIml extends ApiRepository {
  final ApiServices _apiServices = ApiServices();

  @override
  Future<Login?> login({String? email, String? password}) {
    return _apiServices.login(email ?? '', password ?? '');
  }

  @override
  Future<CommonModelClass?> logout() {
    return _apiServices.logout();
  }

  @override
  Future<Profile?> profile() {
    return _apiServices.profile();
  }

  /*
 old

 @override
  Future<CommonModelClass?> uploadInvoice({required XFile invoice}) {
    return _apiServices.uploadInvoice(invoice: invoice);
  }

  @override
  Future<CommonModelClass?> uploadMultiInvoice(
      {required List<CaptureModel> invoice, required String uploadMode}) {
    return _apiServices.uploadMultiInvoice(
        invoices: invoice, uploadMode: uploadMode);
  }*/

  @override
  Future<CommonModelClass?> uploadInvoice(
      {required String invoicepath, required int isPurchase}) {
    return _apiServices.uploadInvoice(
        invoicepath: invoicepath, isPurchase: isPurchase);
  }

  @override
  Future<CommonModelClass?> uploadMultiInvoice(
      {required List<CaptureModel> invoice,
      required String uploadMode,
      required isPurchase}) {
    return _apiServices.uploadMultiInvoice(
        invoices: invoice, uploadMode: uploadMode, isPurchase: isPurchase);
  }

  @override
  Future<InvoiceList?> getInvoiceList(
      {bool isBackground = true, required isPurchase, required page}) {
    return _apiServices.getInvoiceList(isPurchase: isPurchase, page: page);
  }

  @override
  Future<InvoiceDetail?> getInvoiceDetail(String id) {
    return _apiServices.getInvoiceDetail(id);
  }

  @override
  Future<CategoryList?> getCategoryList() {
    return _apiServices.getCategoryList();
  }

  @override
  Future<ProductServicesList?> getProductList() {
    return _apiServices.getProductList();
  }

  @override
  Future<TypeList?> getTypeList() {
    return _apiServices.getTypeList();
  }

  @override
  Future<OwnedByList?> getOwnedByList() {
    return _apiServices.getOwnedByList();
  }

  @override
  Future<LineItemList?> getLineItemList(String invoiceId) {
    return _apiServices.getLineItemList(invoiceId);
  }

  @override
  Future<LineItemDetailApiResponse?> getLineItemDetail(String lineItemId) {
    return _apiServices.getLineItemDetail(lineItemId);
  }

  @override
  Future<CommonModelClass?> insertLineItemDetail(
      Map<String, String> json) async {
    return _apiServices.insertLineItemDetail(json);
  }

  @override
  Future<CommonModelClass?> updateLineItemDetail(
      Map<String, String> json) async {
    return _apiServices.updateLineItemDetail(json);
  }

  @override
  Future<CommonModelClass?> deleteLineItemDetail(
    String invoiceId,
  ) async {
    return _apiServices.deleteLineItemDetail(invoiceId);
  }

  @override
  Future<CommonModelClass?> addProduct({required String pName}) {
    return _apiServices.addProduct(pName);
  }

  @override
  Future<List<CurrencyModel>?> getCurrencyList() {
    return _apiServices.getCurrencyList();
  }

  @override
  Future<List<PaymentMethodsModel>?> getpaymentmethod() {
    return _apiServices.getPaymentMethods();
  }

  @override
  Future<List<PublishToModel>?> getPublishTo() {
    return _apiServices.getPublishTo();
  }

  @override
  Future updateScannedInvoice(Map<String, dynamic> json) {
    return _apiServices.updateScannedInvoice(json);
  }

  @override
  Future<Object?> AddCustomer(
      {required String cName, required int isPurchase}) {
    return _apiServices.addCustomer(cName, isPurchase: isPurchase);
  }

  @override
  Future<CustomerApiResponse?> getAllCustomer({required int isPurchase}) {
    return _apiServices.getAllCustomer(isPurchase: isPurchase);
  }

  @override
  Future<ApiResponseClassModel?> getAllClass() {
    // TODO: implement getAllTaxRate
    return _apiServices.getAllClass();
  }

  @override
  Future<ApiResponseLocationModel?> getAllLocation() {
    return _apiServices.getAllLocation();
  }

  @override
  Future<ApiResponseTaxRate?> getAllTaxRate() {
    return _apiServices.getAllTaxRate();
  }

  @override
  Future<Object?> AddClass({required String cName}) {
    return _apiServices.addClass(cName);
  }

  @override
  Future<Object?> AddLocation({required String cName}) {
    return _apiServices.addLocation(cName);
  }

  @override
  Future<SplitList?> getSplitItemList(String invoiceId) {
    return _apiServices.getSplitItemList(invoiceId);
  }

  @override
  Future<CommonModelClass?> updateSplitItemList(
      List<SplitListDataRequest> lstSplitListDataRequest) {
    return _apiServices.updateSplitItemList(lstSplitListDataRequest);
  }

  @override
  Future<CommonModelClass?> insertSplitItemDetail(
    String invoiceId,
    String categoryId,
    String totalAmount,
    String totalTaxAmount,
  ) async {
    return _apiServices.insertSplitItemDetail(
        invoiceId, categoryId, totalAmount, totalTaxAmount);
  }

  @override
  Future<CommonModelClass?> CancelInvoic(String id) {
    return _apiServices.CancelInvoice(id);
  }

  @override
  Future<CommonModelClass?> MovetoInbox(String id) {
    return _apiServices.MovetoInbox(id);
  }

  @override
  Future<CommonModelClass?> DeleteInvoice(String id) {
    return _apiServices.DeleteInvoice(id);
  }

  @override
  Future<InvoiceList?> getArchiveList(String dt,
      {required int isPurchase, required page}) {
    return _apiServices.getArchiveList(dt, isPurchase, page);
  }

  @override
  Future<CommonModelClass?> newPassword(
      {required String pass, required String confirmpass, required String id}) {
    return _apiServices.newPassword(pass, confirmpass, id);
  }

  @override
  Future<OtpResponse?> sendOTP({required String email}) {
    return _apiServices.sendOTP(email);
  }

  @override
  Future<CommonModelClass?> passwordReset(
      {required String oldPass,
      required String pass,
      required String confirmpass}) {
    return _apiServices.passwordReset(oldPass, pass, confirmpass);
  }
}

abstract class ApiRepository {
  Future<Login?> login({String? email, String? password});

  Future<CommonModelClass?> logout();

  Future<Profile?> profile();

  Future<CommonModelClass?> addProduct({required String pName});

  /*
  old
  Future<CommonModelClass?> uploadInvoice({required XFile invoice});

  Future<CommonModelClass?> uploadMultiInvoice(
      {required List<CaptureModel> invoice, required String uploadMode});*/

  Future<CommonModelClass?> uploadInvoice(
      {required String invoicepath, required int isPurchase});

  Future<CommonModelClass?> uploadMultiInvoice(
      {required List<CaptureModel> invoice,
      required String uploadMode,
      required int isPurchase});

  Future<InvoiceList?> getInvoiceList(
      {bool isBackground = true, required int isPurchase, required page});

  Future<InvoiceList?> getArchiveList(String dt,
      {required int isPurchase, required page});

  Future<InvoiceDetail?> getInvoiceDetail(String id);

  Future<CommonModelClass?> CancelInvoic(String id);

  Future<CommonModelClass?> MovetoInbox(String id);

  Future<CommonModelClass?> DeleteInvoice(String id);

  Future<CategoryList?> getCategoryList();

  Future<ProductServicesList?> getProductList();

  Future<TypeList?> getTypeList();

  Future<OwnedByList?> getOwnedByList();

  Future<List<CurrencyModel>?> getCurrencyList();

  Future<List<PaymentMethodsModel>?> getpaymentmethod();

  Future<List<PublishToModel>?> getPublishTo();

  Future updateScannedInvoice(Map<String, dynamic> json);

  Future<LineItemList?> getLineItemList(String invoiceId);

  Future<LineItemDetailApiResponse?> getLineItemDetail(String lineItemId);

  Future<CommonModelClass?> insertLineItemDetail(Map<String, String> json);

  Future<CommonModelClass?> updateLineItemDetail(Map<String, String> json);

  Future<CommonModelClass?> deleteLineItemDetail(
    String invoiceId,
  );

  Future<Object?> AddCustomer({required String cName, required int isPurchase});

  Future<CustomerApiResponse?> getAllCustomer({required int isPurchase});

  Future<ApiResponseLocationModel?> getAllLocation();

  Future<ApiResponseClassModel?> getAllClass();

  Future<ApiResponseTaxRate?> getAllTaxRate();

  Future<Object?> AddClass({required String cName});

  Future<Object?> AddLocation({required String cName});

  Future<SplitList?> getSplitItemList(String invoiceId);

  Future<CommonModelClass?> updateSplitItemList(
      List<SplitListDataRequest> lstSplitListDataRequest);

  Future<CommonModelClass?> insertSplitItemDetail(String invoiceId,
      String categoryId, String totalAmount, String totalTaxAmount);

  Future<OtpResponse?> sendOTP({required String email});

  Future<CommonModelClass?> newPassword(
      {required String pass, required String confirmpass, required String id});

  Future<CommonModelClass?> passwordReset(
      {required String oldPass,
      required String pass,
      required String confirmpass});
}
