import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sjpr/common/AppEnums.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/model/split_list_model.dart';
import 'package:sjpr/screen/invoice/invoice_detail_bloc.dart';
import 'package:sjpr/screen/splititems/split_items_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/textinput_utils.dart';
import 'package:sjpr/widgets/AddNewItemDialog.dart';
import 'package:sjpr/widgets/CommonBottomSheetDialog.dart';
import 'package:sjpr/widgets/common_button.dart';
import 'package:sjpr/widgets/expandable_radio_list.dart';

class SplitItemsDetailScreen extends StatefulWidget {
  final String currencySign;
  final SplitListData? splitListItemData;
  const SplitItemsDetailScreen(
      {super.key, required this.splitListItemData, required this.currencySign});

  @override
  State<SplitItemsDetailScreen> createState() => _SplitItemsDetailScreenState();
}

class _SplitItemsDetailScreenState extends State<SplitItemsDetailScreen> {
  SplitItemsBloc bloc = SplitItemsBloc.getInstance();
  TextEditingController eController = TextEditingController();
  late InvoiceDetailBloc blocID;
  String selectedValue = "";
  String categoryValue = "";

  @override
  void initState() {
    bloc.getDetailCategory(context);

    blocID = InvoiceDetailBloc();
    if (widget.splitListItemData != null) {
      bloc.splitItemDetail.value = widget.splitListItemData!;
    } else {
      bloc.splitItemDetail.value = SplitListData();
      bloc.selectedValueC = ValueNotifier<String>("None");
    }
    super.initState();
  }

