import 'dart:async';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/category_list_model.dart';
import 'package:sjpr/model/invoice_list_model.dart';
import 'package:sjpr/model/ownedby_list_model.dart';
import 'package:sjpr/model/product_list_model.dart';
import 'package:sjpr/model/type_list_model.dart';

class ExportDataBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  StreamController<List<CategoryListData>?> categoryListStreamController =
      StreamController.broadcast();
  StreamController<List<ProductServicesListData>?> productListStreamController =
      StreamController.broadcast();
  StreamController<List<TypeListData>?> typeListStreamController =
      StreamController.broadcast();
  StreamController<List<OwnedByListData>?> ownedByListStreamController =
      StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;
  Stream<List<CategoryListData>?> get categoryListStream =>
      categoryListStreamController.stream;
  Stream<List<ProductServicesListData>?> get productListStream =>
      productListStreamController.stream;
  Stream<List<TypeListData>?> get typeListStream =>
      typeListStreamController.stream;
  Stream<List<OwnedByListData>?> get ownedByListStream =>
      ownedByListStreamController.stream;

  Future getCategoryList(BuildContext context) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getCategoryList();
    if (getCategoryListResponse != null) {
      if (getCategoryListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getCategoryListResponse.message!,bContext: context);
      }
      if (getCategoryListResponse.status == true) {
        categoryListStreamController.sink.add(getCategoryListResponse.data!.categories);
      } else {}
    }
  }

  Future getProductList(BuildContext context) async {
    var getProductListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getProductList();
    if (getProductListResponse != null) {
      if (getProductListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getProductListResponse.message!,bContext: context);
      }
      if (getProductListResponse.status == true) {
        productListStreamController.sink.add(getProductListResponse.data);
      } else {}
    }
  }

  Future getTypeList(BuildContext context) async {
    var getTypeListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getTypeList();
    if (getTypeListResponse != null) {
      if (getTypeListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getTypeListResponse.message!,bContext: context);
      }
      if (getTypeListResponse.status == true) {
        typeListStreamController.sink.add(getTypeListResponse.data);
      } else {}
    }
  }

  Future getOwnedByList(BuildContext context) async {
    var getOwnedByListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getOwnedByList();
    if (getOwnedByListResponse != null) {
      if (getOwnedByListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getOwnedByListResponse.message!,bContext: context);
      }
      if (getOwnedByListResponse.status == true) {
        ownedByListStreamController.sink.add(getOwnedByListResponse.data);
      } else {}
    }
  }

  @override
  void dispose() {}
}
