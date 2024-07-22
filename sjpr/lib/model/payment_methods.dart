class PaymentMethodsModel{


  String? id;
  String? method_name;
  String? status;
  String? datetime;

  PaymentMethodsModel({required this.id, required this.method_name,
    required this.status, required this.datetime});

  PaymentMethodsModel.empty();

  factory PaymentMethodsModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodsModel(
        id: json['id'],
        method_name: json['method_name'],
        status: json['status'],
        datetime: json['datetime']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'method_name': method_name,
    'status': status,
    'datetime': datetime,
  };


  @override
  String toString() {
    return 'PaymentMethodsModel{id: $id, method_name: $method_name, status: $status, datetime: $datetime}';
  }
}