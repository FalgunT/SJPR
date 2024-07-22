class PublishToModel {
  String? id;
  String? name;
  String? status;
  String? datetime;

  PublishToModel(
      {required this.id,
      required this.name,
      required this.status,
      required this.datetime});

  PublishToModel.empty();

  factory PublishToModel.fromJson(Map<String, dynamic> json) {
    return PublishToModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        datetime: json['datetime']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'status': status,
        'datetime': datetime,
      };

  @override
  String toString() {
    return 'PublishToModel{id: $id, name: $name, status: $status, datetime: $datetime}';
  }
}
