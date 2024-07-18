class LineItemList {
  bool? status;
  String? message;
  int? totalCount;
  List<LineItemListData>? data;

  LineItemList({this.status, this.message, this.totalCount, this.data});

  LineItemList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <LineItemListData>[];
      json['data'].forEach((v) {
        data!.add(LineItemListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['total_count'] = totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineItemListData {
  String? id;
  String? tblapiSaveScannedInvoiceId;
  String? name;
  String? description;
  String? quantity;
  String? unitPrice;
  dynamic? taxRate;
  String? totalAmount;
  String? datetime;

  LineItemListData(
      {this.id,
      this.tblapiSaveScannedInvoiceId,
      this.name,
      this.description,
      this.quantity,
      this.unitPrice,
      this.taxRate,
      this.totalAmount,
      this.datetime});

  LineItemListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tblapiSaveScannedInvoiceId = json['tblapi_save_scanned_invoice_id'];
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    taxRate = json['tax_rate'];
    totalAmount = json['total_amount'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tblapi_save_scanned_invoice_id'] = tblapiSaveScannedInvoiceId;
    data['name'] = name;
    data['description'] = description;
    data['quantity'] = quantity;
    data['unit_price'] = unitPrice;
    data['tax_rate'] = taxRate;
    data['total_amount'] = totalAmount;
    data['datetime'] = datetime;
    return data;
  }
}
