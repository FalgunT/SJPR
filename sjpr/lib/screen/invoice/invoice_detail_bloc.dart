import 'dart:async';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/currency_model.dart';
import 'package:sjpr/model/invoice_detail_model.dart';
import 'package:sjpr/model/invoice_list_model.dart';
import 'package:sjpr/model/lineitem_list_model.dart';
import 'package:sjpr/model/ownedby_list_model.dart';
import 'package:sjpr/model/payment_methods.dart';
import 'package:sjpr/model/publish_to.dart';
import 'package:sjpr/model/type_list_model.dart';

import '../../model/category_list_model.dart';
import '../../model/product_list_model.dart';
import '../../widgets/check_box.dart';

class InvoiceDetailBloc extends BlocBase {
  Updater update;

  InvoiceDetailBloc({required this.update});

  late InvoiceDetailData? invoiceDetailData;

  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;
  StreamController<InvoiceDetailData?> invoiceDetailStreamController =
      StreamController.broadcast();

  Stream<InvoiceDetailData?> get invoiceDetailStream =>
      invoiceDetailStreamController.stream;

  Stream<List<LineItemListData>?> get lineItemListStream =>
      lineItemListStreamController.stream;

  StreamController<List<LineItemListData>?> lineItemListStreamController =
      StreamController.broadcast();

  List<PaymentMethodsModel> pmList = [];
  List<PublishToModel> publishToList = [];

  List<CurrencyModel> curList = [];
  List<CategoryListData> cList = [];
  List<TypeListData> tList = [];

  //List<OwnedByListData> oList = [];
  List<ProductServicesListData> pList = [];

  SubCategoryData selectedData = SubCategoryData.empty();
  ProductServicesListData selectedPData = ProductServicesListData.empty();
  TypeListData selectedTData = TypeListData.empty();
  CurrencyModel selectedCurrency = CurrencyModel.empty();
  PaymentMethodsModel selectedPM = PaymentMethodsModel.empty();
  PublishToModel selectedPublishTo = PublishToModel.empty();

  //StreamController<List<CategoryListData>?> categoryListDataStreamController =
  //StreamController.broadcast();

  Future getInvoiceDetail(BuildContext context, String id) async {
    var getInvoiceDetailResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getInvoiceDetail(id);
    if (getInvoiceDetailResponse != null) {
      if (getInvoiceDetailResponse.status == false &&
          getInvoiceDetailResponse.message != null) {
        CommonToast.getInstance()?.displayToast(
            message: getInvoiceDetailResponse.message!, bContext: context);
      }
      if (getInvoiceDetailResponse.status == true) {
        invoiceDetailData = getInvoiceDetailResponse.data;
        invoiceDetailStreamController.sink.add(getInvoiceDetailResponse.data!);
      }
    }
  }

  Future getLineItemList(BuildContext context, String invoiceId) async {
    var getLineItemListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getLineItemList(invoiceId);
    if (getLineItemListResponse != null) {
      /* if (getLineItemListResponse.status == false &&
          getLineItemListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getLineItemListResponse.message!);
      }*/
      lineItemListStreamController.sink.add(getLineItemListResponse.data);
    }
  }

