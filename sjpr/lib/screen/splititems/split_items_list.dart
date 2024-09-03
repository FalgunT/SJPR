import 'package:flutter/material.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/model/split_list_model.dart';
import 'package:sjpr/screen/splititems/split_items_bloc.dart';
import 'package:sjpr/screen/splititems/split_items_detail.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/string_utils.dart';
import 'package:sjpr/widgets/common_button.dart';
import 'package:sjpr/widgets/delete_confirmation_dialog.dart';
import 'package:sjpr/widgets/empty_item_widget.dart';

class SplitItemsListScreen extends StatefulWidget {
  final String id;
  final String currencySign;
  final String? totalAmount;
  final String? totalTaxAmount;
  final bool isReadOnly;
  const SplitItemsListScreen(
      {super.key,
      required this.id,
      required this.currencySign,
      required this.totalAmount,
      required this.totalTaxAmount,
      required this.isReadOnly});
  @override
  State<SplitItemsListScreen> createState() => _SplitItemsListScreenState();
}

class _SplitItemsListScreenState extends State<SplitItemsListScreen> {
  SplitItemsBloc bloc = SplitItemsBloc.getNewInstance();
  bool? multipleSelected = false, isReadOnly = false;
  var remainingTotalAmount = 0.0;
  var remainingTotalTaxAmount = 0.0;
  @override
  void initState() {
    isReadOnly = widget.isReadOnly;
    bloc.scannedInvoiceId = widget.id;
    getData();
    super.initState();
  }

