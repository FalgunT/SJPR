class TypeList {
  bool? status;
  String? error;
  String? message;
  List<TypeListData>? data;

  TypeList({this.status, this.message, this.data});

  TypeList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TypeListData>[];
      json['data'].forEach((v) {
        data!.add(TypeListData.fromJson(v));
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

class TypeListData {
  String? id;
  String? typeName;
  String? typeStatus;
  String? datetime;

  TypeListData({this.id, this.typeName, this.typeStatus, this.datetime});
  TypeListData.empty();
  TypeListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    typeStatus = json['type_status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type_name'] = typeName;
    data['type_status'] = typeStatus;
    data['datetime'] = datetime;
    return data;
  }
}
