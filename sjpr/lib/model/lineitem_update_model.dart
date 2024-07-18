class LineItemDetailUpdate {
  bool? status;
  String? message;
  LineItemDetailUpdateData? data;

  LineItemDetailUpdate({this.status, this.message, this.data});

  LineItemDetailUpdate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new LineItemDetailUpdateData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LineItemDetailUpdateData {
  String? name;
  String? description;
  String? quantity;
  String? unitPrice;
  String? taxRate;
  String? totalAmount;

  LineItemDetailUpdateData(
      {this.name,
      this.description,
      this.quantity,
      this.unitPrice,
      this.taxRate,
      this.totalAmount});

  LineItemDetailUpdateData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    taxRate = json['tax_rate'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    data['tax_rate'] = this.taxRate;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}