  getCurrency() {
    if (widget.currencySign.isEmpty) {
      return '';
    }
    return ' (${widget.currencySign})';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Split Item",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: activeTxtColor,
                        fontSize: 24),
                  ),
                  /*   CommonButton(
                      textFontSize: 16,
                      height: 30,
                      content: "Delete",
                      bgColor: backGroundColor,
                      textColor: activeTxtColor,
                      outlinedBorderColor: activeTxtColor,
                      onPressed: () {})*/
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                  valueListenable: bloc.selectedValueC,
                  builder: (context, value, _) {
                    return commonRowWidget(
                      title: "Category",
                      value: value,
                      context: context,
                      onTap: () {
                        CommonBottomSheetDialog(
                            context: context,
                            list: bloc.categoryList,
                            title: "Category",
                            ItemId: getCategoryId(),
                            bottomSheetType: SheetType.category,
                            Addf: () {},
                            onItemSelected: (id, name) {
                              SetName(id, name, SheetType.category);
                            }).Show();
                      },
                    );
                  }),
              commonRowWidget(
                title: "Total Amount",
                value: bloc
                    .getFormatted(bloc.splitItemDetail.value.totalAmount ?? ""),
                context: context,
                onTap: () {
                  AddNewItemDialog(
                      isAmt: true,
                      context: context,
                      title: "Edit Total Amount",
                      hint: 'Enter Total Amount',
                      label: 'Total Amount${getCurrency()}',
                      oldValue: bloc.getFormatted(
                          bloc.splitItemDetail.value.totalAmount ?? "0.00"),
                      type: SheetType.none,
                      onPressed: (String v) {
                        debugPrint('F() called--->, $v');
                        bloc.splitItemDetail.value.totalAmount = v;
                        setState(() {});
                      });
                },
              ),
              commonRowWidget(
                  title: "Total Tax Amount",
                  value: bloc
                      .getFormatted(bloc.splitItemDetail.value.taxAmount ?? ""),
                  context: context,
                  onTap: () {
                    AddNewItemDialog(
                        isAmt: true,
                        context: context,
                        title: "Edit Tax Amount",
                        hint: 'Enter Tax Amount',
                        label: 'Tax Amount${getCurrency()}',
                        oldValue: bloc.getFormatted(
                            bloc.splitItemDetail.value.taxAmount ?? "0.00"),
                        type: SheetType.none,
                        onPressed: (String v) {
                          debugPrint('F() called--->, $v');
                          bloc.splitItemDetail.value.taxAmount = v;
                          setState(() {});
                        });
                  }),
              const SizedBox(
                height: 20,
              ),
              CommonButton(
                  textFontSize: 16,
                  content: "Save",
                  bgColor: buttonBgColor,
                  textColor: buttonTextColor,
                  outlinedBorderColor: buttonBgColor,
                  onPressed: () {
                    if (isValid()) {
                      if (bloc.splitItemDetail.value.id != null &&
                          bloc.splitItemDetail.value.id!.isNotEmpty) {
                        bloc.updateSplitItem(bloc.splitItemDetail.value);
                        CommonToast.getInstance()?.displayToast(
                            message:
                                'Split Item updated Locally. Please Click on "Save" to keep it permanent',
                            bContext: context);
                      } else if (bloc.splitItemDetail.value.action != null &&
                          bloc.splitItemDetail.value.action!.isNotEmpty) {
                        bloc.updateSplitItem(bloc.splitItemDetail.value);
                        CommonToast.getInstance()?.displayToast(
                            message:
                                'Split Item updated Locally. Please Click on "Save" to keep it permanent',
                            bContext: context);
                      } else {
                        bloc.addSplitItem(bloc.splitItemDetail.value);
                        CommonToast.getInstance()?.displayToast(
                            message:
                                'Split Item added Locally. Please Click on "Save" to keep it permanent',
                            bContext: context);
                      }
                      Navigator.pop(context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  singleSelectBottomSheet({
    required context,
    required list,
    required title,
    required bottomSheetType,
  }) {
    return showModalBottomSheet(
        backgroundColor: Colors.black,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              /*_showAddProductDialog("Add $title",
                                  'Enter $title Name', '$title Name',
                                  type: bottomSheetType);*/
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
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: textColor,
                              ))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: textColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: const Color.fromRGBO(44, 45, 51, 1),
                        filled: true,
                        hintText: "Search",
                        hintStyle: TextStyle(color: textColor)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ExpandableRadioList(
                      catList: bloc.categoryList,
                      f: (id, name) {
                        debugPrint('--->f() called');
                        /* bloc.lineitemdetail.value.categoryId = '$id';
                        bloc.selectedValueC.value = name;*/
                      },
                      selectedId: getCategoryId(),
                      // onItemAdded: (String item, String id) {},
                      onItemAdded: (String item, String id) {
                        bloc.addSubcategory(context, id, item);
                      },
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  getCategoryId() {
    String catid = '0';
    if ((bloc.splitItemDetail.value.categoryId ?? "").isEmpty) {
      catid = '0';
    } else {
      catid = bloc.splitItemDetail.value.categoryId ?? "0";
    }
    return int.parse(catid);
  }

  void SetName(id, name, bottomSheetType) {
    if (bottomSheetType == SheetType.category) {
      bloc.splitItemDetail.value.categoryId = '$id';
      bloc.selectedValueC.value = name;
    }
  }

  bool isValid() {
    String catId = bloc.splitItemDetail.value.categoryId ?? "";
    if (catId == "") {
      CommonToast.getInstance()?.displayToast(
          message: "Category field is required", bContext: context);
      return false;
    }
    String total =
        (bloc.splitItemDetail.value.totalAmount ?? "").replaceAll(',', '');
    if (total.isEmpty || (double.parse(total) == 0.0)) {
      CommonToast.getInstance()?.displayToast(
          message: "Total Amount field is required", bContext: context);
      return false;
    }
    String tax = bloc.splitItemDetail.value.taxAmount ?? "";
    if (tax.isEmpty) {
      CommonToast.getInstance()?.displayToast(
          message: "Tax Amount field is required", bContext: context);
      return false;
    }
    return true;
  }

  getTextFormatter(bool isAmt) {
    List<TextInputFormatter> formatters = [];
    if (isAmt) {
      formatters.add(
        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
      );
      formatters.add(DecimalTextInputFormatter(decimalRange: 2));
    } else {
      formatters.add(FilteringTextInputFormatter.singleLineFormatter);
    }
    return formatters;
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

  Widget commonRowWidget(
      {required title,
      required value,
      required onTap,
      bool isAmt = false,
      required context}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: listTileBgColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: isAmt
                  ? Text(
                      '${widget.currencySign} $value',
                      style: TextStyle(color: textColor, fontSize: 17),
                      textAlign: TextAlign.end,
                    )
                  : Text(
                      value,
                      style: TextStyle(color: textColor, fontSize: 17),
                      textAlign: TextAlign.end,
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: textColor,
            )
          ],
        ),
      ),
    );
  }
}
