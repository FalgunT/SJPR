class CustomerApiResponse {
  final bool status;
  final String message;
  final String error;
  final List<Customer> data;

  CustomerApiResponse(
      {required this.status,
      required this.message,
      required this.error,
      required this.data});

  factory CustomerApiResponse.fromJson(Map<dynamic, dynamic> json) {
    return CustomerApiResponse(
      status: json['status'],
      message: json['message'],
      error: json.containsKey('error') ? json['error'].toString() : "",
      data: json.containsKey('data')
          ? (json['data'] as List)
              .map((item) => Customer.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'error': error,
      'data': data.map((customer) => customer.toJson()).toList(),
    };
  }
}

class Customer {
  final String id;
  final String customerName;
  final String datetime;

  Customer(
      {required this.id, required this.customerName, required this.datetime});

  factory Customer.fromJson(Map<dynamic, dynamic> json) {
    return Customer(
      id: json['id'],
      customerName: json['customer_name'],
      datetime: json['datetime'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'customer_name': customerName,
      'datetime': datetime,
    };
  }
}
