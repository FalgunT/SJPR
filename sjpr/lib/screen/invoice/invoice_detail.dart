import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sjpr/common/app_theme.dart';
import 'package:sjpr/screen/invoice/invoice_detail_bloc.dart';
import 'package:sjpr/screen/lineitems/line_items_list.dart';
import 'package:sjpr/widgets/amount_widget.dart';
import 'package:sjpr/widgets/common_button.dart';
import 'package:sjpr/widgets/empty_item_widget.dart';
import '../../common/AppEnums.dart';
import '../../utils/color_utils.dart';
import '../../utils/string_utils.dart';
import '../../widgets/AddNewItemDialog.dart';
import '../../widgets/CommonBottomSheetDialog.dart';
import '../splititems/split_items_list.dart';

class InvoiceDetailScreen extends StatefulWidget {
  final String id;
  final String title;
  final int isPurchase;
  final bool isReadOnly;

  const InvoiceDetailScreen(
      {super.key,
      required this.id,
      required this.isPurchase,
      required this.title,
      required this.isReadOnly});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  late InvoiceDetailBloc bloc;
  final TextEditingController _eDescController = TextEditingController();
  late var appTheme;

  @override
  void initState() {
    bloc = InvoiceDetailBloc();
    _init();
    super.initState();
  }

