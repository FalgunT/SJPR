import 'dart:async';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/model/invoice_list_model.dart';

class DocumentBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  Stream get mainStream => mainStreamController.stream;
  StreamController<List<InvoiceListData>?> invoiceListStreamController =
      StreamController.broadcast();

  Stream<List<InvoiceListData>?> get invoiceListStream =>
      invoiceListStreamController.stream;
/*
  Future uploadInvoice(BuildContext context, File file) async {
    var getInvoiceListResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .uploadInvoice(invoice: file);
    if (getInvoiceListResponse != null &&
        getInvoiceListResponse.status == true) {
      //invoiceListStreamController.sink.add(getInvoiceListResponse.data!);
    }
  }*/

  @override
  void dispose() {}
}
