import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:sjpr/common/app_theme.dart';
import 'package:sjpr/model/invoice_detail_model.dart';
import 'package:sjpr/screen/invoice/invoice_detail_bloc.dart';
import 'package:sjpr/screen/lineitems/line_items_list.dart';
import 'package:sjpr/widgets/check_box.dart';
import 'package:sjpr/widgets/common_button.dart';
import '../../common/common_toast.dart';
import '../../utils/color_utils.dart';
import '../../widgets/radio_button.dart';

class InvoiceDetailScreen extends StatefulWidget {
  final String id;

  const InvoiceDetailScreen({super.key, required this.id});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen>
    implements Updater {
  late InvoiceDetailBloc bloc;
  late InvoiceDetailData invoiceDetail;

  @override
  void initState() {
    bloc = InvoiceDetailBloc(update: this);
    _init();
    super.initState();
  }

  _init() async {
    await bloc.getInvoiceDetail(context, widget.id);
    bloc.getDetailCategory(context, widget.id);
    bloc.getDetailType(context, widget.id);
    bloc.getCurrency(context);
    bloc.getPaymentMethods(context);
    bloc.getPublishTo(context);
    //  await bloc.getDetailOwnBy(context, widget.id);
    bloc.getProductService(context);
    //bloc.getLineItemList(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: appTheme.backGroundColor,
      appBar: AppBar(
        backgroundColor: appTheme.backGroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: appTheme.textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<InvoiceDetailData?>(
            stream: bloc.invoiceDetailStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                invoiceDetail = snapshot.data!;
                _eDescController.text = invoiceDetail.document_reference ?? "";
                String path = invoiceDetail.scanInvoice ?? "";
                String extension = path.split(".").last;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Details",
                      style: TextStyle(
                          color: appTheme.activeTxtColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          invoiceDetail.supplierName ?? "",
                          style: TextStyle(
                              color: appTheme.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ('${bloc.selectedCurrency.currency_sign ?? ""} ${invoiceDetail.netAmount ?? ""}'),
                          style: TextStyle(
                              color: appTheme.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          invoiceDetail.date ?? "",
                          //"22th feb,2024",
                          style: TextStyle(
                            color: appTheme.textColor,
                            fontSize: 18,
                          ),
                        ),
                        const Text(
                          "To review",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: extension == "pdf"
                              ? SizedBox(
                                  height: 500,
                                  width: MediaQuery.sizeOf(context).width,
                                  child: PdfViewer.openFutureFile(
                                    () async => (await DefaultCacheManager()
                                            .getSingleFile(
                                                invoiceDetail.scanInvoice ??
                                                    ""))
                                        .path,
                                    params: const PdfViewerParams(padding: 0),
                                  ),
                                )
                              : Image.network(
                                  invoiceDetail.scanInvoice ?? "",
                                  fit: BoxFit.fill,
                                )),
                    ),
                    Text(
                      "Details Info",
                      style: TextStyle(
                          color: appTheme.activeTxtColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    commonRowWidget(context,
                        title: "Category",
                        value: bloc.selectedData.sub_category_name ?? "None",
                        flag: 0),
                    commonRowWidget(context,
                        title: "Product/Service",
                        value: bloc.selectedPData.productServicesName ?? "None",
                        flag: 1,
                        isAdd: true),
                    commonRowWidget(context,
                        title: "Type",
                        value: bloc.selectedTData.typeName ?? "None",
                        flag: 2),
                    commonRowWidget(context,
                        title: "Owned by",
                        value: invoiceDetail.supplierName ?? '-',
                        flag: 3),
                    commonRowWidget(context,
                        title: "Date",
                        value: invoiceDetail.invoiceDate,
                        flag: 4),
                    const SizedBox(
                      height: 10,
                    ),
                    /*   Divider(
                      color: appTheme.listTileBgColor,
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),*/
                    Text(
                      "Document reference",
                      style: TextStyle(
                          color: appTheme.activeTxtColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    commonRowWidget(context,
                        title: "Due Date",
                        value: invoiceDetail.dueDate,
                        flag: 5),
                    /*commonRowWidget(context,
                        title: "Supplier", value: "None", flag: 0),*/
                    commonRowWidget(context,
                        title: "Currency",
                        value: bloc.selectedCurrency.currency_name ?? 'None',
                        flag: 6),
                    commonRowWidget(context,
                        title: "Total",
                        value:
                            '${bloc.selectedCurrency.currency_sign ?? ""} ${invoiceDetail.totalAmount ?? 0.00}',
                        flag: 9),
                    commonRowWidget(context,
                        title: "Tax",
                        value:
                            '${bloc.selectedCurrency.currency_sign ?? ""} ${invoiceDetail.totalTaxAmount ?? 0.00}',
                        flag: 10),
                    commonRowWidget(context,
                        title: "Tax total",
                        value:
                            '${bloc.selectedCurrency.currency_sign ?? ""} ${invoiceDetail.netAmount ?? 0.00}',
                        flag: 11),
                    /*Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: appTheme.listTileBgColor,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Paid",
                            style: TextStyle(
                                color: appTheme.textColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )),
                          CupertinoSwitch(
                            value: true,
                            onChanged: (value) {},
                            activeColor: appTheme.activeTxtColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: appTheme.textColor,
                          )
                        ],
                      ),
                    ),*/
                    commonRowWidget(context,
                        title: "Payment method",
                        value: bloc.selectedPM.method_name ?? 'None',
                        flag: 7),
                    commonRowWidget(context,
                        title: "Publish to",
                        value: bloc.selectedPublishTo.name ?? "None",
                        flag: 8),
                    const SizedBox(
                      height: 10,
                    ),
                    /*Container(
                      height: 150,
                      padding: const EdgeInsets.all(4),
                     // width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromRGBO(39, 40, 44, 2)),
                      child: ,
                    ),*/
                    TextField(
                      minLines: 4,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: appTheme.listTileBgColor,
                        hintStyle: const TextStyle(color: Colors.white),
                        hintText: 'Description',
                        labelText: 'Add Description',
                        labelStyle: const TextStyle(color: Colors.white),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        /*focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),*/
                      ),
                      controller: _eDescController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    invoiceDetail.line_item_count! > 0
                        ? ExpansionTile(
                            iconColor: appTheme.activeTxtColor,
                            collapsedIconColor: appTheme.activeTxtColor,
                            title: Text(
                              "Line Items",
                              style: TextStyle(
                                  color: appTheme.activeTxtColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LineItemsListScreen(
                                                id: invoiceDetail.id ?? "",
                                              )));
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(16),
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color.fromRGBO(
                                            39, 40, 44, 2)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        "Consult line items",
                                                        style: TextStyle(
                                                            color: appTheme
                                                                .textColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  Text(
                                                      '${invoiceDetail.line_item_count}',
                                                      style: const TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 16,
                                                      ))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text("Total",
                                                        style: TextStyle(
                                                          color: appTheme
                                                              .textColor,
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                  Text(
                                                      "${bloc.selectedCurrency.currency_sign ?? ""} ${invoiceDetail.totalAmount}",
                                                      style: TextStyle(
                                                          color: appTheme
                                                              .textColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: appTheme.textColor,
                                        )
                                      ],
                                    )),
                              ),
                              /* const SizedBox(
                                height: 20,
                              ),
                              CommonButton(
                                  content: "Create line items",
                                  bgColor: appTheme.backGroundColor,
                                  textColor: appTheme.activeTxtColor,
                                  outlinedBorderColor: appTheme.buttonBgColor,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LineItems(
                                                  id: widget.id,
                                                )));
                                  }),*/
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          )
                        : const Center(),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                        content: "Submit",
                        bgColor: appTheme.buttonBgColor,
                        textColor: appTheme.buttonTextColor,
                        outlinedBorderColor: appTheme.buttonBgColor,
                        onPressed: () async {
                          if (isValid()) {
                            //collect all data...
                            invoiceDetail.payment_method_id =
                                bloc.selectedPM.id;
                            invoiceDetail.publish_to_id =
                                bloc.selectedPublishTo.id;
                            invoiceDetail.scanned_currency_id =
                                bloc.selectedCurrency.id;

                            invoiceDetail.scanned_category_id =
                                bloc.selectedData.sub_category_id;
                            invoiceDetail.scanned_product_service_id =
                                bloc.selectedPData.id;
                            invoiceDetail.scanned_type_id =
                                bloc.selectedTData.id;
                            bool res = await bloc.updateScannedInvoice(
                                invoiceDetail.toJson(), context);
                            if (res) {
                              Navigator.pop(context);
                            }
                          }
                        })
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget commonRowWidget(BuildContext context,
      {required title, required value, required int flag, isAdd = false}) {
    final appTheme = AppTheme.of(context);
    return InkWell(
      onTap: () {
        if (flag == 4 || flag == 5) {
          _selectDate(context, flag);
          return;
        }
        if (flag == 9 || flag == 10 || flag == 11) {
          //total, tax, taxtotal edit option
          String title = flag == 9
              ? 'Edit Total Amount'
              : flag == 10
                  ? 'Edit Tax Amount'
                  : 'Edit Tax Total';
          String label = flag == 9
              ? 'Edit Total Amount'
              : flag == 10
                  ? 'Edit Tax Amount'
                  : 'Edit Tax Total';
          String hint = label;
          _showAddProductDialog(title, hint, label, isAmt: true, flag: flag);
          return;
        }

        if (flag != 3) _showPicker(context, flag, title, isAdd: isAdd);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: appTheme.listTileBgColor,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: appTheme.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                value ?? "None",
                style: TextStyle(color: appTheme.textColor, fontSize: 14),
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            (flag != 3)
                ? Icon(
                    Icons.arrow_forward_ios,
                    color: appTheme.textColor,
                  )
                : const Center()
          ],
        ),
      ),
    );
  }

  Future<void> _showPicker(BuildContext context, int flag, String title,
      {isAdd = false}) async {
    var _list = await bloc.getCheckBoxList(flag);
    debugPrint('CheckBoxList:--->$_list');
    showModalBottomSheet(
        backgroundColor: textFieldBgColor,
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  trailing: isAdd
                      ? Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                _showAddProductDialog("Add Product/Service",
                                    'Enter product name', 'Product Name');
                              },
                              label: const Text(
                                "Add",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            getCloseButton()
                          ],
                        )
                      : getCloseButton(),
                  title: Text(
                    title,
                    style: TextStyle(color: textColor, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                flag == 0
                    ? CheckBoxList(
                        selectedCategoryIndex: bloc.selectedCategoryIndex,
                        items: _list,
                        f: (index, l) {
                          debugPrint('--->f() called');
                          bloc.selectedCategoryIndex = index;
                          bloc.selectedData = l;
                          debugPrint(
                              '--->Result: ${bloc.selectedData.toString()}');
                        },
                      )
                    : RadioButtonList(
                        items: _list,
                        f: (selected) {
                          CheckBoxItem item = selected;
                          if (flag == 1) {
                            for (var value in bloc.pList) {
                              if (value.id == item.itemId) {
                                bloc.selectedPData = value;
                                debugPrint(
                                    '--->Result: ${bloc.selectedPData.toString()}');
                                break;
                              }
                            }
                          } else if (flag == 2) {
                            for (var value in bloc.tList) {
                              if (value.id == item.itemId) {
                                bloc.selectedTData = value;
                                debugPrint(
                                    '--->Result: ${bloc.selectedTData.toString()}');
                                break;
                              }
                            }
                          } else if (flag == 6) {
                            for (var value in bloc.curList) {
                              if (value.id == item.itemId) {
                                bloc.selectedCurrency = value;
                                debugPrint(
                                    '--->Result: ${bloc.selectedCurrency.toString()}');
                                break;
                              }
                            }
                          } else if (flag == 7) {
                            for (var value in bloc.pmList) {
                              if (value.id == item.itemId) {
                                bloc.selectedPM = value;
                                debugPrint(
                                    '--->Result: ${bloc.selectedPM.toString()}');
                                break;
                              }
                            }
                          } else if (flag == 8) {
                            for (var value in bloc.publishToList) {
                              if (value.id == item.itemId) {
                                bloc.selectedPublishTo = value;
                                debugPrint(
                                    '--->Result: ${bloc.selectedPublishTo.toString()}');
                                break;
                              }
                            }
                          }
                        },
                      ),
              ],
            ),
          );
        });
  }

  String? selectedDate;

  Future<void> _selectDate(BuildContext context, int flag) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        // initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
        selectedDate = formattedDate;
        if (flag == 4) {
          invoiceDetail.invoiceDate = selectedDate;
        } else {
          invoiceDetail.dueDate = selectedDate;
        }
      });
    }
  }

  getCloseButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        setState(() {});
      },
      child: const Icon(
        Icons.clear,
        color: Colors.white,
      ),
    );
  }

  TextEditingController _eController = TextEditingController();
  TextEditingController _eDescController = TextEditingController();

  void _showAddProductDialog(String title, String hint, String label,
      {bool isAmt = false, int flag = -1}) {
    _eController.text = "";
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctxt) => AlertDialog(
              backgroundColor: listTileBgColor,
              insetPadding: const EdgeInsets.all(4),
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return SizedBox(
                    width: width - 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          autofocus: true,
                          keyboardType: isAmt
                              ? const TextInputType.numberWithOptions(
                                  decimal: true, signed: false)
                              : TextInputType.text,
                          /*  inputFormatters: <TextInputFormatter>[
                            isAmt
                                ? FilteringTextInputFormatter.digitsOnly
                                : FilteringTextInputFormatter
                                    .singleLineFormatter
                          ],*/
                          decoration: InputDecoration(
                            filled: false,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: profileListBgColor, width: 1.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                            ),
                            hintText: hint,
                            hintStyle: const TextStyle(color: Colors.white70),
                            labelText: label,
                            labelStyle: const TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          controller: _eController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (_eController.text.isEmpty) {
                                  CommonToast.getInstance()?.displayToast(
                                      message: "Please enter $label",
                                      bContext: context);
                                  return;
                                }
                                if (isAmt) {
                                  if (flag == 9) {
                                    invoiceDetail.totalAmount =
                                        _eController.text;
                                  } else if (flag == 10) {
                                    invoiceDetail.totalTaxAmount =
                                        _eController.text;
                                  } else if (flag == 11) {
                                    invoiceDetail.netAmount = _eController.text;
                                  }
                                  Navigator.pop(context);
                                  setState(() {});
                                  return;
                                }
                                bloc.addProductService(
                                    context, _eController.text);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ));
  }

  @override
  updateWidget() {
    setState(() {});
  }

  bool isValid() {
    String catid = bloc.selectedData.sub_category_id ?? "";
    if (catid == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Category field is required", bContext: context);
      return false;
    }
    String pid = bloc.selectedPData.id ?? "";
    if (pid == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Product/Service field is required", bContext: context);
      return false;
    }
    String tid = bloc.selectedTData.id ?? "";
    if (tid == "") {
      CommonToast.getInstance()
          ?.displayToast(message: "Type field is required", bContext: context);
      return false;
    }
    String duedate = invoiceDetail.dueDate ?? "";
    if (duedate == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Due Date field is required", bContext: context);
      return false;
    }
    String curid = bloc.selectedCurrency.id ?? "";
    if (curid == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Currency field is required", bContext: context);
      return false;
    }
    String total = invoiceDetail.totalAmount ?? "";
    if (total.isEmpty) {
      CommonToast.getInstance()?.displayToast(
          message: "Total  field is required", bContext: context);
      return false;
    }
    String tax = invoiceDetail.totalTaxAmount ?? "";
    if (tax.isEmpty) {
      CommonToast.getInstance()
          ?.displayToast(message: "Tax  field is required", bContext: context);
      return false;
    }
    String net = invoiceDetail.netAmount ?? "";
    if (net.isEmpty) {
      CommonToast.getInstance()?.displayToast(
          message: "Tax Total field is required", bContext: context);
      return false;
    }
    String pmid = bloc.selectedPM.id ?? "";
    if (pmid == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Payment method field is required", bContext: context);
      return false;
    }
    String pubid = bloc.selectedPublishTo.id ?? "";
    if (pubid == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Publish To field is required", bContext: context);
      return false;
    }
    return true;
  }
}
