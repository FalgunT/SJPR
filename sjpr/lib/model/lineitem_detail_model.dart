class LineItemDetailApiResponse {
  bool status;
  String message;
  int totalCount;
  List<LineItem> data;

  LineItemDetailApiResponse({
    required this.status,
    required this.message,
    required this.totalCount,
    required this.data,
  });

  factory LineItemDetailApiResponse.fromJson(Map<String, dynamic> json) {
    return LineItemDetailApiResponse(
      status: json['status'],
      message: json['message'],
      totalCount: json['total_count'],
      data: List<LineItem>.from(
          json['data'].map((item) => LineItem.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'total_count': totalCount,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class LineItem {
  String id = "-1";
  String invoiceId = "-1";
  String name = "Line Item";
  String description = "Desc";
  String quantity = "0";
  String unitPrice = "0.0";
  String taxRate = "0.0";
  String totalAmount = "0.0";
  String categoryId = "-1";
  String productId = "-1";
  String customerId = "-1";
  String classId = "-1";
  String locationId = "-1";
  String taxRateId = "-1";
  String netAmount = "0.0";
  String datetime = "";

  LineItem({
    required this.id,
    required this.invoiceId,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.taxRate,
    required this.totalAmount,
    required this.categoryId,
    required this.productId,
    required this.customerId,
    required this.classId,
    required this.locationId,
    required this.taxRateId,
    required this.netAmount,
    required this.datetime,
  });

  LineItem.empty();

  factory LineItem.fromJson(Map<String, dynamic> json) {
    return LineItem(
      id: json['id'],
      invoiceId: json['tblapi_save_scanned_invoice_id'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      taxRate:
          (json['tax_rate'] != null && json['tax_rate']!.toString().isNotEmpty)
              ? json['tax_rate']
              : "0.0",
      totalAmount: json['total_amount'],
      categoryId: json['scanned_line_item_category_id'],
      productId: json['product_services_id'],
      customerId: json['customers_id'],
      classId: json['class_id'],
      locationId: json['location_id'],
      taxRateId: json['tax_rate_id'],
      netAmount: json['net_amount'],
      datetime: json['datetime'],
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id,
      'tblapi_save_scanned_invoice_id': invoiceId,
      'name': name,
      'description': description,
      'quantity': quantity,
      'unit_price': unitPrice,
      'tax_rate': taxRate,
      'total_amount': totalAmount,
      'scanned_line_item_category_id': categoryId,
      'product_services_id': productId,
      'customers_id': customerId,
      'class_id': classId,
      'location_id': locationId,
      'tax_rate_id': taxRateId,
      'net_amount': netAmount,
      'datetime': datetime,
    };
  }
}
