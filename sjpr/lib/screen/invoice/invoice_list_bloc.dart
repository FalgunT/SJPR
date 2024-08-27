import 'dart:async';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/invoice_list_model.dart';
import 'package:sjpr/screen/invoice/custom_camera.dart';
import 'package:sjpr/screen/invoice/invoice_list.dart';

import 'custom_camera2.dart';

class InvoiceBloc extends BlocBase {
  // StreamController mainStreamController = StreamController.broadcast();
  // Stream get mainStream => mainStreamreamController.stream;

  ///StreamController<InvoiceList?> invoiceListStreamController = StreamController.broadcast();
  // Stream<InvoiceList?> get invoiceListStream => invoiceListStreamController.stream;

  //StreamController<InvoiceList?> invoiceArcListStreamController = StreamController.broadcast();
  // Stream<InvoiceList?> get invoiceArcListStream => invoiceListStreamController.stream;

  ValueNotifier<List<InvoiceListData>> inboxListData =
      ValueNotifier<List<InvoiceListData>>([]);
  ValueNotifier<bool> isWaitingInbox = ValueNotifier<bool>(true);
  ValueNotifier<bool> isWaitingArchive = ValueNotifier<bool>(true);
  ValueNotifier<List<InvoiceListData>> archiveListData =
      ValueNotifier<List<InvoiceListData>>([]);

  Future getInvoiceList(BuildContext context) async {
    isWaitingInbox.value = true;
    var getInvoiceListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getInvoiceList();
    if (getInvoiceListResponse != null) {
      if (getInvoiceListResponse.status == true) {
        inboxListData.value = getInvoiceListResponse.data!;
        // invoiceListStreamController.sink.add(getInvoiceListResponse);
      } else if (getInvoiceListResponse.message != null) {
        CommonToast.getInstance()?.displayToast(
            message: getInvoiceListResponse.message!, bContext: context);
      }
    }
    isWaitingInbox.value = false;
  }

  Future getArchiveList(BuildContext context) async {
    isWaitingArchive.value = true;
    var getInvoiceListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getArchiveList('', 0);
    if (getInvoiceListResponse != null) {
      if (getInvoiceListResponse.status == true) {
        archiveListData.value = getInvoiceListResponse.data!;
        //invoiceArcListStreamController.sink.add(getInvoiceListResponse);
      } else if (getInvoiceListResponse.message != null) {
        CommonToast.getInstance()?.displayToast(
            message: getInvoiceListResponse.message!, bContext: context);
      }
    }
    isWaitingArchive.value = false;
  }

 /*
 old
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
  uploadMultiInvoice(BuildContext context, List<CaptureModel> captures,
      String uploadMode) async {
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
  }*/

  Future uploadInvoice(BuildContext context, String path) async {
    var getInvoiceListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .uploadInvoice(invoicepath: path);
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
  uploadMultiInvoice(BuildContext context, List<CaptureModel> captures,
      String uploadMode) async {
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

  Future MovetoInbox(String id) async {
    var getResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .MovetoInbox(id);
    if (getResponse != null) {
      return getResponse.status;
    }
    return false;
  }

  DeleteInvoice(String id, BuildContext context) async {
    var getResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .DeleteInvoice(id);
    if (getResponse != null) {
      if (getResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getResponse.message!, bContext: context);
      }
      return getResponse.status;
    }
    return false;
  }

  String getInvoiceStatus(String id) {
    switch (id) {
      case '0':
        return 'updating';
      case '1':
        return 'To review';
      case '2':
        return 'Pending';
      case '3':
        return 'Processing';
      case '4':
        return 'Canceled';
      case '5':
        return 'Published';
    }
    return 'Unknown';
  }

  @override
  void dispose() {}
}
