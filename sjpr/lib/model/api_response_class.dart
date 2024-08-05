class ApiResponseClassModel {
  final bool status;
  final String message;
  final String error;
  final List<CData> data;

  ApiResponseClassModel({
    required this.status,
    required this.message,
    required this.error,
    required this.data,
  });

  factory ApiResponseClassModel.fromJson(Map<dynamic, dynamic> json) {
    return ApiResponseClassModel(
      status: json['status'],
      message: json['message'],
      error: json.containsKey('error') ? json['error'].toString() : "",
      data: json.containsKey('data')
          ? (json['data'] as List).map((item) => CData.fromJson(item)).toList()
          : [],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'error': error,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class CData {
  final String id;
  final String className;
  final String datetime;

  CData({
    required this.id,
    required this.className,
    required this.datetime,
  });

  factory CData.fromJson(Map<dynamic, dynamic> json) {
    return CData(
      id: json['id'],
      className: json['class_name'],
      datetime: json['datetime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'class_name': className,
      'datetime': datetime,
    };
  }
}
