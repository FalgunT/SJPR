import 'package:flutter/material.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/model/split_list_model.dart';
import 'package:sjpr/screen/splititems/split_items_bloc.dart';
import 'package:sjpr/screen/splititems/split_items_detail.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/widgets/common_button.dart';
import 'package:sjpr/widgets/delete_confirmation_dialog.dart';

class SplitItemsListScreen extends StatefulWidget {
  final String id;
  final String currencySign;
  final String? totalAmount;
  final String? totalTaxAmount;
  const SplitItemsListScreen(
      {super.key,
      required this.id,
      required this.currencySign,
      required this.totalAmount,
      required this.totalTaxAmount});
  @override
  State<SplitItemsListScreen> createState() => _SplitItemsListScreenState();
}

class _SplitItemsListScreenState extends State<SplitItemsListScreen> {
  SplitItemsBloc bloc = SplitItemsBloc.getInstance();
  bool? multipleSelected = false;
  var remainingTotalAmount = 0.0;
  var remainingTotalTaxAmount = 0.0;
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    await bloc.getDetailCategory(context);
    await bloc.getSplitItemList(context, "142"); //widget.id);
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
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            StreamBuilder<List<SplitListData>?>(
                stream: bloc.splitItemListStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
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
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SplitItemsDetailScreen(
                                                  currencySign:
                                                      widget.currencySign,
                                                  splitListItemData: null,
                                                )));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: backGroundColor,
                                        border: Border.all(
                                            color: activeTxtColor, width: 2)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                ),
                              ],
                            ),
                            multipleSelected!
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _showDeleteConfirmationDialog(
                                              context, true, SplitListData());
                                        },
                                        child: Container(
                                          //margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          height: 40,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: backGroundColor,
                                              border: Border.all(
                                                  color: activeTxtColor,
                                                  width: 2)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Delete Multiple",
                                                style: TextStyle(
                                                    color: activeTxtColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
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
                            ValueListenableBuilder(
                                valueListenable: bloc.splitItemListLocal,
                                builder: (context, value, _) {
                                  remainingTotalAmount = 0.0;
                                  remainingTotalTaxAmount = 0.0;
                                  for (var element in value) {
                                    element.totalAmount =
                                        (element.totalAmount ?? "0")
                                            .replaceAll(',', '');
                                    element.taxAmount =
                                        (element.taxAmount ?? "0")
                                            .replaceAll(',', '');

                                    remainingTotalAmount += double.parse(
                                        element.totalAmount ?? "0");
                                    remainingTotalTaxAmount +=
                                        double.parse(element.taxAmount ?? "0");
                                  }
                                  remainingTotalAmount = double.parse(
                                          (widget.totalAmount ?? "0")
                                              .replaceAll(',', '')) -
                                      remainingTotalAmount;
                                  remainingTotalTaxAmount = double.parse(
                                          (widget.totalTaxAmount ?? "0")
                                              .replaceAll(',', '')) -
                                      remainingTotalTaxAmount;
                                  return Column(
                                    children: [
                                      Table(
                                        columnWidths: const {
                                          0: FlexColumnWidth(1.5),
                                          1: FlexColumnWidth(3.5),
                                          2: FlexColumnWidth(2),
                                          3: FlexColumnWidth(2),
                                          4: FlexColumnWidth(1.25),
                                          /* 5: FlexColumnWidth(1.25),*/
                                        },
                                        children: [
                                          TableRow(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: const Border(
                                                    bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 4)),
                                                color: listTileBgColor,
                                              ),
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10),
                                                    child: Text(
                                                      "",
                                                      style: TextStyle(
                                                        color: textColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 4),
                                                  child: Text(
                                                    "Category",
                                                    textAlign: TextAlign.start,
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10),
                                                    child: Text(
                                                      "Total Amount",
                                                      style: TextStyle(
                                                        color: textColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10),
                                                    child: Text(
                                                      "Tax Amount",
                                                      style: TextStyle(
                                                        color: textColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 4),
                                                    child: Text(
                                                      "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: textColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                /*   Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          vertical: 10),
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                          color: textColor,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),*/
                                              ]),
                                          for (var item in value)
                                            getTableRows(item, value),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 16),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: Text(
                                                "Remaining Total Amount  :  ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: activeTxtColor,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            /*  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.35,
                                  ),*/
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Text(
                                                bloc.getFormatted(
                                                    remainingTotalAmount
                                                        .toString()),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: textColor,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              child: Text(
                                                bloc.getFormatted(
                                                    remainingTotalTaxAmount
                                                        .toString()),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: textColor,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ],
                        ),
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
                              if (remainingTotalAmount == 0.0 &&
                                  remainingTotalTaxAmount == 0.0) {
                                bloc.updateSplitItemList(context);
                              } else {
                                CommonToast.getInstance()?.displayToast(
                                    message:
                                        "The total amount of insert and update actions does not match the invoice total amount.",
                                    bContext: context);
                              }
                            })
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Records found",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  TableRow getTableRows(
      SplitListData valueSplitItem, List<SplitListData> value) {
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
          Center(
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
                "${bloc.getCategoryNameFromId(valueSplitItem.categoryId ?? "") ?? ""}test test test etdlkskjf jkdj ",
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
          Column(
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
                  _showDeleteConfirmationDialog(context, false, valueSplitItem);
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