  _init() async {
    await bloc.getInvoiceDetail(context, widget.id);
    bloc.getAllTaxRate(context);
    bloc.getProfile(context);
    bloc.getDetailCategory(context);
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
    appTheme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: appTheme.backGroundColor,
      appBar: AppBar(
        backgroundColor: appTheme.backGroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: appTheme.textColor,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
            valueListenable: bloc.isWaitingForDetail,
            builder: (context, value1, child) {
              return ValueListenableBuilder(
                valueListenable: bloc.invoiceDetailData,
                builder: (BuildContext context, value, Widget? child) {
                  print(value.isObjectEmpty);
                  return value.isObjectEmpty
                      ? value1 == false
                          ? EmptyItemWidget(
                              title: StringUtils.noinvoice, detail: "")
                          : Container()
                      : Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Details",
                                    style: TextStyle(
                                        color: appTheme.activeTxtColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  widget.isReadOnly
                                      ? Center()
                                      : InkWell(
                                          onTap: () async {
                                            //set flag cancel ...
                                            //and update the invoice..
                                            bool res =
                                                await bloc.CancelInvoice();
                                            if (res) {
                                              Navigator.pop(context, res);
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            height: 40,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: backGroundColor,
                                                border: Border.all(
                                                    color: redColor, width: 2)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.clear,
                                                  color: redColor,
                                                  size: 16,
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: redColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    bloc.invoiceDetailData.value.supplierName ??
                                        "",
                                    style: TextStyle(
                                        color: appTheme.textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  getTotalWidget()
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    bloc.invoiceDetailData.value.date ?? "",
                                    //"22th feb,2024",
                                    style: TextStyle(
                                      color: appTheme.textColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Text(
                                    "" /*+ bloc.invoiceDetailData.value.read_*/,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: /*extension == "pdf"
                                ? SizedBox(
                              height: 500,
                              width: MediaQuery.sizeOf(context).width,
                              child: PdfViewer.openFutureFile(
                                    () async => (await DefaultCacheManager()
                                    .getSingleFile(invoiceDetail.scanInvoice ?? "")).path,
                                params: const PdfViewerParams(padding: 0),
                              ),
                            ) :*/
                                        Image.network(
                                      bloc.invoiceDetailData.value
                                              .scanInvoice ??
                                          "",
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              spacer(),
                              getLines(),
                              spacer(),
                              getSplits(),
                              spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Details Info",
                                  style: TextStyle(
                                      color: appTheme.activeTxtColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              getCatWidget(),
                              getProdWidget(),
                              ValueListenableBuilder(
                                valueListenable: bloc.selectedValueT,
                                builder: (context, value, child) {
                                  return commonRowWidget(context,
                                      title: "Type",
                                      isClickable: !widget.isReadOnly,
                                      value: bloc.selectedValueT.value,
                                      onTap: () {
                                    CommonBottomSheetDialog(
                                        context: context,
                                        list: bloc.tList,
                                        title: "Type",
                                        ItemId: bloc.getId(SheetType.type),
                                        bottomSheetType: SheetType.type,
                                        Addf: (String item, String id) {},
                                        onItemAdded: (String item, String id) {
                                          bloc.addSubcategory(
                                              context, id, item);
                                        },
                                        onItemSelected: (id, name) {
                                          debugPrint('--->$id, $name');
                                          bloc.SetName(
                                              id, name, SheetType.type);
                                          //
                                        }).Show();
                                  });
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: bloc.ownedBy,
                                builder: (context, value, child) {
                                  return commonRowWidget(context,
                                      isClickable: false,
                                      title: "Owned by",
                                      value: value,
                                      onTap: () {});
                                },
                              ),
                              commonRowWidget(context,
                                  title: "Date",
                                  isClickable: !widget.isReadOnly,
                                  value: bloc.invoiceDetailData.value
                                      .invoiceDate, onTap: () {
                                _selectDate(context, 4);
                              }),
                              spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Document reference",
                                  style: TextStyle(
                                      color: appTheme.activeTxtColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextField(
                                minLines: 4,
                                enabled: !widget.isReadOnly,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: appTheme.listTileBgColor,
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  hintText: 'Description',
                                  labelText: 'Add Description',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                ),
                                controller: _eDescController,
                              ),
                              spacer(),
                              commonRowWidget(context,
                                  title: "Due Date",
                                  isClickable: !widget.isReadOnly,
                                  value: bloc.invoiceDetailData.value.dueDate,
                                  onTap: () {
                                _selectDate(context, 5);
                              }),
                              commonRowWidget(context,
                                  title: "Invoice Number",
                                  isClickable: !widget.isReadOnly,
                                  value: bloc.invoiceDetailData.value.invoiceId,
                                  onTap: () {
                                AddNewItemDialog(
                                    isAmt: false,
                                    context: context,
                                    title: "Edit Invoice Number",
                                    hint: 'Enter Invoice Number',
                                    label: 'Invoice Number',
                                    oldValue: bloc.invoiceDetailData.value
                                            .invoiceId ??
                                        "",
                                    type: SheetType.none,
                                    onPressed: (String v) {
                                      debugPrint('F() called--->, $v');
                                      bloc.invoiceDetailData.value.invoiceId =
                                          v;
                                      setState(() {});
                                    });
                              }),
                              ValueListenableBuilder(
                                valueListenable: bloc.selectedValuePM,
                                builder: (context, value, child) {
                                  return commonRowWidget(context,
                                      title: "Payment method",
                                      isClickable: !widget.isReadOnly,
                                      value: value, onTap: () {
                                    CommonBottomSheetDialog(
                                        context: context,
                                        list: bloc.pmList,
                                        title: "Payment method",
                                        ItemId: bloc
                                            .getId(SheetType.paymentmethods),
                                        bottomSheetType:
                                            SheetType.paymentmethods,
                                        Addf: (String v) {},
                                        onItemSelected: (id, name) {
                                          debugPrint(
                                              'onItemSelected---> $id, $name');
                                          bloc.SetName(id, name,
                                              SheetType.paymentmethods);
                                        }).Show();
                                  });
                                },
                              ),
                              ValueListenableBuilder(
                                valueListenable: bloc.selectedValuePT,
                                builder: (context, value, child) {
                                  return commonRowWidget(context,
                                      title: "Publish to",
                                      isClickable: !widget.isReadOnly,
                                      value: value, onTap: () {
                                    CommonBottomSheetDialog(
                                        context: context,
                                        list: bloc.publishToList,
                                        title: "Publish to",
                                        ItemId: bloc.getId(SheetType.publishto),
                                        bottomSheetType: SheetType.publishto,
                                        Addf: (String v) {},
                                        onItemSelected: (id, name) {
                                          debugPrint(
                                              'onItemSelected---> $id, $name');
                                          bloc.SetName(
                                              id, name, SheetType.publishto);
                                        }).Show();
                                  });
                                },
                              ),
                              AbsorbPointer(
                                absorbing: widget.isReadOnly,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: appTheme.listTileBgColor,
                                  ),
                                  child: ValueListenableBuilder(
                                    valueListenable: bloc.switchVal,
                                    builder: (context, value, child) {
                                      return Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            value ? "Paid" : "Unpaid",
                                            style: TextStyle(
                                                color: appTheme.textColor,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          CupertinoSwitch(
                                            value: value,
                                            onChanged: (bb) {
                                              bloc.switchVal.value = bb;
                                              bloc.invoiceDetailData.value
                                                      .payment_status =
                                                  bb ? '1' : '0';
                                            },
                                            activeColor:
                                                appTheme.activeTxtColor,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: bloc.selectedValueCur,
                                builder: (context, value, child) {
                                  return commonRowWidget(context,
                                      title: "Currency",
                                      isClickable: !widget.isReadOnly,
                                      value: bloc.selectedValueCur.value,
                                      onTap: () {
                                    CommonBottomSheetDialog(
                                        context: context,
                                        list: bloc.curList,
                                        title: "Currency",
                                        ItemId: bloc.getId(SheetType.currency),
                                        bottomSheetType: SheetType.currency,
                                        Addf: (String v) {},
                                        onItemSelected: (id, name) {
                                          debugPrint(
                                              'onItemSelected---> $id, $name');
                                          bloc.SetName(
                                              id, name, SheetType.currency);
                                        }).Show();
                                  });
                                },
                              ),
                              AmountWidget(
                                  bloc: bloc, isReadOnly: widget.isReadOnly),
                              spacer(),
                              widget.isReadOnly
                                  ? Center()
                                  : CommonButton(
                                      content: "Submit",
                                      bgColor: appTheme.buttonBgColor,
                                      textColor: appTheme.buttonTextColor,
                                      outlinedBorderColor:
                                          appTheme.buttonBgColor,
                                      onPressed: () async {
                                        if (bloc.isValid(context)) {
                                          //collect all data...
                                          bloc.invoiceDetailData.value
                                                  .document_reference =
                                              _eDescController.text;
                                          bool res =
                                              await bloc.updateScannedInvoice(
                                                  bloc.invoiceDetailData.value
                                                      .toJson(),
                                                  context);
                                          if (res) {
                                            Navigator.pop(context, res);
                                          }
                                        }
                                      })
                            ],
                          ),
                        );
                },
              );
            }),
      ),
    );
  }

  getTotalWidget() {
    return ValueListenableBuilder(
        valueListenable: bloc.selectedValueCurSign,
        builder: (context, value1, child) {
          return Text(
              '$value1 ${bloc.getFormetted(bloc.invoiceDetailData.value.totalAmount ?? "")}',
              style: TextStyle(
                  color: appTheme.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold));
        });
  }

  getLines() {
    return widget.isReadOnly &&
            bloc.invoiceDetailData.value.line_item_count == 0
        ? Center()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Line Items",
                  style: TextStyle(
                      color: appTheme.activeTxtColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LineItemsListScreen(
                                currencySign: bloc.selectedValueCurSign.value,
                                id: bloc.invoiceDetailData.value.id ?? "",
                                isPurchase: widget.isPurchase,
                                isReadOnly: widget.isReadOnly,
                              ))).then((_) async {
                    //bloc.getInvoiceDetail(context, widget.id);
                    await bloc.getLineItemList(
                        context, bloc.invoiceDetailData.value.id!);
                    setState(() {});
                  });
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text("Consult line items",
                                        style: TextStyle(
                                            color: appTheme.textColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Text(
                                      '${bloc.invoiceDetailData.value.line_item_count}',
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
                                          color: appTheme.textColor,
                                          fontSize: 16,
                                        )),
                                  ),
                                  getTotalWidget()
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
            ],
          );
  }

  getSplits() {
    return widget.isReadOnly &&
            bloc.invoiceDetailData.value.split_item_count == 0
        ? Center()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Split Items",
                  style: TextStyle(
                      color: appTheme.activeTxtColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SplitItemsListScreen(
                                currencySign: bloc.selectedValueCurSign.value,
                                totalAmount:
                                    bloc.invoiceDetailData.value.netAmount,
//bloc.invoiceDetailData.value.totalAmount
                                totalTaxAmount:
                                    bloc.invoiceDetailData.value.totalTaxAmount,
//bloc.invoiceDetailData.value.totalTaxAmount,
                                id: bloc.invoiceDetailData.value.id ?? "",
                                isReadOnly: false,
                              ))).then((onValue) async {
                    if (onValue == true) {
                      // bloc.getInvoiceDetail(context, widget.id);
                      await bloc.getSplitItemList(
                          context, bloc.invoiceDetailData.value.id!);
                      setState(() {});
                    }
                  });
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text("Consult Split items",
                                        style: TextStyle(
                                            color: appTheme.textColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Text(
                                      '${bloc.invoiceDetailData.value.split_item_count}',
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
                                          color: appTheme.textColor,
                                          fontSize: 16,
                                        )),
                                  ),
                                  getTotalWidget()
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
            ],
          );
  }

  Widget commonRowWidget(BuildContext context,
      {required title,
      required value,
      required Function onTap,
      isNumber = false,
      isClickable = true}) {
    final appTheme = AppTheme.of(context);
    return InkWell(
      onTap: () {
        if (!isClickable) return;
        onTap();
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
            isNumber
                ? ValueListenableBuilder(
                    valueListenable: bloc.selectedValueCurSign,
                    builder: (context, value1, child) {
                      return Expanded(
                        child: Text(
                          '$value1 $value',
                          style: TextStyle(
                              color: appTheme.textColor, fontSize: 14),
                          textAlign: TextAlign.end,
                        ),
                      );
                    },
                  )
                : Expanded(
                    child: Text(
                      value ?? "None",
                      style: TextStyle(color: appTheme.textColor, fontSize: 14),
                      textAlign: TextAlign.end,
                    ),
                  ),
            const SizedBox(
              width: 5,
            ),
            (isClickable)
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

  String? selectedDate;

  Future<void> _selectDate(BuildContext context, int flag) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        // initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && selectedDate != picked) {
      setState(() {
        String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
        selectedDate = formattedDate;
        if (flag == 4) {
          bloc.invoiceDetailData.value.invoiceDate = selectedDate;
        } else {
          bloc.invoiceDetailData.value.dueDate = selectedDate;
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

  spacer() {
    return const SizedBox(
      height: 10,
    );
  }

  getCatWidget() {
    return ValueListenableBuilder(
      valueListenable: bloc.hideCat,
      builder: (context, value, child) {
        return value
            ? const Center()
            : ValueListenableBuilder(
                valueListenable: bloc.selectedValueC,
                builder: (context, value, child) {
                  return commonRowWidget(context,
                      title: "Category",
                      isClickable: !widget.isReadOnly,
                      value: bloc.selectedValueC.value, onTap: () {
                    CommonBottomSheetDialog(
                        context: context,
                        list: bloc.cList,
                        title: "Category",
                        ItemId: bloc.getId(SheetType.category),
                        bottomSheetType: SheetType.category,
                        Addf: (String v) {},
                        onItemSelected: (id, name) {
                          bloc.SetName(id, name, SheetType.category);
                        }).Show();
                  });
                },
              );
      },
    );
  }

  getProdWidget() {
    return ValueListenableBuilder(
      valueListenable: bloc.hideProd,
      builder: (context, value, child) {
        return value
            ? const Center()
            : ValueListenableBuilder(
                valueListenable: bloc.selectedValueP,
                builder: (context, value, child) {
                  return commonRowWidget(context,
                      isClickable: !widget.isReadOnly,
                      title: "Product/Service",
                      value: bloc.selectedValueP.value, onTap: () {
                    CommonBottomSheetDialog(
                        context: context,
                        list: bloc.pList,
                        title: "Product/Service",
                        ItemId: bloc.getId(SheetType.product),
                        bottomSheetType: SheetType.product,
                        Addf: (String v) {
                          bloc.addProductService(context, v);
                        },
                        onItemSelected: (id, name) {
                          bloc.SetName(id, name, SheetType.product);
                        }).Show();
                  });
                });
      },
    );
  }
}
