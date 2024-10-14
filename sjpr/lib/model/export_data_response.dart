class ExportData {
  bool? status;
  String? message;
  ExportDataData? data;

  ExportData({this.status, this.message, this.data});

  ExportData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ExportDataData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ExportDataData {
  int? excelTemplateSaveId;
  String? fileUrl;
  String? fileName;

  ExportDataData({this.excelTemplateSaveId, this.fileUrl, this.fileName});

  ExportDataData.fromJson(Map<String, dynamic> json) {
    excelTemplateSaveId = json['excel_template_save_id'];
    fileUrl = json['file_url'];
    fileName = json['file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['excel_template_save_id'] = this.excelTemplateSaveId;
    data['file_url'] = this.fileUrl;
    data['file_name'] = this.fileName;
    return data;
  }
}
