class InvoiceList {
  bool? status;
  String? error;
  String? message;
  int? totalCount;
  List<InvoiceListData>? data;

  InvoiceList({this.status, this.message, this.totalCount, this.data});

  InvoiceList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <InvoiceListData>[];
      json['data'].forEach((v) {
        data?.add(InvoiceListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['total_count'] = totalCount;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['archiveData'] = <InvoiceListData>[];
    return data;
  }
}

class InvoiceListData {
  String? id;
  String? userId;
  String? scanInvoice;
  String? readStatus;
  String? date;
  String? currency;
  String? totalAmount;
  String? supplierName;

  InvoiceListData(
      {this.id,
      this.userId,
      this.scanInvoice,
      this.readStatus,
      this.date,
      this.currency,
      this.totalAmount,
      this.supplierName});

  InvoiceListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    scanInvoice = json['scan_invoice'];
    readStatus = json['read_status'];
    date = json['date'];
    currency = json['currency'];
    totalAmount = json['total_amount'];
    supplierName = json['supplier_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['scan_invoice'] = scanInvoice;
    data['read_status'] = readStatus;
    data['date'] = date;
    data['currency'] = currency;
    data['total_amount'] = totalAmount;
    data['supplier_name'] = supplierName;
    return data;
  }
}
