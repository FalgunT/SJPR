class ApiResponseTaxRate {
  final bool status;
  final String message;
  final List<DataItem> data;

  ApiResponseTaxRate({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponseTaxRate.fromJson(Map<dynamic, dynamic> json) {
    return ApiResponseTaxRate(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => DataItem.fromJson(item))
          .toList(),
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class DataItem {
  final String id;
  final String taxRate;
  final String datetime;

  DataItem({
    required this.id,
    required this.taxRate,
    required this.datetime,
  });

  factory DataItem.fromJson(Map<dynamic, dynamic> json) {
    return DataItem(
      id: json['id'],
      taxRate: json['tax_rate'],
      datetime: json['datetime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tax_rate': taxRate,
      'datetime': datetime,
    };
  }
}
