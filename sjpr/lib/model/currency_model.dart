class CurrencyModel {
  /* "id": "1",
            "currency_name": "EURO",
            "currency_sign": "€",
            "status": "1",
            "datetime": "2024-07-10 04:01:20"*/

  String? id;
  String? currency_name;
  String? currency_sign;
  String? status;
  String? datetime;

  CurrencyModel(
      {required this.id,
      required this.currency_name,
      required this.currency_sign,
      required this.status,
      required this.datetime});

  CurrencyModel.empty();

  @override
  String toString() {
    return 'CurrencyModel{id: $id, currency_name: $currency_name, currency_sign: $currency_sign, status: $status, datetime: $datetime}';
  }

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
        id: json['id'],
        currency_name: json['currency_name'],
        currency_sign: json['currency_sign'],
        status: json['status'],
        datetime: json['datetime']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'currency_name': currency_name,
        'currency_sign': currency_sign,
        'status': status,
        'datetime': datetime,
      };
}
