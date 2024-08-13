import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:sjpr/common/app_theme.dart';
import 'package:sjpr/model/invoice_detail_model.dart';
import 'package:sjpr/screen/invoice/invoice_detail_bloc.dart';
import 'package:sjpr/screen/lineitems/line_items_list.dart';
import 'package:sjpr/screen/splititems/split_items_list.dart';
import 'package:sjpr/widgets/check_box.dart';
import 'package:sjpr/widgets/common_button.dart';
import '../../common/AppEnums.dart';
import '../../common/common_toast.dart';
import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/textinput_utils.dart';
import '../../widgets/AddNewItemDialog.dart';
import '../../widgets/CommonBottomSheetDialog.dart';
import '../../widgets/radio_button.dart';
import '../lineitems/line_items_detail.dart';

class InvoiceDetailScreen extends StatefulWidget {
  final String id;

  const InvoiceDetailScreen({super.key, required this.id});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  late InvoiceDetailBloc bloc;
  TextEditingController _eDescController = TextEditingController();
  late var appTheme;

  @override
  void initState() {
    bloc = InvoiceDetailBloc();
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
    appTheme = AppTheme.of(context);
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
        child: ValueListenableBuilder(
          valueListenable: bloc.invoiceDetailData,
          builder: (BuildContext context, value, Widget? child) {
            return value.isObjectEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          SvgImages.folder,
                        ),
                        spacer(),
                        const Text(
                          StringUtils.noinvoice,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Details",
                              style: TextStyle(
                                  color: appTheme.activeTxtColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                //set flag cancel ...
                                //and update the invoice..
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: backGroundColor,
                                    border:
                                        Border.all(color: redColor, width: 2)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.clear,
                                      color: redColor,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: redColor,
                                          fontWeight: FontWeight.bold,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              bloc.invoiceDetailData.value.supplierName ?? "",
                              style: TextStyle(
                                  color: appTheme.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ('${bloc.selectedValueCurSign.value} ${bloc.invoiceDetailData.value.netAmount ?? ""}'),
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
                              bloc.invoiceDetailData.value.date ?? "",
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
                                bloc.invoiceDetailData.value.scanInvoice ?? "",
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
                                value: bloc.selectedValueT.value, onTap: () {
                              CommonBottomSheetDialog(
                                  context: context,
                                  list: bloc.tList,
                                  title: "Type",
                                  ItemId: bloc.getId(SheetType.type),
                                  bottomSheetType: SheetType.type,
                                  Addf: (String v) {},
                                  onItemSelected: (id, name) {
                                    bloc.SetName(id, name, SheetType.type);
                                  }).Show();
                            });
                          },
                        ),
                        commonRowWidget(context,
                            title: "Owned by",
                            value: bloc.invoiceDetailData.value.supplierName ??
                                '-',
                            onTap: () {}),
                        commonRowWidget(context,
                            title: "Date",
                            value: bloc.invoiceDetailData.value.invoiceDate,
                            onTap: () {
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
                        commonRowWidget(context,
                            title: "Due Date",
                            value: bloc.invoiceDetailData.value.dueDate,
                            onTap: () {
                          _selectDate(context, 5);
                        }),
                        ValueListenableBuilder(
                          valueListenable: bloc.selectedValueCur,
                          builder: (context, value, child) {
                            return commonRowWidget(context,
                                title: "Currency",
                                value: bloc.selectedValueCur.value, onTap: () {
                              CommonBottomSheetDialog(
                                  context: context,
                                  list: bloc.curList,
                                  title: "Currency",
                                  ItemId: bloc.getId(SheetType.currency),
                                  bottomSheetType: SheetType.currency,
                                  Addf: (String v) {},
                                  onItemSelected: (id, name) {
                                    debugPrint('onItemSelected---> $id, $name');
                                    bloc.SetName(id, name, SheetType.currency);
                                  }).Show();
                            });
                          },
                        ),
                        commonRowWidget(context,
                            title: "Total",
                            value:
                                '${bloc.invoiceDetailData.value.totalAmount ?? 0.00}',
                            isNumber: true, onTap: () {
                          AddNewItemDialog(
                              isAmt: true,
                              context: context,
                              title: "Edit Total Amount",
                              hint: 'Enter Total Amount',
                              label: 'Total Amount${bloc.getCurrencySign()}',
                              oldValue: bloc.getFormetted(
                                  bloc.invoiceDetailData.value.totalAmount ??
                                      "0.00"),
                              type: SheetType.none,
                              onPressed: (String v) {
                                debugPrint('F() called--->, $v');
                                bloc.invoiceDetailData.value.totalAmount = v;
                                setState(() {});
                              });
                        }),
                        commonRowWidget(context,
                            title: "Tax",
                            isNumber: true,
                            value:
                                '${bloc.invoiceDetailData.value.totalTaxAmount ?? 0.00}',
                            onTap: () {
                          AddNewItemDialog(
                              isAmt: true,
                              context: context,
                              title: "Edit Tax Amount",
                              hint: 'Enter Tax Amount',
                              label: 'Tax Amount${bloc.getCurrencySign()}',
                              oldValue: bloc.getFormetted(
                                  bloc.invoiceDetailData.value.totalTaxAmount ??
                                      "0.00"),
                              type: SheetType.none,
                              onPressed: (String v) {
                                debugPrint('F() called--->, $v');
                                bloc.invoiceDetailData.value.totalTaxAmount = v;
                                setState(() {});
                              });
                        }),
                        commonRowWidget(context,
                            title: "Tax Total",
                            isNumber: true,
                            value:
                                '${bloc.invoiceDetailData.value.netAmount ?? 0.00}',
                            onTap: () {
                          AddNewItemDialog(
                              isAmt: true,
                              context: context,
                              title: "Edit Tax Total",
                              hint: 'Enter Tax Total',
                              label: 'Tax Total${bloc.getCurrencySign()}',
                              oldValue: bloc.getFormetted(
                                  bloc.invoiceDetailData.value.netAmount ??
                                      "0.00"),
                              type: SheetType.none,
                              onPressed: (String v) {
                                debugPrint('F() called--->, $v');
                                bloc.invoiceDetailData.value.netAmount = v;
                                setState(() {});
                              });
                        }),
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
                        ValueListenableBuilder(
                          valueListenable: bloc.selectedValuePM,
                          builder: (context, value, child) {
                            return commonRowWidget(context,
                                title: "Payment method",
                                value: value, onTap: () {
                              CommonBottomSheetDialog(
                                  context: context,
                                  list: bloc.pmList,
                                  title: "Payment method",
                                  ItemId: bloc.getId(SheetType.paymentmethods),
                                  bottomSheetType: SheetType.paymentmethods,
                                  Addf: (String v) {},
                                  onItemSelected: (id, name) {
                                    debugPrint('onItemSelected---> $id, $name');
                                    bloc.SetName(
                                        id, name, SheetType.paymentmethods);
                                  }).Show();
                            });
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: bloc.selectedValuePT,
                          builder: (context, value, child) {
                            return commonRowWidget(context,
                                title: "Publish to", value: value, onTap: () {
                              CommonBottomSheetDialog(
                                  context: context,
                                  list: bloc.publishToList,
                                  title: "Publish to",
                                  ItemId: bloc.getId(SheetType.publishto),
                                  bottomSheetType: SheetType.publishto,
                                  Addf: (String v) {},
                                  onItemSelected: (id, name) {
                                    debugPrint('onItemSelected---> $id, $name');
                                    bloc.SetName(id, name, SheetType.publishto);
                                  }).Show();
                            });
                          },
                        ),
                        spacer(),
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
                          ),
                          controller: _eDescController,
                        ),
                        spacer(),
                        CommonButton(
                            content: "Submit",
                            bgColor: appTheme.buttonBgColor,
                            textColor: appTheme.buttonTextColor,
                            outlinedBorderColor: appTheme.buttonBgColor,
                            onPressed: () async {
                              if (bloc.isValid(context)) {
                                //collect all data...
                                bloc.invoiceDetailData.value
                                    .document_reference = _eDescController.text;
                                bool res = await bloc.updateScannedInvoice(
                                    bloc.invoiceDetailData.value.toJson(),
                                    context);
                                if (res) {
                                  Navigator.pop(context);
                                }
                              }
                            })
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  getLines() {
    return bloc.invoiceDetailData.value.line_item_count! == 0
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
                              ))).then((_) {
                    bloc.getLineItemList(context, widget.id);
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
                                  Text(
                                      "${bloc.selectedValueCurSign.value} ${bloc.invoiceDetailData.value.totalAmount}",
                                      style: TextStyle(
                                          color: appTheme.textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))
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
    return bloc.invoiceDetailData.value.line_item_count! == 0
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
                          builder: (context) => LineItemsListScreen(
                                currencySign: bloc.selectedValueCurSign.value,
                                id: bloc.invoiceDetailData.value.id ?? "",
                              )));
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
                                  Text(
                                      "${bloc.selectedValueCurSign.value} ${bloc.invoiceDetailData.value.totalAmount}",
                                      style: TextStyle(
                                          color: appTheme.textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))
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
    if (picked != null && picked != selectedDate) {
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
