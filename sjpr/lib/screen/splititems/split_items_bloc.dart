import 'dart:async';
import 'package:intl/intl.dart';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/category_list_model.dart';
import 'package:sjpr/model/split_list_model.dart';

class SplitItemsBloc extends BlocBase {
  static SplitItemsBloc? _instance;
  StreamController mainStreamController = StreamController.broadcast();
  TextEditingController eController = TextEditingController();
  Stream get mainStream => mainStreamController.stream;

  Stream<List<SplitListData>?> get splitItemListStream =>
      splitItemListStreamController.stream;

  StreamController<List<SplitListData>?> splitItemListStreamController =
      StreamController.broadcast();

  Stream<SplitListData?> get splitItemDetailStream =>
      splitItemDetailStreamController.stream;
  StreamController<SplitListData?> splitItemDetailStreamController =
      StreamController.broadcast();
  List<CategoryListData> categoryList = [];

  ValueNotifier<List<SplitListData>> splitItemListLocal =
      ValueNotifier<List<SplitListData>>([]);

  ValueNotifier<SplitListData> splitItemDetail =
      ValueNotifier<SplitListData>(SplitListData());

  ValueNotifier<String> selectedValueC = ValueNotifier<String>("None");
  List<SplitListData> splitItemListToBeUpdated = [];

  static SplitItemsBloc getInstance() {
    _instance ??= SplitItemsBloc();
    return _instance!;
  }

  Future getSplitItemList(BuildContext context, String invoiceId) async {
    var getLineItemListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getSplitItemList(invoiceId);
    if (getLineItemListResponse != null) {
      splitItemListStreamController.sink.add(getLineItemListResponse.data);
      //List<SplitListData>? tempList = getLineItemListResponse.data!;
      splitItemListToBeUpdated =
          List<SplitListData>.from(getLineItemListResponse.data!);
      splitItemListLocal.value = getLineItemListResponse.data!;
    }
  }

  Future updateSplitItemList(BuildContext context) async {
    //List<SplitListDataRequest> lstSplitListDataRequest = [];
    /* for (var element in splitItemListLocal.value) {
      SplitListDataRequest splitListDataRequest = SplitListDataRequest();
    }*/
    var updateSplitItemListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .updateSplitItemList(splitItemListToBeUpdated);
    if (updateSplitItemListResponse != null) {}
  }

  Future getDetailCategory(BuildContext context) async {
    var getCategoryListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getCategoryList();
    if (getCategoryListResponse != null) {
      categoryList = getCategoryListResponse.data!.categories;

      for (var element in categoryList) {
        element.list?.forEach(
          (o) {
            if (o.sub_category_id == splitItemDetail.value.categoryId) {
              selectedValueC.value = o.sub_category_name ?? 'None';
            }
          },
        );
      }
    }
  }

  String? getCategoryNameFromId(String categoryId) {
    String? categoryName = "";
    for (var element in categoryList) {
      element.list?.forEach(
        (o) {
          if (o.sub_category_id == categoryId) {
            categoryName = o.sub_category_name ?? 'None';
          }
        },
      );
    }
    return categoryName;
  }

  addSplitItem(SplitListData item) {
    splitItemListLocal.value = List.from(splitItemListLocal.value)..add(item);
    item.action = 'insert';
    splitItemListToBeUpdated.add(item);
  }

  updateSplitItem(SplitListData item) {
    var index =
        splitItemListLocal.value.indexWhere((element) => element.id == item.id);
    splitItemListLocal.value.removeAt(index);
    item.action = 'update';
    splitItemListLocal.value = List.from(splitItemListLocal.value)
      ..insert(index, item);
    //splitItemListToBeUpdated.where((element) => element.id == item.id).first;
    splitItemListToBeUpdated[splitItemListToBeUpdated
        .indexWhere((element) => element.id == item.id)] = item;
  }

  deleteSplitItem(SplitListData item) {
    item.action = 'delete';
    splitItemListToBeUpdated[splitItemListToBeUpdated
        .indexWhere((element) => element.id == item.id)] = item;
    splitItemListLocal.value.removeWhere((element) => element.id == item.id);
  }

  deleteMultipleSplitItems() {
    splitItemListLocal.value
        .removeWhere((element) => element.isSelected == true);
  }

  getFormatted(String input) {
    if (input.isEmpty) {
      input = "0";
    }
    input = input.replaceAll(',', '');
    double number = double.parse(input);
    return NumberFormat('##0.00').format(number);
  }

  @override
  void dispose() {
    _instance?.dispose();
  }
}
