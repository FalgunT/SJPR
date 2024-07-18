class CommonData {
  String? resultflag;
  String? messages;
  String? data;

  CommonData({this.resultflag, this.messages, this.data});

  CommonData.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resultflag'] = resultflag;
    data['Messages'] = messages;
    data['Data'] = data;
    return data;
  }
}
