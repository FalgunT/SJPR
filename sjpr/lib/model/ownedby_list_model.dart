class OwnedByList {
  bool? status;
  String? error;
  String? message;
  List<OwnedByListData>? data;

  OwnedByList({this.status, this.message, this.data});

  OwnedByList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OwnedByListData>[];
      json['data'].forEach((v) {
        data!.add(OwnedByListData.fromJson(v));
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

class OwnedByListData {
  String? id;
  String? ownedByName;
  String? ownedByStatus;
  String? datetime;

  OwnedByListData(
      {this.id, this.ownedByName, this.ownedByStatus, this.datetime});

  OwnedByListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownedByName = json['owned_by_name'];
    ownedByStatus = json['owned_by_status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['owned_by_name'] = ownedByName;
    data['owned_by_status'] = ownedByStatus;
    data['datetime'] = datetime;
    return data;
  }
}
