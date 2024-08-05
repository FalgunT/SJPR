import 'dart:async';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/lineitem_detail_model.dart';
import 'package:sjpr/model/split_list_model.dart';
import '../../model/lineitem_list_model.dart';

class SplitItemsBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;

  Stream<List<SplitListData>?> get splitItemListStream =>
      splitItemListStreamController.stream;

  StreamController<List<SplitListData>?> splitItemListStreamController =
      StreamController.broadcast();
  Stream<SplitListData?> get splitItemDetailStream =>
      splitItemDetailStreamController.stream;
  StreamController<SplitListData?> splitItemDetailStreamController =
      StreamController.broadcast();

  Future getSplitItemList(BuildContext context, String invoiceId) async {
    var getLineItemListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getSplitItemList(invoiceId);
    if (getLineItemListResponse != null) {
      /* if (getLineItemListResponse.status == false &&
          getLineItemListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getLineItemListResponse.message!);
      }*/
      splitItemListStreamController.sink.add(getLineItemListResponse.data);
    }
  }

  /*Future getSplitItemDetail(BuildContext context, String splitItemId) async {
    var getSplitItemDetailResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .g(splitItemId);
    if (getSplitItemDetailResponse != null) {
      if (getSplitItemDetailResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getSplitItemDetailResponse.message!);
      }
      if (getSplitItemDetailResponse.status == true) {
        splitItemDetailStreamController.sink
            .add(getSplitItemDetailResponse.data);
      } else {}
    }
  }*/

  @override
  void dispose() {}
}
