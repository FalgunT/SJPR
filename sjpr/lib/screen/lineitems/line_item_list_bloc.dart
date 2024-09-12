import 'package:flutter/cupertino.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/model/lineitem_list_model.dart';

import '../../common/bloc_provider.dart';
import '../../di/app_component_base.dart';

class LineItemListBloc extends BlocBase {
  ValueNotifier<List<LineItemListData>> lineItemListData =
      ValueNotifier<List<LineItemListData>>([]);

  Future getLineItemList(BuildContext context, String invoiceId) async {
    var getLineItemListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getLineItemList(invoiceId);
    if (getLineItemListResponse != null) {
      lineItemListData.value = getLineItemListResponse.data!;

      if (getLineItemListResponse.status == false &&
          getLineItemListResponse.message != null) {
        CommonToast.getInstance()
            ?.displayToast(message: getLineItemListResponse.message!);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
