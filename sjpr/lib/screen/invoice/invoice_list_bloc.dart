import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/invoice_list_model.dart';
import 'package:sjpr/screen/invoice/custom_camera.dart';

class InvoiceBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;
  StreamController<InvoiceList?> invoiceListStreamController =
      StreamController.broadcast();

  Stream<InvoiceList?> get invoiceListStream =>
      invoiceListStreamController.stream;

  Future getInvoiceList(BuildContext context) async {
    var getInvoiceListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getInvoiceList();
    if (getInvoiceListResponse != null) {
      if (getInvoiceListResponse.message != null) {
        CommonToast.getInstance()?.displayToast(
            message: getInvoiceListResponse.message!, bContext: context);
      }
      if (getInvoiceListResponse.status == true) {
        invoiceListStreamController.sink.add(getInvoiceListResponse);
      } else {}
    }
  }

  Future uploadInvoice(BuildContext context, XFile invoice) async {
    var getInvoiceListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .uploadInvoice(invoice: invoice);
    if (getInvoiceListResponse != null &&
        getInvoiceListResponse.status == true) {
      //invoiceListStreamController.sink.add(getInvoiceListResponse.data!);
    }
    if (getInvoiceListResponse != null) {
      if (getInvoiceListResponse.message != null) {
        CommonToast.getInstance()?.displayToast(
            message: getInvoiceListResponse.message!, bContext: context);
      }
    }
  }

  @override
  void dispose() {}

  uploadMultiInvoice(
      BuildContext context, List<CaptureModel> captures, String uploadMode) async {
    var getInvoiceListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .uploadMultiInvoice(invoice: captures, uploadMode: uploadMode);
    if (getInvoiceListResponse != null &&
        getInvoiceListResponse.status == true) {
      //invoiceListStreamController.sink.add(getInvoiceListResponse.data!);
    }
    if (getInvoiceListResponse != null) {
      if (getInvoiceListResponse.message != null) {
        CommonToast.getInstance()?.displayToast(
            message: getInvoiceListResponse.message!, bContext: context);
      }
    }
  }
}
