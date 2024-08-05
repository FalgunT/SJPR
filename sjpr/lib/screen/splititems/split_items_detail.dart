import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/model/split_list_model.dart';
import 'package:sjpr/screen/invoice/invoice_detail_bloc.dart';
import 'package:sjpr/screen/splititems/split_items_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/textinput_utils.dart';
import 'package:sjpr/widgets/check_box.dart';
import 'package:sjpr/widgets/common_button.dart';
import 'package:sjpr/widgets/radio_button.dart';

class SplitItemsDetailScreen extends StatefulWidget {
  final SplitListData? splitListItemData;
  const SplitItemsDetailScreen({super.key, required this.splitListItemData});

  @override
  State<SplitItemsDetailScreen> createState() => _SplitItemsDetailScreenState();
}

class _SplitItemsDetailScreenState extends State<SplitItemsDetailScreen>
    implements Updater {
  SplitItemsBloc bloc = SplitItemsBloc();
  late InvoiceDetailBloc blocID;
  String selectedValue = "";
  String categoryValue = "";
  SplitListData? splitItemDetail;
  ValueNotifier<String> selectedValueC = ValueNotifier<String>("");

  final TextEditingController _eController = TextEditingController();
  List categoryList = [
    "None",
    "Accumulated Depreciation",
    "Ask My Accountant",
    "Buildings and Improvements",
    "Business Licenses and Permits",
    "Charitable Contributions",
    "Computer and Internet Expenses",
    "Counting Education",
    "Depreciation Expense"
  ];

  @override
  void initState() {
    /*  if (widget.id.isNotEmpty) {
      bloc.getSplitItemDetail(context, widget.id);
    }*/
    blocID = InvoiceDetailBloc(update: this);
    if (widget.splitListItemData != null) {
      splitItemDetail = widget.splitListItemData!;
    } else {
      splitItemDetail = SplitListData();
    }
    super.initState();
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
                  valueListenable: selectedValueC,
                  builder: (context, value, _) {
                    return commonRowWidget(context,
                        title: "Category", value: value, flag: 0);
                  }),
              commonRowWidget(context,
                  title: "Total Amount",
                  value: '${splitItemDetail?.totalAmount ?? 0.00}',
                  flag: 1),
              /*   commonRowWidget(
                  title: "Tax", value: "0.00", onTap: () {}, context: context),*/
              commonRowWidget(context,
                  title: "Total Tax Amount",
                  value: '${splitItemDetail?.totalAmount ?? 0.00}',
                  flag: 2),
              const SizedBox(
                height: 20,
              ),
              CommonButton(
                  textFontSize: 16,
                  content: "Save",
                  bgColor: buttonBgColor,
                  textColor: buttonTextColor,
                  outlinedBorderColor: buttonBgColor,
                  onPressed: () {})
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
                    child: ListView.builder(
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                            activeColor: activeTxtColor,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            contentPadding: const EdgeInsets.only(
                                left: 6, right: 0, bottom: 0, top: 0),
                            title: Text(
                              list[index],
                              style: TextStyle(
                                  color: selectedValue == list[index]
                                      ? activeTxtColor
                                      : textColor),
                            ),
                            value: list[index],
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                                if (bottomSheetType == "category") {
                                  categoryValue = selectedValue;
                                }
                              });
                              selectedValueC.value = categoryValue;
                            },
                          );
                        }),
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget commonRowWidget(BuildContext context,
      {required title, required value, required int flag, isAdd = false}) {
    return InkWell(
      onTap: () {
        if (flag == 0) {
          /*  singleSelectBottomSheet(
              context: context,
              list: categoryList,
              title: "Category",
              bottomSheetType: "category");*/
          _showPicker(context, flag, title, isAdd: isAdd);
        }
        if (flag == 1 || flag == 2) {
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

          return;
        }
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
              child: Text(
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

  Future<void> _showPicker(BuildContext context, int flag, String title,
      {isAdd = false}) async {
    var _list = await blocID.getCheckBoxList(flag);
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
                                /*_showAddProductDialog("Add Product/Service",
                                    'Enter product name', 'Product Name');*/
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
                        selectedCategoryIndex: blocID.selectedCategoryIndex,
                        items: _list,
                        f: (index, l) {
                          debugPrint('--->f() called');
                          blocID.selectedCategoryIndex = index;
                          blocID.selectedData = l;
                          debugPrint(
                              '--->Result: ${blocID.selectedData.toString()}');
                        },
                      )
                    : RadioButtonList(
                        items: _list,
                        f: (selected) {
                          CheckBoxItem item = selected;
                          if (flag == 1) {
                            for (var value in blocID.pList) {
                              if (value.id == item.itemId) {
                                blocID.selectedPData = value;
                                debugPrint(
                                    '--->Result: ${blocID.selectedPData.toString()}');
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

  @override
  updateWidget() {
    setState(() {});
  }
}
