import 'lineitem_detail_model.dart';

class LineItemList {
  bool? status;
  String? message;
  int? totalCount;
  List<LineItemListData>? data;

  LineItemList({this.status, this.message, this.totalCount, this.data});

  factory LineItemList.fromJson(Map<String, dynamic> json) {
    return LineItemList(
      status: json['status'],
      message: json['message'],
      totalCount: json['total_count'],
      data: List<LineItemListData>.from(
          json['data'].map((item) => LineItemListData.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'total_count': totalCount,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class LineItemListData {
  LineItemListData.empty();

  late String id;
  late String tblapiSaveScannedInvoiceId;
  late String name;
  late String description;
  late String quantity;
  late String unitPrice;
  late String taxRate;
  late String totalAmount;
  late String scannedLineItemCategoryId;
  late String? productServicesId;
  late String? customersId;
  late String? classId;
  late String? locationId;
  late String? taxRateId;
  late String? netAmount;
  late String datetime;
  late String scannedCurrencyId;

  LineItemListData({
    required this.id,
    required this.tblapiSaveScannedInvoiceId,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.taxRate,
    required this.totalAmount,
    required this.scannedLineItemCategoryId,
    this.productServicesId,
    this.customersId,
    this.classId,
    this.locationId,
    this.taxRateId,
    this.netAmount,
    required this.datetime,
    required this.scannedCurrencyId,
  });

  factory LineItemListData.fromJson(Map<String, dynamic> json) {
    return LineItemListData(
      id: json['id'],
      tblapiSaveScannedInvoiceId: json['tblapi_save_scanned_invoice_id'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      taxRate: json['tax_rate'],
      totalAmount: json['total_amount'],
      scannedLineItemCategoryId: json['scanned_line_item_category_id'],
      productServicesId: json['product_services_id'],
      customersId: json['customers_id'],
      classId: json['class_id'],
      locationId: json['location_id'],
      taxRateId: json['tax_rate_id'],
      netAmount: json['net_amount'],
      datetime: json['datetime'],
      scannedCurrencyId: json['scanned_currency_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tblapi_save_scanned_invoice_id': tblapiSaveScannedInvoiceId,
      'name': name,
      'description': description,
      'quantity': quantity,
      'unit_price': unitPrice,
      'tax_rate': taxRate,
      'total_amount': totalAmount,
      'scanned_line_item_category_id': scannedLineItemCategoryId,
      'product_services_id': productServicesId,
      'customers_id': customersId,
      'class_id': classId,
      'location_id': locationId,
      'tax_rate_id': taxRateId,
      'net_amount': netAmount,
      'datetime': datetime,
      'scanned_currency_id': scannedCurrencyId,
    };
  }
}