  void getData() async {
    await bloc.getDetailCategory(context);
    await bloc.getSplitItemList(context, widget.id);
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
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Split Items",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: activeTxtColor,
                        fontSize: 24),
                  ),
                  isReadOnly == false
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SplitItemsDetailScreen(
                                          currencySign: widget.currencySign,
                                          splitListItemData: null,
                                        )));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: backGroundColor,
                                border: Border.all(
                                    color: activeTxtColor, width: 2)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: activeTxtColor,
                                  size: 16,
                                ),
                                Text(
                                  "Add",
                                  style: TextStyle(
                                      color: activeTxtColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              Expanded(
                flex: 1,
                child: ValueListenableBuilder(
                    valueListenable: bloc.isWaitingForDetail,
                    builder: (context, value1, child) {
                      return ValueListenableBuilder(
                          valueListenable: bloc.splitItemListLocal,
                          builder: (context, value, _) {
                            remainingTotalAmount = 0.0;
                            remainingTotalTaxAmount = 0.0;
                            for (var element in value) {
                              element.totalAmount = bloc
                                  .getFormatted(element.totalAmount ?? "0.0")
                                  .replaceAll(',', '');
                              element.taxAmount = bloc
                                  .getFormatted(element.taxAmount ?? "0.0")
                                  .replaceAll(',', '');

                              remainingTotalAmount +=
                                  double.parse(element.totalAmount ?? "0.0");
                              remainingTotalTaxAmount +=
                                  double.parse(element.taxAmount ?? "0.0");
                            }
                            remainingTotalAmount = double.parse(bloc
                                    .getFormatted((widget.totalAmount ?? "0.0")
                                        .replaceAll(',', ''))) -
                                remainingTotalAmount;
                            remainingTotalTaxAmount = double.parse(
                                    bloc.getFormatted(
                                        (widget.totalTaxAmount ?? "0.0")
                                            .replaceAll(',', ''))) -
                                remainingTotalTaxAmount;

                            return (value.isEmpty)
                                ? value1 == false
                                    ? EmptyItemWidget(
                                        title: StringUtils.noSplitItems,
                                        detail: "")
                                    : Container()
                                : Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: ListView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: [
                                            multipleSelected!
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          _showDeleteConfirmationDialog(
                                                              context,
                                                              true,
                                                              SplitListData());
                                                        },
                                                        child: Container(
                                                          //margin: const EdgeInsets.all(10),
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          height: 40,
                                                          width: 150,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              color:
                                                                  backGroundColor,
                                                              border: Border.all(
                                                                  color:
                                                                      activeTxtColor,
                                                                  width: 2)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "Delete Multiple",
                                                                style: TextStyle(
                                                                    color:
                                                                        activeTxtColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container(),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Table(
                                              columnWidths: isReadOnly == true
                                                  ? const {
                                                      0: FlexColumnWidth(1.5),
                                                      1: FlexColumnWidth(3.5),
                                                      2: FlexColumnWidth(2),
                                                      3: FlexColumnWidth(2),
                                                    }
                                                  : const {
                                                      0: FlexColumnWidth(1.5),
                                                      1: FlexColumnWidth(3.5),
                                                      2: FlexColumnWidth(2),
                                                      3: FlexColumnWidth(2),
                                                      4: FlexColumnWidth(1.25),
                                                    },
                                              children: [
                                                TableRow(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: const Border(
                                                          bottom: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 4)),
                                                      color: listTileBgColor,
                                                    ),
                                                    children: [
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 10),
                                                          child: Text(
                                                            isReadOnly == true
                                                                ? "No"
                                                                : "",
                                                            style: TextStyle(
                                                              color: textColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10,
                                                                horizontal: 4),
                                                        child: Text(
                                                          "Category",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: textColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 10, 4, 10),
                                                          child: Text(
                                                            "Total Amount",
                                                            style: TextStyle(
                                                              color: textColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 10),
                                                          child: Text(
                                                            "Tax Amount",
                                                            style: TextStyle(
                                                              color: textColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      isReadOnly == true
                                                          ? Center(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        4),
                                                                child: Text(
                                                                  "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        textColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ]),
                                                for (int i = 0;
                                                    i < value.length;
                                                    i++)
                                                  getTableRows(i, value),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      isReadOnly == false
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 16),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Remaining Total Amount  :  ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: activeTxtColor,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  /*  Container(
                                              width:
                                                  MediaQuery.of(context).size.width * 0.35,
                                            ),*/
                                                  SizedBox(width: 16),
                                                  Text(
                                                    bloc.getFormatted(
                                                        remainingTotalAmount
                                                            .toString()),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: textColor,
                                                        fontSize: 18),
                                                  ),
                                                  SizedBox(width: 12),
                                                  Text(
                                                    bloc.getFormatted(
                                                        remainingTotalTaxAmount
                                                            .toString()),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: textColor,
                                                        fontSize: 18),
                                                  ),
                                                  SizedBox(width: 28),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      isReadOnly == false
                                          ? CommonButton(
                                              textFontSize: 16,
                                              content: "Save",
                                              bgColor: buttonBgColor,
                                              textColor: buttonTextColor,
                                              outlinedBorderColor:
                                                  buttonBgColor,
                                              onPressed: () {
                                                if (remainingTotalAmount ==
                                                        0.0 &&
                                                    remainingTotalTaxAmount ==
                                                        0.0) {
                                                  bloc
                                                      .updateSplitItemList(
                                                          context)
                                                      .then((onValue) {
                                                    Navigator.of(context)
                                                        .pop(onValue);
                                                  });
                                                } else {
                                                  CommonToast.getInstance()
                                                      ?.displayToast(
                                                          message:
                                                              "The total amount of insert and update actions does not match the invoice total amount.",
                                                          bContext: context);
                                                }
                                              })
                                          : Container()
                                    ],
                                  );
                          });
                    }),
              )
            ],
          ),
        ));
  }

  TableRow getTableRows(int index, List<SplitListData> value) {
    SplitListData valueSplitItem = value[index];
    return TableRow(
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(8),
          border: Border(
              /* right: BorderSide(
                                                color: listTileBgColor, width: 2),*/
              bottom: BorderSide(color: listTileBgColor, width: 2)),
          color: Colors.black,
        ),
        children: [
          isReadOnly == true
              ? Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 8, bottom: 10),
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                  ),
                )
              : Center(
                  child: Checkbox(
                      value: valueSplitItem.isSelected ?? false,
                      activeColor: activeTxtColor,
                      checkColor: buttonTextColor,
                      onChanged: (value1) {
                        var isAnySelected = false;
                        setState(() {
                          for (var element in value) {
                            if (element.id == valueSplitItem.id) {
                              element.isSelected = value1;
                            }
                            if (element.isSelected == true) {
                              isAnySelected = true;
                            }
                          }
                          multipleSelected = isAnySelected;
                        });
                      }),
                ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 8, bottom: 10),
              child: Text(
                //splitItem.categoryId ?? "",
                bloc.getCategoryNameFromId(valueSplitItem.categoryId ?? "") ??
                    "",
                textAlign: TextAlign.start,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 8, bottom: 10),
              child: Text(
                bloc.getFormatted(valueSplitItem.totalAmount ?? ""),
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                bloc.getFormatted(valueSplitItem.taxAmount ?? ""),
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
          ),
          isReadOnly == true
              ? Container()
              : Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: activeTxtColor,
                      ),
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      splashRadius: 0.5,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplitItemsDetailScreen(
                                      currencySign: widget.currencySign,
                                      splitListItemData: valueSplitItem,
                                    )));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: activeTxtColor,
                      ),
                      iconSize: 20,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      splashRadius: 1,
                      onPressed: () {
                        _showDeleteConfirmationDialog(
                            context, false, valueSplitItem);
                      },
                    ),
                  ],
                ),
        ]);
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, bool isMultiple, SplitListData valueSplitItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          label: 'Delete Split',
          onPressed: () {
            if (isMultiple) {
              bloc.deleteMultipleSplitItems();
            } else {
              bloc.deleteSplitItem(valueSplitItem);
            }
            Navigator.pop(context);
            setState(() {
              multipleSelected = false;
            });
          },
        );
      },
    );
  }
}

Widget commonRowWidget(
    {required title, required subtitle, required value, required onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: listTileBgColor,
      ),
      child: const ListTile(
        title: Text(""),
      ),
    ),
  );
}
