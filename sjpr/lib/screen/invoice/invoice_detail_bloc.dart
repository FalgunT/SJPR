import 'dart:async';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/invoice_detail_model.dart';
import 'package:sjpr/model/invoice_list_model.dart';
import 'package:sjpr/model/lineitem_list_model.dart';
import 'package:sjpr/model/ownedby_list_model.dart';
import 'package:sjpr/model/type_list_model.dart';

import '../../model/category_list_model.dart';
import '../../model/product_list_model.dart';
import '../../widgets/check_box.dart';

class InvoiceDetailBloc extends BlocBase {
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

  List<CategoryListData> cList = [];
  List<TypeListData> tList = [];
  List<OwnedByListData> oList = [];
  List<ProductServicesListData> pList = [];

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
        invoiceDetailStreamController.sink.add(getInvoiceDetailResponse.data!);
      } else {}
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
      /* if (getLineItemListResponse.status == false &&
          getLineItemListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getLineItemListResponse.message!);
      }*/
      cList = getCategoryListResponse.data!.categories;
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
    }
  }

  Future getDetailOwnBy(BuildContext context, String invoiceId) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getOwnedByList();
    if (getCategoryListResponse != null) {
      /* if (getLineItemListResponse.status == false &&
          getLineItemListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getLineItemListResponse.message!);
      }*/
      oList = getCategoryListResponse.data!;
    }
  }
  Future getProductService(BuildContext context, String invoiceId) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getProductList();
    if (getCategoryListResponse != null) {
      /* if (getLineItemListResponse.status == false &&
          getLineItemListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getLineItemListResponse.message!);
      }*/
      pList = getCategoryListResponse.data!;
    }
  }



  getCheckBoxList(int flag) async {
    List<CheckBoxItem> cItems = [];
    if (flag == 0) {
      for (CategoryListData? obj in cList) {
        cItems.add(CheckBoxItem.withChildren(
            isSelected: false, text: obj!.name!, itemId: obj.id!, myChildren: obj.list!));
      }
    } else if (flag == 1) {
      for (ProductServicesListData? obj in pList) {
        cItems.add(CheckBoxItem(
            isSelected: false, text: obj!.productServicesName!, itemId: obj.id!));
      }
    }
    else if (flag == 2) {
      for (TypeListData? obj in tList) {
        cItems.add(CheckBoxItem(
            isSelected: false, text: obj!.typeName!, itemId: obj.id!));
      }
    }
    else if (flag == 3) {
      for (OwnedByListData? obj in oList) {
        cItems.add(CheckBoxItem(
            isSelected: false, text: obj!.ownedByName!, itemId: obj.id!));
      }
    }

    return cItems;
  }

  @override
  void dispose() {}
}
