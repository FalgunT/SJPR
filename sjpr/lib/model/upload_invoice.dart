class CommonModelClass {
  bool? status;
  String? error;
  String? message;
  String? data;

  CommonModelClass({this.status, this.message, this.error, this.data});

  CommonModelClass.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json.containsKey('data') ? json['data'].toString() : "";
    error = json.containsKey('error') ? json['error'].toString() : "";
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    data['error'] = error;
    return data;
  }
}