  Future getDetailCategory(BuildContext context, String invoiceId) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getCategoryList();
    if (getCategoryListResponse != null) {
      cList = getCategoryListResponse.data!.categories;
      cList.forEach(
        (element) {
          element.list?.forEach(
            (o) {
              if (o.sub_category_id == invoiceDetailData?.scanned_category_id) {
                selectedData = o;
                update.updateWidget();
              }
            },
          );
        },
      );
    }
  }

  Future getDetailType(BuildContext context, String invoiceId) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getTypeList();
    if (getCategoryListResponse != null) {
      /* if (getLineItemListResponse.status == false &&
          getLineItemListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getLineItemListResponse.message!);
      }*/
      tList = getCategoryListResponse.data!;

      tList.forEach(
        (element) {
          if (element.id == invoiceDetailData?.scanned_type_id) {
            selectedTData = element;
            update.updateWidget();
          }
        },
      );
    }
  }

  /*Future getDetailOwnBy(BuildContext context, String invoiceId) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getOwnedByList();
    if (getCategoryListResponse != null) {
      */ /* if (getLineItemListResponse.status == false &&
          getLineItemListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getLineItemListResponse.message!);
      }*/ /*
      oList = getCategoryListResponse.data!;

    }
  }
*/
  Future getProductService(BuildContext context, {bool isAdd = false}) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getProductList();
    if (getCategoryListResponse != null) {
      pList = getCategoryListResponse.data!;
      pList.forEach(
        (element) {
          if (element.id == invoiceDetailData?.scanned_product_service_id) {
            selectedPData = element;
            update.updateWidget();
          }
        },
      );
      if (isAdd) {
        selectedPData = pList.last;
        update.updateWidget();
      }
    }
  }

  Future addProductService(BuildContext context, String pName) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .addProduct(pName: pName);
    if (getCategoryListResponse != null) {
      //refresh the page...
      getProductService(context, isAdd: true);
    }
  }

  Future getCurrency(BuildContext context) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getCurrencyList();
    if (getCategoryListResponse != null) {
      curList = getCategoryListResponse;
      curList.forEach(
        (element) {
          if (element.id == invoiceDetailData?.currency) {
            selectedCurrency = element;
            update.updateWidget();
          }
        },
      );
    }
  }

  Future getPaymentMethods(BuildContext context) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getpaymentmethod();
    if (getCategoryListResponse != null) {
      pmList = getCategoryListResponse;
      pmList.forEach(
        (element) {
          if (element.id == invoiceDetailData?.payment_method_id) {
            selectedPM = element;
            update.updateWidget();
          }
        },
      );
    }
  }

  Future getPublishTo(BuildContext context) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getPublishTo();
    if (getCategoryListResponse != null) {
      publishToList = getCategoryListResponse;
      publishToList.forEach(
        (element) {
          if (element.id == invoiceDetailData?.payment_method_id) {
            selectedPublishTo = element;
            update.updateWidget();
          }
        },
      );
    }
  }

  Future<void> updateScannedInvoice(Map<String, String> json) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .updateScannedInvoice(json);
  }

  getCheckBoxList(int flag) async {
    List<CheckBoxItem> cItems = [];
    if (flag == 0) {
      for (CategoryListData? obj in cList) {
        cItems.add(CheckBoxItem.withChildren(
            isSelected: false,
            text: obj!.name!,
            itemId: obj.id!,
            myChildren: obj.list!));
      }
    } else if (flag == 1) {
      for (ProductServicesListData? obj in pList) {
        cItems.add(CheckBoxItem(
            isSelected: false,
            text: obj!.productServicesName!,
            itemId: obj.id!));
      }
    } else if (flag == 2) {
      for (TypeListData? obj in tList) {
        cItems.add(CheckBoxItem(
            isSelected: false, text: obj!.typeName!, itemId: obj.id!));
      }
    } else if (flag == 6) {
      for (CurrencyModel? obj in curList) {
        cItems.add(CheckBoxItem(
            isSelected: false, text: obj!.currency_name!, itemId: obj.id!));
      }
    } else if (flag == 7) {
      for (PaymentMethodsModel? obj in pmList) {
        cItems.add(CheckBoxItem(
            isSelected: false, text: obj!.method_name!, itemId: obj.id!));
      }
    } else if (flag == 8) {
      for (PublishToModel? obj in publishToList) {
        cItems.add(
            CheckBoxItem(isSelected: false, text: obj!.name!, itemId: obj.id!));
      }
    }

    return cItems;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

class Updater {
  updateWidget() {
    debugPrint('updateWidget called!');
  }
}
