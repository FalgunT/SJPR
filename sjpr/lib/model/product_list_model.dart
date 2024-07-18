class ProductServicesList {
  bool? status;
  String? error;
  String? message;
  List<ProductServicesListData>? data;

  ProductServicesList({this.status, this.message, this.data});

  ProductServicesList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProductServicesListData>[];
      json['data'].forEach((v) {
        data!.add(ProductServicesListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductServicesListData {
  String? id;
  String? productServicesName;
  String? productServicesStatus;
  String? datetime;

  ProductServicesListData(
      {this.id,
      this.productServicesName,
      this.productServicesStatus,
      this.datetime});

  ProductServicesListData.empty();

  ProductServicesListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productServicesName = json['product_services_name'];
    productServicesStatus = json['product_services_status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_services_name'] = productServicesName;
    data['product_services_status'] = productServicesStatus;
    data['datetime'] = datetime;
    return data;
  }
}
