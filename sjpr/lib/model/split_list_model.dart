class SplitList {
  bool? status;
  String? message;
  int? totalCount;
  List<SplitListData>? data;

  SplitList({this.status, this.message, this.totalCount, this.data});

  SplitList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <SplitListData>[];
      json['data'].forEach((v) {
        data!.add(new SplitListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['total_count'] = this.totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SplitListData {
  String? id;

  String? scannedInvoiceId;

  String? categoryId;

  String? totalAmount;

  String? taxAmount = '0.0';

  String? action;

  bool? isSelected;

  SplitListData(
      {this.id,
      this.scannedInvoiceId,
      this.categoryId,
      this.totalAmount,
      this.taxAmount,
      this.action,
      this.isSelected});

  SplitListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scannedInvoiceId = json['scanned_invoice_id'];
    categoryId = json['category_id'];
    totalAmount = json['total_amount'];
    taxAmount = json['tax_amount'];
    action = json['action'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['scanned_invoice_id'] = scannedInvoiceId;
    data['category_id'] = categoryId;
    data['total_amount'] = totalAmount;
    data['tax_amount'] = taxAmount;
    data['action'] = action;
    data['isSelected'] = isSelected;

    return data;
  }
}
