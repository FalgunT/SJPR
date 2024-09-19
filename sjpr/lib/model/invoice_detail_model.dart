class InvoiceDetail {
  bool? status;
  String? error;
  String? message;
  InvoiceDetailData? data;

  InvoiceDetail({this.status, this.message, this.data});

  InvoiceDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'].runtimeType == List<dynamic>) {
      json['data'] = null;
    }
    data = (json['data'] != null)
        ? InvoiceDetailData.fromJson(json['data'])
        : null;
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
  String? isPurchase;
  String? isArchive;
  String? readStatus;
  String? invoiceFileId;
  String? invoiceId;
  String? totalAmount;
  String? netAmount;
  String? invoiceDate;
  String? totalTaxAmount;
  String? dueDate;
  String? taxRateId;
  String? currency;
  String? supplierAddress;
  String? supplierName;
  String? supplierEmail;
  String? supplierPhone;
  String? receiverName;
  String? receiverEmail;
  String? receiverPhone;
  String? receiverAddress;
  String? scannedOwnedById;
  String? cis;
  int? line_item_count;
  String? scanned_category_id;
  String? scanned_product_service_id;
  String? scanned_type_id;
  String? document_reference;
  String? publish_to_id;
  String? payment_method_id;
  String? scanned_currency_id;
  String? payment_status;
  int? split_item_count;

  String? date;

  InvoiceDetailData.empty();

  InvoiceDetailData(
      {this.userId,
      this.scanInvoice,
      this.id,
      this.isPurchase,
      this.isArchive,
      this.readStatus,
      this.invoiceFileId,
      this.invoiceId,
      this.totalAmount,
      this.netAmount,
      this.invoiceDate,
      this.totalTaxAmount,
      this.dueDate,
      this.taxRateId,
      this.supplierAddress,
      this.supplierName,
      this.supplierEmail,
      this.supplierPhone,
      this.receiverName,
      this.receiverEmail,
      this.receiverPhone,
      this.receiverAddress,
      this.scannedOwnedById,
      this.cis,
      this.line_item_count,
      this.date,
      this.scanned_category_id,
      this.scanned_product_service_id,
      this.scanned_type_id,
      this.document_reference,
      this.publish_to_id,
      this.scanned_currency_id,
      this.payment_method_id,
      this.split_item_count,
      this.payment_status});

  InvoiceDetailData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    scanInvoice = json['scan_invoice'];
    id = json['id'];
    isPurchase = json['is_purchase'];
    isArchive = json['is_archive'];
    readStatus = json['read_status'];
    invoiceFileId = json['invoice_file_id'];
    invoiceId = json['invoice_id'];
    totalAmount = json['total_amount'];
    netAmount = json['net_amount'];
    invoiceDate = json['invoice_date'];
    totalTaxAmount = json['total_tax_amount'];
    dueDate = json['due_date'];
    taxRateId = json['tax_rate_id'];
    supplierAddress = json['supplier_address'];
    supplierName = json['supplier_name'];
    supplierEmail = json['supplier_email'];
    supplierPhone = json['supplier_phone'];
    receiverName = json['receiver_name'];
    receiverEmail = json['receiver_email'];
    receiverPhone = json['receiver_phone'];
    receiverAddress = json['receiver_address'];
    scannedOwnedById = json['scannedOwnedById'];
    cis = json['cis'];
    line_item_count = json['line_item_count'];
    date = json['date'];
    scanned_category_id = json['scanned_category_id'];
    scanned_product_service_id = json['scanned_product_service_id'];
    scanned_type_id = json['scanned_type_id'];
    document_reference = json['document_reference'];
    publish_to_id = json['publish_to_id'];
    scanned_currency_id = json['scanned_currency_id'];
    payment_method_id = json['payment_method_id'];
    split_item_count = json['split_item_count'];
    payment_status = json['payment_status'];
  }

  get isObjectEmpty {
    if (this.invoiceFileId == null || this.id == null || scanInvoice == null) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'user_id': userId ?? "",
        'scan_invoice': scanInvoice ?? "",
        'id': id ?? "",
        'is_purchase': isPurchase ?? "",
        'is_archive': isArchive ?? "",
        'read_status': readStatus ?? "",
        'invoice_file_id': invoiceFileId ?? "",
        'invoice_id': invoiceId ?? "",
        'total_amount': totalAmount ?? "",
        'net_amount': netAmount ?? "",
        'invoice_date': invoiceDate ?? "",
        'total_tax_amount': totalTaxAmount ?? "",
        'due_date': dueDate ?? "",
        'tax_rate_id': taxRateId ?? "",
        'supplier_address': supplierAddress ?? "",
        'supplier_name': supplierName ?? "",
        'supplier_email': supplierEmail ?? "",
        'supplier_phone': supplierPhone ?? "",
        'receiver_name': receiverName ?? "",
        'receiver_email': receiverEmail ?? "",
        'receiver_phone': receiverPhone ?? "",
        'receiver_address': receiverAddress ?? "",
        'scanned_owned_by_id': scannedOwnedById ?? "",
        'cis': cis ?? "",
        'line_item_count': line_item_count ?? 0,
        'date': date ?? "",
        'scanned_category_id': scanned_category_id ?? "",
        'scanned_product_service_id': scanned_product_service_id ?? "",
        'scanned_type_id': scanned_type_id ?? "",
        'document_reference': document_reference ?? "",
        'publish_to_id': publish_to_id ?? "",
        'scanned_currency_id': scanned_currency_id ?? "",
        'payment_method_id': payment_method_id ?? "",
        'payment_status': payment_status ?? '',
        'split_item_count': split_item_count ?? 0,
      };
}
