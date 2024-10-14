class ExcelType {
  bool? status;
  String? message;
  List<ExcelTypeData>? data;

  ExcelType({this.status, this.message, this.data});

  ExcelType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ExcelTypeData>[];
      json['data'].forEach((v) {
        data!.add(ExcelTypeData.fromJson(v));
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

class ExcelTypeData {
  String? id;
  String? name;

  ExcelTypeData({this.id, this.name});

  ExcelTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = this.name;
    return data;
  }
}
