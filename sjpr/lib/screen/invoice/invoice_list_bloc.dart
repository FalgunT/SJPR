import 'dart:async';
import 'package:intl/intl.dart';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/invoice_list_model.dart';

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

  ValueNotifier<String> compName = ValueNotifier<String>('');
  ValueNotifier<String> compEmail = ValueNotifier<String>('');
  int totalCountInbox = -1, totalCountArchive = -1;

  Future getInvoiceList(BuildContext context,
      {bool isBackground = true,
      required int isPurchase,
      required int page}) async {
    if (page == 0) {
      totalCountInbox = -1;
    }
    if (totalCountInbox == -1 || (page * 10) < totalCountInbox) {
      isWaitingInbox.value = true;
      var getInvoiceListResponse = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .getInvoiceList(
              isBackground: isBackground, isPurchase: isPurchase, page: page);
      if (getInvoiceListResponse != null) {
        totalCountInbox = getInvoiceListResponse.totalCount ?? 0;
        if (getInvoiceListResponse.status == true) {
          if (page == 0) {
            inboxListData.value = getInvoiceListResponse.data!;
          } else {
            List<InvoiceListData> oldData = inboxListData.value;
            oldData.addAll(getInvoiceListResponse.data!);
            inboxListData.value = oldData;
          }
          // invoiceListStreamController.sink.add(getInvoiceListResponse);
        } else if (getInvoiceListResponse.message != null) {
          CommonToast.getInstance()?.displayToast(
              message: getInvoiceListResponse.message!, bContext: context);
        }
      }
      isWaitingInbox.value = false;
    }
  }

  Future getArchiveList(BuildContext context,
      {required int isPurchase, required int page}) async {
    if (page == 0) {
      totalCountArchive = -1;
    }
    if (totalCountArchive == -1 || (page * 10) < totalCountArchive) {
      isWaitingArchive.value = true;
      var getInvoiceListResponse = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .getArchiveList('', isPurchase: isPurchase, page: page);
      if (getInvoiceListResponse != null) {
        totalCountArchive = getInvoiceListResponse.totalCount ?? 0;
        if (getInvoiceListResponse.status == true) {
          if (page == 0) {
            archiveListData.value = getInvoiceListResponse.data!;
          } else {
            List<InvoiceListData> oldData = archiveListData.value;
            oldData.addAll(getInvoiceListResponse.data!);
            archiveListData.value = oldData;
          }
        } else if (getInvoiceListResponse.message != null) {
          CommonToast.getInstance()?.displayToast(
              message: getInvoiceListResponse.message!, bContext: context);
        }
      }
      isWaitingArchive.value = false;
    }
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

  Future uploadInvoice(
      BuildContext context, String path, int isPurchase) async {
    var getInvoiceListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .uploadInvoice(invoicepath: path, isPurchase: isPurchase);
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
      String uploadMode, isPurchase) async {
    var getInvoiceListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .uploadMultiInvoice(
            invoice: captures, uploadMode: uploadMode, isPurchase: isPurchase);
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

  Future getProfile(BuildContext context) async {
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      var getProfile = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .profile();

      if (getProfile != null) {
        if (getProfile.status == true) {
          compEmail.value = '${getProfile.data?.email}';
          compName.value = '${getProfile.data?.companyName}';
          //profileStreamController.sink.add(getProfile.data);
        }
      }
    }
  }

  getFormetted(String input) {
    if (input.isEmpty) {
      input = "0";
    }
    String res = "0.00";
    try {
      double number = double.parse(input);
      res = NumberFormat('##0.00').format(number);
    } catch (e) {
      debugPrint(e.toString());
      res = "0.00";
    }
    return res;
  }

  @override
  void dispose() {
    inboxListData.dispose();
    archiveListData.dispose();
  }
}
