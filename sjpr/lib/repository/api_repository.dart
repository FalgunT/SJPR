import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sjpr/model/category_list_model.dart';
import 'package:sjpr/model/invoice_detail_model.dart';
import 'package:sjpr/model/invoice_list_model.dart';
import 'package:sjpr/model/lineitem_detail_model.dart';
import 'package:sjpr/model/lineitem_list_model.dart';
import 'package:sjpr/model/login.dart';
import 'package:sjpr/model/ownedby_list_model.dart';
import 'package:sjpr/model/product_list_model.dart';
import 'package:sjpr/model/profile_model.dart';
import 'package:sjpr/model/type_list_model.dart';
import 'package:sjpr/model/upload_invoice.dart';
import 'package:sjpr/services/api_services.dart';

import '../screen/invoice/custom_camera.dart';

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

  @override
  Future<CommonModelClass?> uploadInvoice({required XFile invoice}) {
    return _apiServices.uploadInvoice(invoice: invoice);
  }

  @override
  Future<CommonModelClass?> uploadMultiInvoice(
      {required List<CaptureModel> invoice, required String uploadMode}) {
    return _apiServices.uploadMultiInvoice(
        invoices: invoice, uploadMode: uploadMode);
  }

  @override
  Future<InvoiceList?> getInvoiceList() {
    return _apiServices.getInvoiceList();
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
  Future<LineItemDetail?> getLineItemDetail(String lineItemId) {
    return _apiServices.getLineItemDetail(lineItemId);
  }

  @override
  Future<CommonModelClass?> insertLineItemDetail(
      String invoiceId,
      String desc,
      String quantity,
      String unitPrice,
      String totalAmount,
      String name,
      String taxRate) async {
    return _apiServices.insertLineItemDetail(
        invoiceId, desc, quantity, unitPrice, totalAmount, name, taxRate);
  }

  @override
  Future<OwnedByList?> updateLineItemDetail(
      String invoiceId,
      String desc,
      String quantity,
      String unitPrice,
      String totalAmount,
      String name,
      String taxRate) async {
    return _apiServices.updateLineItemDetail(
        invoiceId, desc, quantity, unitPrice, totalAmount, name, taxRate);
  }

  @override
  Future<CommonModelClass?> deleteLineItemDetail(
    String invoiceId,
  ) async {
    return _apiServices.deleteLineItemDetail(invoiceId);
  }
}

abstract class ApiRepository {
  Future<Login?> login({String? email, String? password});

  Future<CommonModelClass?> logout();

  Future<Profile?> profile();

  Future<CommonModelClass?> uploadInvoice({required XFile invoice});

  Future<CommonModelClass?> uploadMultiInvoice(
      {required List<CaptureModel> invoice, required String uploadMode});

  Future<InvoiceList?> getInvoiceList();

  Future<InvoiceDetail?> getInvoiceDetail(String id);

  Future<CategoryList?> getCategoryList();

  Future<ProductServicesList?> getProductList();

  Future<TypeList?> getTypeList();

  Future<OwnedByList?> getOwnedByList();

  Future<LineItemList?> getLineItemList(String invoiceId);

  Future<LineItemDetail?> getLineItemDetail(String lineItemId);

  Future<CommonModelClass?> insertLineItemDetail(
      String invoiceId,
      String desc,
      String quantity,
      String unitPrice,
      String totalAmount,
      String name,
      String taxRate);

  Future<OwnedByList?> updateLineItemDetail(
      String invoiceId,
      String desc,
      String quantity,
      String unitPrice,
      String totalAmount,
      String name,
      String taxRate);

  Future<CommonModelClass?> deleteLineItemDetail(
    String invoiceId,
  );
}
