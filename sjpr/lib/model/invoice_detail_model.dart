class InvoiceDetail {
  bool? status;
  String? error;
  String? message;
  InvoiceDetailData? data;

  InvoiceDetail({this.status, this.message, this.data});

  InvoiceDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? InvoiceDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class InvoiceDetailData {
  String? userId;
  String? scanInvoice;
  String? id;
  String? invoiceFileId;
  String? invoiceId;
  String? totalAmount;
  String? netAmount;
  String? invoiceDate;
  String? totalTaxAmount;
  String? dueDate;
  String? supplierTaxId;
  String? currency;
  String? supplierAddress;
  String? supplierName;
  String? supplierEmail;
  String? supplierPhone;
  String? receiverName;
  String? receiverEmail;
  String? receiverPhone;
  String? receiverAddress;
  String? lineItem;
  String? scanned_category_id;
  String? scanned_product_service_id;
  String? scanned_type_id;
  String? scanned_owned_by_id;
  String? document_reference;
  String? publish_to_id;
  String? payment_method_id;
  String? scanned_currency_id;

  String? date;

  InvoiceDetailData(
      {this.userId,
      this.scanInvoice,
      this.id,
      this.invoiceFileId,
      this.invoiceId,
      this.totalAmount,
      this.netAmount,
      this.invoiceDate,
      this.totalTaxAmount,
      this.dueDate,
      this.supplierTaxId,
      this.currency,
      this.supplierAddress,
      this.supplierName,
      this.supplierEmail,
      this.supplierPhone,
      this.receiverName,
      this.receiverEmail,
      this.receiverPhone,
      this.receiverAddress,
      this.lineItem,
      this.date,

      this.scanned_category_id,
      this.scanned_product_service_id,
      this.scanned_type_id,
      this.scanned_owned_by_id,
      this.document_reference,
      this.publish_to_id,
      this.scanned_currency_id,
      this.payment_method_id});

  InvoiceDetailData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    scanInvoice = json['scan_invoice'];
    id = json['id'];
    invoiceFileId = json['invoice_file_id'];
    invoiceId = json['invoice_id'];
    totalAmount = json['total_amount'];
    netAmount = json['net_amount'];
    invoiceDate = json['invoice_date'];
    totalTaxAmount = json['total_tax_amount'];
    dueDate = json['due_date'];
    supplierTaxId = json['supplier_tax_id'];
    currency = json['currency'];
    supplierAddress = json['supplier_address'];
    supplierName = json['supplier_name'];
    supplierEmail = json['supplier_email'];
    supplierPhone = json['supplier_phone'];
    receiverName = json['receiver_name'];
    receiverEmail = json['receiver_email'];
    receiverPhone = json['receiver_phone'];
    receiverAddress = json['receiver_address'];
    lineItem = json['line_item'];
    date = json['date'];

    scanned_category_id=json['scanned_category_id'];
    scanned_product_service_id=json['scanned_product_service_id'];
    scanned_type_id=json['scanned_type_id'];
    scanned_owned_by_id=json['scanned_owned_by_id'];
    document_reference=json['document_reference'];
    publish_to_id=json['publish_to_id'];
    scanned_currency_id=json['scanned_currency_id'];
    payment_method_id=json['payment_method_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['scan_invoice'] = scanInvoice;
    data['id'] = id;
    data['invoice_file_id'] = invoiceFileId;
    data['invoice_id'] = invoiceId;
    data['total_amount'] = totalAmount;
    data['net_amount'] = netAmount;
    data['invoice_date'] = invoiceDate;
    data['total_tax_amount'] = totalTaxAmount;
    data['due_date'] = dueDate;
    data['supplier_tax_id'] = supplierTaxId;
    data['currency'] = currency;
    data['supplier_address'] = supplierAddress;
    data['supplier_name'] = supplierName;
    data['supplier_email'] = supplierEmail;
    data['supplier_phone'] = supplierPhone;
    data['receiver_name'] = receiverName;
    data['receiver_email'] = receiverEmail;
    data['receiver_phone'] = receiverPhone;
    data['receiver_address'] = receiverAddress;
    data['line_item'] = lineItem;
    data['date'] = date;
    data['scanned_category_id']= scanned_category_id;
    data['scanned_product_service_id']=scanned_product_service_id;
    data['scanned_type_id'] = scanned_type_id;
    data['scanned_owned_by_id']=scanned_owned_by_id;
    data['document_reference']=document_reference;
    data['publish_to_id'] =publish_to_id;
    data['scanned_currency_id']= scanned_currency_id;
    data['payment_method_id']=payment_method_id;


    return data;
  }
}
