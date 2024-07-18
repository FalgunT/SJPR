import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:sjpr/common/app_theme.dart';
import 'package:sjpr/model/invoice_detail_model.dart';
import 'package:sjpr/screen/invoice/invoice_detail_bloc.dart';
import 'package:sjpr/screen/lineitems/line_items.dart';
import 'package:sjpr/widgets/check_box.dart';
import 'package:sjpr/widgets/common_button.dart';
import '../../model/category_list_model.dart';
import '../../model/product_list_model.dart';
import '../../model/type_list_model.dart';
import '../../utils/color_utils.dart';
import '../../widgets/radio_button.dart';

class InvoiceDetailScreen extends StatefulWidget {
  final String id;

  const InvoiceDetailScreen({super.key, required this.id});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  final InvoiceDetailBloc bloc = InvoiceDetailBloc();
  SubCategoryData selectedData = SubCategoryData.empty();
  ProductServicesListData selectedPData = ProductServicesListData.empty();
  TypeListData selectedTData = TypeListData.empty();

  @override
  void initState() {
    bloc.getInvoiceDetail(context, widget.id);
    bloc.getLineItemList(context, widget.id);
    bloc.getDetailCategory(context, widget.id);
    bloc.getDetailType(context, widget.id);
    bloc.getDetailOwnBy(context, widget.id);
    bloc.getProductService(context, widget.id);
    super.initState();
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
          padding: const EdgeInsets.all(20),
          child: StreamBuilder<InvoiceDetailData?>(
            stream: bloc.invoiceDetailStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                var invoiceDetail = snapshot.data!;
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
                          ('${invoiceDetail.currency ?? ""} ${invoiceDetail.netAmount ?? ""}'),
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
                        value: selectedData.sub_category_name ?? "None",
                        flag: 0),
                    commonRowWidget(context,
                        title: "Product/Service",
                        value: selectedPData.productServicesName ?? "None",
                        flag: 1,
                        isAdd: true),
                    commonRowWidget(context,
                        title: "Type",
                        value: selectedTData.typeName ?? "None",
                        flag: 2),
                    commonRowWidget(context,
                        title: "Owned by",
                        value: invoiceDetail.supplierName,
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
                        value: invoiceDetail.currency ?? 'None',
                        flag: 0),
                    commonRowWidget(context,
                        title: "Total",
                        value: '\u{20AC} ${invoiceDetail.totalAmount ?? 0.00}',
                        flag: 0),
                    commonRowWidget(context,
                        title: "Tax",
                        value:
                            '\u{20AC} ${invoiceDetail.totalTaxAmount ?? 0.00}',
                        flag: 0),
                    commonRowWidget(context,
                        title: "Tax total",
                        value: '\u{20AC} ${invoiceDetail.netAmount ?? 0.00}',
                        flag: 0),
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
                        title: "Payment method", value: "Mastercard", flag: 0),
                    commonRowWidget(context,
                        title: "Publish to", value: "Credit Card", flag: 0),
                    const SizedBox(
                      height: 10,
                    ),
                    ExpansionTile(
                      iconColor: appTheme.activeTxtColor,
                      collapsedIconColor: appTheme.activeTxtColor,
                      title: Text(
                        "Description",
                        style: TextStyle(
                            color: appTheme.activeTxtColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 150,
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromRGBO(39, 40, 44, 2)),
                          child: Text(
                            "Posted invoice",
                            style: TextStyle(
                                color: appTheme.textColor, fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        /*  CommonButton(
                            content: "Publish description",
                            bgColor: appTheme.backGroundColor,
                            textColor: appTheme.activeTxtColor,
                            outlinedBorderColor: appTheme.buttonBgColor,
                            onPressed: () {}),
                        const SizedBox(
                          height: 20,
                        )*/
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ExpansionTile(
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
                        Container(
                            padding: const EdgeInsets.all(20),
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromRGBO(39, 40, 44, 2)),
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
                                            child: Text("Consult line items",
                                                style: TextStyle(
                                                    color: appTheme.textColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          const Text("12 line items",
                                              style: TextStyle(
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
                                            child: Text("Total items",
                                                style: TextStyle(
                                                  color: appTheme.textColor,
                                                  fontSize: 16,
                                                )),
                                          ),
                                          Text("\u{20AC} 6.11",
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
                        const SizedBox(
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
                            }),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                        content: "Submit",
                        bgColor: appTheme.buttonBgColor,
                        textColor: appTheme.buttonTextColor,
                        outlinedBorderColor: appTheme.buttonBgColor,
                        onPressed: () {})
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
          _selectDate(context);
          return;
        }

        if (flag != 3) _showPicker(context, flag, title, isAdd: isAdd);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: appTheme.listTileBgColor,
        ),
        child: Row(
          children: [
            Expanded(
                child: Text(
              title,
              style: TextStyle(
                  color: appTheme.textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            )),
            Text(
              value,
              style: TextStyle(color: appTheme.textColor, fontSize: 17),
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
                                setState(() {});
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
                            SizedBox(
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
                        items: _list,
                        f: (l) {
                          debugPrint('--->f() called');
                          selectedData = l;
                          debugPrint('--->Result: ${selectedData.toString()}');
                        },
                      )
                    : RadioButtonList(
                        items: _list,
                        f: (selected) {
                          CheckBoxItem item = selected;
                          for (var value in bloc.pList) {
                            if (value.id == item.itemId) {
                              selectedPData = value;
                              debugPrint(
                                  '--->Result: ${selectedPData.toString()}');
                              break;
                            }
                          }
                        },
                      ),
              ],
            ),
          );
        });
  }

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        // initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
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
}
