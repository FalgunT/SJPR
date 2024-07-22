class CommonModelClass {
  bool? status;
  String? error;
  String? message;
  String? data;

  CommonModelClass({this.status, this.message, this.data});

  CommonModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
