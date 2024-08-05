class ApiResponseLocationModel {
  final bool status;
  final String message;
  final String? error;
  final List<Record1> data;

  ApiResponseLocationModel({
    required this.status,
    required this.message,
    required this.error,
    required this.data,
  });

  factory ApiResponseLocationModel.fromJson(Map<dynamic, dynamic> json) {
    return ApiResponseLocationModel(
      status: json['status'],
      message: json['message'],
      error: json.containsKey('error') ? json['error'].toString() : "",
      data: json.containsKey('data')
          ? List<Record1>.from(
              json['data'].map((item) => Record1.fromJson(item)))
          : [],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'error': error,
      'data': data.map((record) => record.toJson()).toList(),
    };
  }
}

class Record1 {
  final String id;
  final String location;
  final String datetime;

  Record1({
    required this.id,
    required this.location,
    required this.datetime,
  });

  factory Record1.fromJson(Map<dynamic, dynamic> json) {
    return Record1(
      id: json['id'],
      location: json['location'],
      datetime: json['datetime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'datetime': datetime,
    };
  }
}
