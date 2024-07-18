import 'dart:async';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/lineitem_detail_model.dart';
import 'package:sjpr/model/ownedby_list_model.dart';

class LineItemsBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();

  StreamController<List<LineItemDetailData>?> lineItemDetailStreamController =
      StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;

  Stream<List<LineItemDetailData>?> get lineItemDetailStream =>
      lineItemDetailStreamController.stream;

  Future getLineItemDetail(BuildContext context, String lineItemId) async {
    var getLineItemListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getLineItemDetail(lineItemId);
    if (getLineItemListResponse != null) {
      if (getLineItemListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getLineItemListResponse.message!);
      }
      if (getLineItemListResponse.status == true) {
        lineItemDetailStreamController.sink.add(getLineItemListResponse.data);
      } else {}
    }
  }

  @override
  void dispose() {}
}
